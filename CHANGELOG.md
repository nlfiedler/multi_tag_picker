# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).
This file follows the convention described at
[Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

## [Unreleased]
**BREAKING CHANGES**
### Renamed from `flutter_tagging_plus` to `multi_tag_picker`.
- Resetting the version number to `1.0.0` to reflect name change.
### Changed
* `onChanged()` now receives an immutable copy of the list of values.
* `initialItems` is no longer modified in-place by the widget state.
* Focus stays in text field after selecting or creating a value.
* Added a small space between text field and row of chips.
* Added optional `placeholderItem` to reserve space for row of chips.

## [4.0.1] - 2022-04-20
* Flutter 3.0 fixes.

## [4.0.0] - 2022-04-20
* BradInTheUSA: forked from https://github.com/culjo/flutter_tagging
* culjo: forked from https://github.com/sarbagyastha/flutter_tagging

## [2.2.0+3] - 2020-02-23
* Minor docs changes

## [2.2.0+2] - 2019-12-02
* Changed defaults for `spacing` and `runSpacing` to 8.0

## [2.2.0+1] - 2019-11-29
**BREAKING CHANGES**
* Added mandatory `initialItems` property.

## [2.1.0+2] - 2019-11-28
* Added support for Flutter web platform.

## [2.1.0] - 2019-11-26
**BREAKING CHANGES**
### Changed
* Some properties are renamed and added.
### Added
* Added API documentation.

## [2.0.0+2] - 2019-11-19
* Setting `additionCallback` to `null` disables the feature to add tags.

## [2.0.0+1] - 2019-11-17
**BREAKING CHANGES**
* Complete refactor and improvements.

## [1.1.0] - 2019-03-23
* Updated dependency.
* Added access to newer properties from `flutter_typeahead`.

## [1.0.1] - 2018-12-30
* Added description.

## [1.0.0] - 2018-12-30
* Initial Release.
