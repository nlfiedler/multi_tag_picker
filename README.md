# Multi-Tag Picker

Flutter library that combines the text field from `flutter_typeahead` with a row of chips, allowing the user to select from a list of suggestions, as well as creating new values. Similar to `choose_input_chips` except that this widget provides the ability to create new values.

## Usage

### Install

Edit your package's `pubspec.yaml` like so and then run `flutter pub get`:

```
dependencies:
  multi_tag_picker: ^1.0.0
```

### Import

```dart
import 'package:multi_tag_picker/multi_tag_picker.dart';
```

### Example

See the code in `example/lib/main.dart` for a full-fledged working example.

## Similar Projects

The libraries shown below offer form input fields that have something to do with (input) chips. They may be quite different from this library, and that is kind of the point. This library is not meant to be an end-all-be-all to your (input) chip needs, so one of these may offer what you're looking for.

* [awesome_select](https://pub.dev/packages/awesome_select): offers many types of form inputs.
* [chips_choice](https://pub.dev/packages/chips_choice): provides selection of one or more chips.
* [flutter_input_chips](https://pub.dev/packages/flutter_input_chips): text input with free-form creation of new chips.
* [choose_input_chips](https://pub.dev/packages/choose_input_chips): similar to this but the chips are aligned horizontally next to a `Text` and a cursor that simulates editing.
* [simple_chips_input](https://pub.dev/packages/simple_chips_input): text input field with free-form creation of new chips, with optional input validation.

## How to Contribute

Pull requests are welcome. In order to expedite your contributions, please keep the following suggestions in mind. Thank you.

1. Submit small changes one at a time.
1. Keep bug fixes separate from unrelated changes.
1. If you want to reformat the code, do so in a separate commit.
1. If you want to make a lot of changes to bring the code up to date with the latest Dart or Flutter features (such as nullability), do so in a separate commit.
1. Use these [guidelines](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) when writing git commit messages. Bonus points for following the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) convention.

## History

Started as [sarbagyastha/flutter_tagging/](https://github.com/sarbagyastha/flutter_tagging/) and later forked to [culjo/flutter_tagging](https://github.com/culjo/flutter_tagging) and then forked again to [bradintheusa/flutter_tagging_plus](https://github.com/bradintheusa/flutter_tagging_plus) before coming to live here. Wanted to have a source repository that allowed for filing issues.
