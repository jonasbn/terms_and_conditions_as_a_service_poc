# Terms and Conditions as a Service Proof of Concept
_- aka `tac_as_poc`_

# Table of Contents

<!-- MarkdownTOC -->

- [Introduction](#introduction)
- [Services](#services)
	- [get current terms and conditions by default language](#get-current-terms-and-conditions-by-default-language)
	- [get current terms and conditions by language](#get-current-terms-and-conditions-by-language)
	- [get terms and conditions by default language and date](#get-terms-and-conditions-by-default-language-and-date)
	- [get terms and conditions by language and date](#get-terms-and-conditions-by-language-and-date)
	- [get terms and conditions by default language and revision](#get-terms-and-conditions-by-default-language-and-revision)
	- [get terms and conditions by language and revision](#get-terms-and-conditions-by-language-and-revision)
	- [get default page](#get-default-page)
	- [get default page by language](#get-default-page-by-language)
- [Installation](#installation)
	- [Requirements](#requirements)
- [Operations](#operations)
	- [carton](#carton)
	- [Docker](#docker)
- [Development](#development)
- [License](#license)

<!-- /MarkdownTOC -->

<a name="introduction"></a>
# Introduction

The idea for the prototype came, while pondering over the issues with serving Terms and Conditions.

This service is a basic prototype of a service to serve Terms and Conditions, while adhering to the a set of specific requirements.

1. The terms and conditions has to be available in a preservable format (I am not a legal specialist, so I do not know the exact wording, but this is the way it was explained to me and the PDF format meets this requirement)
2. The terms and conditions have to be available to the end-user in the revision/version, originally presented to the user at the time of accept

In addition, the following, more basic, requirements also have to be met:

1. We want to be able to link to the current Terms and Conditions, so you can find them via a website
2. We want to be able to link to specific revisions so we can create historic links for websites
3. We want to be able to communicate the Terms and Conditions via email, without sending the complete Terms and Conditions, but just providing a link
4. We want to support both Danish and English

The prototype service offer the following:

- Terms and Conditions can be downloaded as a PDF and this has been accepted as a preservable format
- You can link to an exact revision, for building lists for example
- You can link with a date parameter, which will provide you with the revision relevant for the given date
- You can link to the service and get the current revision of the Terms and Conditions, which will provide you with a specific revision
- You can point to a given translation of the document in the URL by using the language indication `da` for Danish and  `en` for English.

<a name="services"></a>
# Services

<a name="get-current-terms-and-conditions-by-default-language"></a>
## get current terms and conditions by default language

    /terms_and_conditions

<a name="get-current-terms-and-conditions-by-language"></a>
## get current terms and conditions by language

    /:language/terms_and_conditions

Example:

    /en/terms_and_conditions

<a name="get-terms-and-conditions-by-default-language-and-date"></a>
## get terms and conditions by default language and date

    /terms_and_conditions/:date

Example:

    /terms_and_conditions/20171208

<a name="get-terms-and-conditions-by-language-and-date"></a>
## get terms and conditions by language and date

    /:language/terms_and_conditions/:date

Example:

    /en/terms_and_conditions/20171208

<a name="get-terms-and-conditions-by-default-language-and-revision"></a>
## get terms and conditions by default language and revision

    /terms_and_conditions/revision/:revision

Example:

    /terms_and_conditions/revision/5

<a name="get-terms-and-conditions-by-language-and-revision"></a>
## get terms and conditions by language and revision

    /:language/terms_and_conditions/revision/:revision

Example:

    /en/terms_and_conditions/revision/5

<a name="get-default-page"></a>
## get default page

    /

<a name="get-default-page-by-language"></a>
## get default page by language

    /:language

Example:

    /da

<a name="installation"></a>
# Installation

If you want to run the application via **Docker** you can skip the installation section and go directly to [Operations](#operations).

<a name="requirements"></a>
## Requirements

The service requires **Perl**

Please see the `cpanfile` for the required **Perl** dependencies.

<a name="operations"></a>
# Operations

<a name="carton"></a>
## carton

The service can be run wit or without **Docker**, for **Docker** see further down.

```shell
$ carton exec -- morbo script/tac
```

```
http://localhost:3000
```

<a name="docker"></a>
## Docker

The **Docker** image can be run in 3 modes:

- `server`
- `ci`
- `unittest`
- `shell`

If you build locally based on the GitHub repository.

```bash
$ ./docker-run.sh «mode»
```

`server` is the primary and default mode, which simply starts a webserver, which can be accessed via the address:

```
http://localhost:3000
```

### Docker Hub

If you want to run it via **Docker Hub** (in server mode)

```bash
$ docker run --rm -p 3000:3000 jonasbn/tac_as_poc
```

Which simply starts a webserver, which can be accessed via the address:

```
http://localhost:3000
```

<a name="development"></a>
# Development

Please see the [contribution guidelines](CONTRIBUTING.md).

<a name="license"></a>
# License 

The software is provided under the MIT license, please see the separate license file.
