#!/bin/bash
# borrowed some code from https://github.com/vandot/casbab and https://github.com/spatie/package-skeleton-laravel

# 'return' when run as "source <script>" or ". <script>", 'exit' otherwise
[[ "$0" != "${BASH_SOURCE[0]}" ]] && safe_exit="return" || safe_exit="exit"

script_name=$(basename "$0")

function ask_question() {
    # ask_question "<question>" <default> : string
    local answer
    read -r -p "$1 ($2): " answer
    echo "${answer:-$2}"
}

function confirm() {
    # confirm "<question>" : bool
    local answer
    read -r -p "$1 (y/N): " -n 1 answer # defaults to No
    echo " "
    [[ "$answer" =~ ^[Yy]$ ]]
}

function normalize() {
    # normalize "<text>" : string
    # returns the normalized string (all lower case with space as separator)
    arg=("${@:-}")
    tags=""
    for i in '_' '-' ' '; do
        if [[ ${arg[*]} == *$i* ]]; then
            tags="yes"
            echo "${arg[*]}" | tr '[:upper:]' '[:lower:]' | tr -s "${i}" ' '
        fi
    done

    # If '_','-' and ' ' are not used as a separator try by case
    if [[ -z $tags ]] && [[ ${arg[0]} != '' ]]; then
        parse "${@:-}" | tr '[:upper:]' '[:lower:]'
    fi
}

function check_case() {
    # check_case "<text>" : bool (0 for upper, 1 for lower)
    if [[ ${1:-} == [[:upper:]] ]]; then
        echo 0
    elif [[ ${1:-} == [[:lower:]] ]]; then
        echo 1
    fi
}

function parse() {
    # parse "<text>" : string
    # parses string char by char
    arg=("${@:-}")
    helper=""
    for ((i = 0; i < ${#arg}; i++)); do
        if [[ $i == 0 ]]; then
            helper="${arg:$i:1}"
        elif ([[ $(check_case "${arg:$i:1}") == 0 ]] && [[ $(check_case "${arg:((i + 1)):1}") == 1 ]]) || ([[ $(check_case "${arg:$i:1}") == 0 ]] && [[ $(check_case "${arg:((i - 1)):1}") == 1 ]]); then
            helper="${helper} ${arg:$i:1}"
        elif [[ $i == [^a-zA-Z] ]] || [[ $(check_case "${arg:$i:1}") == $(check_case "${arg:((i - 1)):1}") ]] || ([[ $(check_case "${arg:$i:1}") == 1 ]] && [[ $(check_case "${arg:((i - 1)):1}") == 0 ]]); then
            helper="${helper}${arg:$i:1}"
        else
            echo "Unknown character: ${arg:$i:1}"
            exit 1
        fi
    done
    echo "${helper}"
}

first_up() {
    # Set first letter upper in a single word
    helper=${1}
    echo "$(tr '[:lower:]' '[:upper:]' <<<"${helper:0:1}")${helper:1}"
}

function kebab() {
    # kebab "<text>"
    normalize "${@:-}" | tr -s ' ' "-"
}

function pascal() {
    # pascal "<text>"
    # returns the text as pascal case with space separator
    arg=($(normalize "${@:-}"))
    if [[ ${#arg[@]} -eq 0 ]]; then
        echo ' '
        exit 0
    fi
    helper=""
    COUNTER=0
    for i in "${arg[@]}"; do
        if [[ $COUNTER == 0 ]]; then
            helper=$(first_up "${i}")
        else
            helper="${helper} $(first_up "${i}")"
        fi
        COUNTER=$((COUNTER + 1))
    done
    echo "${helper}" | tr -d ' '
}

# Author Name
git_name=$(git config user.name)
author_name=$(ask_question "Author name" "$git_name")

# Author Email
git_email=$(git config user.email)
author_email=$(ask_question "Author email" "$git_email")

# Author Github User
username_guess=${author_name//[[:blank:]]/}
author_username=$(ask_question "Author Github username" "$username_guess")

# Vendor Name
vendor_name_unsanitized=$(ask_question "Vendor name" "$(pascal "$author_username")")
vendor_name="$(tr '[:lower:]' '[:upper:]' <<<"${vendor_name_unsanitized:0:1}")${vendor_name_unsanitized:1}"
vendor_pascal=$(pascal "$vendor_name")
vendor_kebab=$(kebab "$vendor_name")

# Package Name
current_directory=$(pwd)
folder_name=$(basename "$current_directory")
package_name=$(ask_question "Package name" "$(pascal "$folder_name")")
package_pascal=$(pascal "$package_name")
package_kebab=$(kebab "$package_name")

# Package Description
package_description=$(ask_question "Package description" "")

## Repo Name
repo_account=$(ask_question "Repo account" "$vendor_kebab")
repo_name=$(ask_question "Repo name" "$folder_name")

## Security email
security_email=$(ask_question "Security policy email" "$author_email")

echo
echo -e "Information given:"
echo -e "  Author:"
echo -e "    Name: $author_name"
echo -e "    Email: $author_email"
echo -e "    Github username: $author_username"
echo -e "  Vendor:"
echo -e "    Name: $vendor_name"
echo -e "    Pascal: $vendor_pascal"
echo -e "    Kebab: $vendor_kebab"
echo -e "  Package:"
echo -e "    Name: $package_name"
echo -e "    Pascal: $package_pascal"
echo -e "    Kebab: $package_kebab"
echo -e "    Description: $package_description"
echo -e "  Composer: $vendor_kebab/$package_kebab"
echo -e "  Namespace: $vendor_pascal\\$package_pascal"
echo -e "  Repo: https://github.com/$repo_account/$repo_name"
echo -e "  Security policy email: $security_email"
echo

#package_name_underscore=$(echo "-$package_name-" | tr '-' '_')
echo "This script will replace the above values in all relevant files in the project directory."
if ! confirm "Modify files?"; then
    $safe_exit 1
fi

files=$(grep -E -r -l -i ":author|:vendor|__Vendor__|:package|__Package__|:composer|:repo|:security" --exclude-dir=vendor --exclude-dir=.git --exclude-dir=.idea . | grep -v "$script_name")
echo

for file in $files; do
    echo "Updating file $file"
    temp_file="$file.temp"

    sed <"$file" \
        "s/:author_name/$author_name/g" |
        sed "s/:author_username/$author_username/g" |
        sed "s/:author_email/$author_email/g" |
        sed "s/:vendor_name/$vendor_name/g" |
        sed "s/__Vendor__/$vendor_pascal/g" |
        sed "s/:vendor_kebab/$vendor_kebab/g" |
        sed "s/:package_name/$package_name/g" |
        sed "s/__Package__/$package_pascal/g" |
        sed "s/:package_kebab/$package_kebab/g" |
        sed "s/:package_description/$package_description/g" |
        sed "s/:repo_account/$repo_account/g" |
        sed "s/:repo_name/$repo_name/g" |
        sed "s/:security_email/$security_email/g" |
        sed "/^\*\*Note:\*\* Run/d" \
            >"$temp_file"
    rm -f "$file"
    new_file=$(echo $file | sed -e "s/__Package__/${package_pascal}/g")
    mv "$temp_file" "$new_file"
done

if confirm "Execute composer install and run all checks"; then
    composer install && composer all
fi

if confirm 'Let this script delete itself (since you only need it once)?'; then
    echo "Delete $0 !"
    rm -- "$0"
fi
