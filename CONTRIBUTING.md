# Contributing

These are the guidelines for contributing to this repository.

## Issues

File an issue if you think you've found a [bug](https://en.wikipedia.org/wiki/Software_bug). Please describe the following:

1. What version of the involved component was used
2. What environment was the component used in (OS, Perl version etc.)
3. What was expected
4. What actually occurred
5. What had to be done to reproduce the issue

Please use the [issue template](https://github.com/jonasbn/terms_and_conditions_as_a_service_poc/blob/master/.github/ISSUE_TEMPLATE.md).

## Patches

Patches for fixes, features, and improvements are accepted via pull requests.

Pull requests should be based on the **master** branch, unless you want to contribute to an active branch for a specific topic.

Please use the [PR template](https://github.com/jonasbn/terms_and_conditions_as_a_service_poc/blob/master/.github/PULL_REQUEST_TEMPLATE.md).

Coding guidelines are basic, please use:

- [EditorConfig](http://editorconfig.org/) configuration included in repository as `.editorconfig`
- [PerlTidy](http://perltidy.sourceforge.net/) configuration included in repository as `.perlcriticrc`

For other coding conventions please see the Perl::Critic configuration in: `t/perlcriticrc`.

And if you are really adventurous, you are most welcome to read [my general coding conventions](https://gist.github.com/jonasbn/c2f703c68340384cfc61bb9c38adb2ff) (WIP).

Do note that the repository uses [probot](https://probot.github.io/), The [`TODO bot`](https://probot.github.io/apps/todo/) will the create a GitHub issue automatically upon `push` to the repository if the guidelines are followed.

All contributions are welcome and most will be accepted.

## Licensing and Copyright

Please note that accepted contributions are included in the repository and hence under the same license as the repository contributed to.
