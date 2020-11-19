<div align="center">
    <h1>:package_name</h1>
    <p align="center"> 
        <a href="https://packagist.org/packages/:vendor_name/:package_name"><img alt="Stable Release" src="https://img.shields.io/packagist/v/:vendor_name/:package_name.svg?style=flat-square&label=release&logo=packagist&logoColor=eceff4&colorA=4c566a&colorB=5e81ac"></a>
        <a href="https://github.com/:vendor_name/:repo_name/actions?query=workflow%3Arun-tests"><img alt="Build Status" src="https://img.shields.io/github/workflow/status/:vendor_name/:repo_name/tests.svg?style=flat-square&label=build&logo=github&logoColor=eceff4&colorA=4c566a&colorB=88c0d0"></a>
        <a href="https://php.net/releases"><img alt="PHP Version" src="https://img.shields.io/packagist/php-v/:vendor_name/:package_name.svg?style=flat-square&label=php&logo=php&logoColor=eceff4&colorA=4c566a&colorB=b48ead"></a>
        <a href="https://codeclimate.com/github/:vendor_name/:repo_name"><img alt="Maintainability" src="https://img.shields.io/codeclimate/maintainability/:vendor_name/:repo_name.svg?style=flat-square&label=maintainability&logo=code-climate&logoColor=eceff4&colorA=4c566a&colorB=88c0d0"></a>
        <a href="https://codeclimate.com/github/:vendor_name/:repo_name"><img alt="Test Coverage" src="https://img.shields.io/codeclimate/coverage/:vendor_name/:repo_name.svg?style=flat-square&label=coverage&logo=code-climate&logoColor=eceff4&colorA=4c566a&colorB=88c0d0"></a>
        <a href="https://packagist.org/packages/:vendor_name/:package_name"><img alt="Total Downloads" src="https://img.shields.io/packagist/dt/:vendor_name/:package_name.svg?style=flat-square&label=downloads&logoColor=eceff4&colorA=4c566a&colorB=88c0d0"></a>
        <a href="https://github.com/:vendor_name/:repo_name/blob/master/LICENSE.md"><img alt="License" src="https://img.shields.io/github/license/:vendor_name/:repo_name.svg?style=flat-square&label=license&logoColor=eceff4&colorA=4c566a&colorB=a3be8c"></a>
    </p>
</div>
<hr>

**Note:** Run `./configure.sh` to configure your new package or manually replace `:author_name`, `:author_username`, `:author_email`, `:vendor_name`, `:composer_vendor`, `:package_name`, `:composer_package`, `:package_description`, `:repo_account`, `:repo_name` and `:security_email` with their correct values in 
[README.md](README.md), [SECURITY.md](.github/SECURITY.md), [composer.json](composer.json), [source files](src), [test files](tests) and then delete this line.

:package_description

## Installation

>Requirements:
>- [PHP 7.4+](https://php.net/releases)

Install this package using Composer:

```bash
composer require :vendor_name/:package_name
```

## Usage

To get more in-depth knowledge about this package, please refer to the [Official Documentation](docs).

## Changelog

Please refer to the [CHANGELOG.md](CHANGELOG.md) file for more information about what has changed recently.

## Contributing

Contributions to this project are accepted and encouraged. Please read the [CONTRIBUTING.md](.github/CONTRIBUTING.md) file for details on contributions.

## Testing

To test this package run:

``` bash
composer test
```

To find out the test coverage run:

``` bash
composer coverage
```

To find issues by statically analyzing the code run:

``` bash
composer analyse
```

To get code insights run:

``` bash
composer insights
```

To fix styling issues run:

``` bash
composer format
```

## Credits

- [:author_name](https://github.com/:author_username)
- [All Contributors](../../contributors)

## Security Vulnerabilities

Please review our [security policy](../../security/policy) to know how to report security vulnerabilities within this package.

## Support the development

Do you like this project? Support it by becoming a [sponsor](https://github.com/sponsors/:author_username)!

If you prefer just <a href="https://www.buymeacoffee.com/axelitus"><img src="docs/assets/images/buy-me-a-coffee.svg" width="180" alt="Buy me a coffee"></img></a>

## License

This package is open-sourced software licensed under the [MIT](LICENSE.md) license.
