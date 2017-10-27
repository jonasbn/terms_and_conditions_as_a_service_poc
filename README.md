# Terms and Conditions as a Service Proof of Concept
_- aka `tac_as_poc`_

# Table of Contents

<!-- MarkdownTOC -->

- [Introduction](#introduction)
- [Operations](#operations)
- [Downloads](#downloads)
- [Development](#development)
- [License](#license)

<!-- /MarkdownTOC -->

<a name="introduction"></a>
# Introduction

This service is a basic prototype of a service to serve Terms and Conditions, while adhering to the below requirements.

The idea from the prototype came from an idea of mine, while pondering over the issues with serving Terms and Conditions.

1. The terms and conditions has to be available in a preservable format (I am not a legal specialist, so I do not know the exact wording, but this is the way it was explained to me)
2. The terms and conditions have to be available to the end-user in the revision/version, originally presented to the user

In addition, the following, more basic, requirements also have to be met:

1. We want to be able to link to the current Terms and Conditions, so you can find them via a website
2. We want to be able to link to specific revisions so we can create links for websites
3. We want to be able to communicate the Terms and Conditions via email, without sending the complete Terms and Conditions, but just providing a link
4. We want to support both Danish and English

The prototype offer the following:

- Terms and Conditions can be downloaded as a PDF and this has been accepted as a preservable format
- You can link to an exact revision, for building lists for example
- You can link with a date parameter, which will give you the revision relevant for the given date
- You can link to the service and get the current revision of the Terms and Conditions
- You can point to a given translation of the document in the URL by using the language indication `da` for Danish and  `en` for English.

<a name="operations"></a>
# Operations

The service can be run in 3 modes:

- server
- ci
- unittest
- shell

```shell
$ ./docker-run.sh «mode»
```

Server is the primary mode, which simply starts a webserver, which can be accessed on the address:

```shell
http://localhost:3000
```

<a name="downloads"></a>
# Downloads

<a name="development"></a>
# Development

<a name="license"></a>
# License 

The software is provided under the MIT license, please see the separate license file.
