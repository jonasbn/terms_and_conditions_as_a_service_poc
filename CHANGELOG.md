# Change log for Terms and Conditions as a service POC

## 0.2.0 2020-06-29 Maintenance release, update not required

- dependabot created PR for updating perl in `Dockerfile` from 5.30.3 to 5.32.0
- Moved App::Prove::Watch to development recommendation instead of distribution dependency
- Exchanged TryCatch for Try::Tiny, since Devel::Declare has been deprecated
- Bumped Mojolicious dependency in `cpanfile.snapshot` from 7.03 to 8.56
- Exchanged regular Perl base image for a _slim_ version (5.32.0-slim)
- Corrected `Dockerfile` to build using `cpanfile.snapshot` instead of `cpanfile`

## 0.1.0 2020-06-06 Maintenance release, update not required

- dependabot created PR for updating perl in `Dockerfile` from 5.26 to 5.30.3

## 0.0.2 2018-08-23 Bug fix release, update recommended

- Docker image extended with USER directive to address potential security issue
  [#1](https://github.com/jonasbn/terms_and_conditions_as_a_service_poc/issues/1)

## 0.0.1 2017-12-09 Feature release

- Initial releases, implementing:

  - get current terms and conditions by default language
  - get current terms and conditions by language
  - get terms and conditions by default language and date
  - get terms and conditions by language and date
  - get terms and conditions by default language and revision
  - get terms and conditions by language and revision
  - get default page
  - get default page by language

  - and the service framework of course
