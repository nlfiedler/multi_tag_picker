//
// Copyright 2020 Sarbagya Dhaubanjar
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'configurations.dart';

/// A widget that combines a text field provided by the `flutter_typeahead`
/// library and a row of chips that represent the values chosen by the user.
///
/// The type `T` should override the `==` operator as well as `hashCode` to
/// provide suitable equality checks for the values, as they will be stored in a
/// `Set` collection. The `equatable` library is helpful for this purpose. See
/// the `Language` class in `example/lib/main.dart` for an example of
/// implementing this functions.
class FlutterTagging<T> extends StatefulWidget {
  /// Invoked any time values are added or removed.
  final ValueChanged<List<T>> onChanged;

  /// The configuration of the [TextField] that the [FlutterTagging] widget
  /// displays.
  final TextFieldConfiguration textFieldConfiguration;

  /// Called with the search pattern to get the search suggestions.
  ///
  /// This callback is be invoked indirectly by the `flutter_typeahead` widget.
  /// It should return a [List] of suggestions either synchronously, or
  /// asynchronously (as the result of a [Future]). Typically, the list of
  /// suggestions should not contain more than 4 or 5 entries. These entries
  /// will then be provided to [itemBuilder] to display the suggestions.
  final FutureOr<List<T>> Function(String) findSuggestions;

  /// The configuration of [Chip]s that are displayed for selected tags.
  final ChipConfiguration Function(T) configureChip;

  /// The configuration of suggestions displayed when [findSuggestions]
  /// finishes, used to populate the properties of a `ListTile` widget.
  final SuggestionConfiguration Function(T) configureSuggestion;

  /// The configuration of selected tags like their spacing, direction, etc.
  final WrapConfiguration wrapConfiguration;

  /// Defines a new value given the provided query string.
  ///
  /// If null, the tag addition feature is disabled.
  final T Function(String)? additionCallback;

  /// Called when a new tag is being added by the user.
  ///
  /// Optionally may return a refined version of the value to be added to the
  /// list of values.
  final FutureOr<T> Function(T)? onAdded;

  /// Called when waiting for [findSuggestions] to return.
  final Widget Function(BuildContext)? loadingBuilder;

  /// Called when [findSuggestions] returns an empty list.
  final Widget Function(BuildContext)? emptyBuilder;

  /// Called when [findSuggestions] throws an exception.
  final Widget Function(BuildContext, Object?)? errorBuilder;

  /// Called to display animations when [findSuggestions] returns suggestions.
  ///
  /// It is provided with the suggestions box instance and the animation
  /// controller, and expected to return an animation that uses the controller
  /// to display the suggestion box.
  final Widget Function(BuildContext, Widget, AnimationController?)?
      transitionBuilder;

  /// The configuration of suggestion box.
  final SuggestionsBoxConfiguration suggestionsBoxConfiguration;

  /// Spacing between the text field and the row of chips.
  final double interiorSpacing;

  /// The duration that [transitionBuilder] animation takes.
  ///
  /// This argument is best used with [transitionBuilder] and [animationStart]
  /// to fully control the animation.
  ///
  /// Defaults to 500 milliseconds.
  final Duration animationDuration;

  /// The value at which the [transitionBuilder] animation starts.
  ///
  /// This argument is best used with [transitionBuilder] and [animationDuration]
  /// to fully control the animation.
  ///
  /// Defaults to 0.25.
  final double animationStart;

  /// If set to true, no loading box will be shown while suggestions are
  /// being fetched. The [loadingBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnLoading;

  /// If set to true, nothing will be shown if there are no results. The
  /// [emptyBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnEmpty;

  /// If set to true, nothing will be shown if there is an error. The
  /// [errorBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnError;

  /// If defined, an invisible placeholder based on this item will occupy the
  /// space where the row of chips would be when there are no values selected.
  final T? placeholderItem;

  /// The duration to wait after the user stops typing before calling
  /// [findSuggestions].
  ///
  /// This duration is set by default to 300 milliseconds.
  final Duration debounceDuration;

  /// If set to true, suggestions will be fetched immediately when the field is
  /// added to the view.
  ///
  /// The suggestions box will only be shown when the field receives focus. To
  /// make the field receive focus immediately, you can set the `autofocus`
  /// property in the [textFieldConfiguration] to true.
  ///
  /// Defaults to false.
  final bool enableImmediateSuggestion;

  /// List of inital values, if any.
  final List<T> initialItems;

  /// Creates a [FlutterTagging] widget.
  const FlutterTagging({
    Key? key,
    required this.findSuggestions,
    required this.configureChip,
    required this.configureSuggestion,
    required this.onChanged,
    this.initialItems = const [],
    this.additionCallback,
    this.enableImmediateSuggestion = false,
    this.errorBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.placeholderItem,
    this.wrapConfiguration = const WrapConfiguration(),
    this.textFieldConfiguration = const TextFieldConfiguration(),
    this.suggestionsBoxConfiguration = const SuggestionsBoxConfiguration(),
    this.interiorSpacing = 8.0,
    this.transitionBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideOnLoading = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationStart = 0.25,
    this.onAdded,
  }) : super(key: key);

  @override
  State<FlutterTagging<T>> createState() => _FlutterTaggingState<T>();
}

class _FlutterTaggingState<T> extends State<FlutterTagging<T>> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  final Set<T> _values = <T>{};
  T? _additionItem;

  @override
  void initState() {
    super.initState();
    _values.addAll(widget.initialItems);
    _textController =
        widget.textFieldConfiguration.controller ?? TextEditingController();
    _focusNode = widget.textFieldConfiguration.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TypeAheadField<T>(
          getImmediateSuggestions: widget.enableImmediateSuggestion,
          debounceDuration: widget.debounceDuration,
          hideOnEmpty: widget.hideOnEmpty,
          hideOnError: widget.hideOnError,
          hideOnLoading: widget.hideOnLoading,
          animationStart: widget.animationStart,
          animationDuration: widget.animationDuration,
          autoFlipDirection:
              widget.suggestionsBoxConfiguration.autoFlipDirection,
          direction: widget.suggestionsBoxConfiguration.direction,
          hideSuggestionsOnKeyboardHide:
              widget.suggestionsBoxConfiguration.hideSuggestionsOnKeyboardHide,
          keepSuggestionsOnLoading:
              widget.suggestionsBoxConfiguration.keepSuggestionsOnLoading,
          keepSuggestionsOnSuggestionSelected: widget
              .suggestionsBoxConfiguration.keepSuggestionsOnSuggestionSelected,
          suggestionsBoxController:
              widget.suggestionsBoxConfiguration.suggestionsBoxController,
          suggestionsBoxDecoration:
              widget.suggestionsBoxConfiguration.suggestionsBoxDecoration,
          suggestionsBoxVerticalOffset:
              widget.suggestionsBoxConfiguration.suggestionsBoxVerticalOffset,
          errorBuilder: widget.errorBuilder,
          transitionBuilder: widget.transitionBuilder,
          loadingBuilder: (context) =>
              widget.loadingBuilder?.call(context) ??
              const SizedBox(
                height: 3.0,
                child: LinearProgressIndicator(),
              ),
          noItemsFoundBuilder: widget.emptyBuilder,
          textFieldConfiguration: widget.textFieldConfiguration.copyWith(
            focusNode: _focusNode,
            controller: _textController,
            enabled: widget.textFieldConfiguration.enabled,
          ),
          suggestionsCallback: (query) async {
            var suggestions = await widget.findSuggestions(query);
            suggestions =
                suggestions.where((r) => !_values.contains(r)).toList();
            if (widget.additionCallback != null && query.isNotEmpty) {
              final additionItem = widget.additionCallback!(query);
              if (!suggestions.contains(additionItem) &&
                  !_values.contains(additionItem)) {
                _additionItem = additionItem;
                suggestions.insert(0, additionItem);
              } else {
                _additionItem = null;
              }
            }
            return suggestions;
          },
          itemBuilder: (context, item) {
            final conf = widget.configureSuggestion(item);
            return ListTile(
              key: ObjectKey(item),
              title: conf.title,
              subtitle: conf.subtitle,
              leading: conf.leading,
              trailing: InkWell(
                splashColor: conf.splashColor ?? Theme.of(context).splashColor,
                borderRadius: conf.splashRadius,
                onTap: () async {
                  final itemItem = widget.onAdded != null
                      ? await widget.onAdded!(item)
                      : item;
                  setState(() {
                    _values.add(itemItem);
                  });
                  widget.onChanged.call(_values.toList(growable: false));
                  _textController.clear();
                },
                child: Builder(
                  builder: (context) {
                    if (conf.additionWidget != null && _additionItem == item) {
                      return conf.additionWidget!;
                    } else {
                      return const SizedBox(width: 0);
                    }
                  },
                ),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            if (_additionItem != suggestion) {
              setState(() {
                _values.add(suggestion);
              });
              widget.onChanged.call(_values.toList(growable: false));
              _textController.clear();
              // focus change must happen after this task completes
              Future.delayed(Duration.zero, () {
                _focusNode.requestFocus();
              });
            }
          },
        ),
        if (widget.interiorSpacing > 0)
          SizedBox(height: widget.interiorSpacing),
        Wrap(
          alignment: widget.wrapConfiguration.alignment,
          crossAxisAlignment: widget.wrapConfiguration.crossAxisAlignment,
          runAlignment: widget.wrapConfiguration.runAlignment,
          runSpacing: widget.wrapConfiguration.runSpacing,
          spacing: widget.wrapConfiguration.spacing,
          direction: widget.wrapConfiguration.direction,
          textDirection: widget.wrapConfiguration.textDirection,
          verticalDirection: widget.wrapConfiguration.verticalDirection,
          children: _values.isEmpty && widget.placeholderItem != null
              ? _buildPlaceholder(
                  context,
                  // ignore: null_check_on_nullable_type_parameter
                  widget.configureChip(widget.placeholderItem!),
                )
              : _values.map<Widget>((item) {
                  final conf = widget.configureChip(item);
                  return Chip(
                    label: conf.label,
                    shape: conf.shape,
                    avatar: conf.avatar,
                    backgroundColor: conf.backgroundColor,
                    clipBehavior: conf.clipBehavior,
                    deleteButtonTooltipMessage: conf.deleteButtonTooltipMessage,
                    deleteIcon: conf.deleteIcon,
                    deleteIconColor: conf.deleteIconColor,
                    elevation: conf.elevation,
                    labelPadding: conf.labelPadding,
                    labelStyle: conf.labelStyle,
                    materialTapTargetSize: conf.materialTapTargetSize,
                    padding: conf.padding,
                    shadowColor: conf.shadowColor,
                    onDeleted: () {
                      setState(() {
                        _values.remove(item);
                      });
                      widget.onChanged.call(_values.toList(growable: false));
                    },
                  );
                }).toList(),
        ),
      ],
    );
  }
}

List<Widget> _buildPlaceholder(BuildContext context, ChipConfiguration conf) {
  return [
    Visibility(
      visible: false,
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      child: Chip(
        label: conf.label,
        shape: conf.shape,
        avatar: conf.avatar,
        clipBehavior: conf.clipBehavior,
        deleteIcon: conf.deleteIcon,
        elevation: conf.elevation,
        labelPadding: conf.labelPadding,
        labelStyle: conf.labelStyle,
        padding: conf.padding,
      ),
    )
  ];
}
