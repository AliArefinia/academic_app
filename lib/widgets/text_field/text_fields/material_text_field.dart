import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/widgets/text_field/text_field_controller.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../core/theme/const.dart';

enum TextFieldType { outline, underline }

class MaterialTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? hint;
  final String name;
  final String label;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextFieldType? textFieldType;
  final bool? isPassword;
  final FormFieldValidator<String>? validator;

  /// The type of action button to use for the keyboard (e.g., done, next).
  final TextInputAction? textInputAction;

  /// Controls how text is capitalized (e.g., words, sentences).
  final TextCapitalization textCapitalization;

  /// The style of the text inside the text field.
  final TextStyle? style;

  /// Controls vertical text spacing and layout.
  final StrutStyle? strutStyle;

  /// Controls the alignment of the text (e.g., left, right, center).
  final TextAlign textAlign;

  /// Controls the vertical alignment of the text (top, center, bottom).
  final TextAlignVertical? textAlignVertical;

  /// The text direction (left-to-right or right-to-left).
  final TextDirection? textDirection;

  /// Automatically focus this text field when the screen loads.
  final bool autofocus;

  /// Character to use when obscuring text, usually for passwords.
  final String obscuringCharacter;

  /// Hide the text in the field for password input.
  final bool obscureText;
  final bool? enabled;

  /// Enable or disable auto-correction.
  final bool autocorrect;

  /// Enable or disable smart dashes for better text formatting.
  final SmartDashesType? smartDashesType;

  /// Enable or disable smart quotes for better text formatting.
  final SmartQuotesType? smartQuotesType;

  /// Enable or disable text suggestions like autocomplete.
  final bool enableSuggestions;

  /// The maximum number of lines the text field can display.
  final int? maxLines;

  /// The minimum number of lines the text field can display.
  final int? minLines;

  /// If true, the field expands vertically to fit its content.
  final bool expands;

  final ValueChanged<String?>? onChanged;

  /// Context menu customization (cut, copy, paste, etc.).
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Whether to show the text cursor.
  final bool? showCursor;

  /// The maximum length of text allowed in the field.
  final int? maxLength;

  /// Defines how the input should enforce the max length limit.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Function to execute when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Function to execute when the user submits the text.
  final ValueChanged<String?>? onSubmitted;

  /// Input formatters (e.g., to restrict input to numbers).
  final List<TextInputFormatter>? inputFormatters;

  /// The width of the text cursor.
  final double cursorWidth;

  /// The height of the text cursor.
  final double? cursorHeight;
  final FocusNode? focusNode;

  /// The radius of the text cursor's rounded corners.
  final Radius? cursorRadius;

  /// The color of the text cursor.
  final Color? cursorColor;

  /// Controls the height style of the text selection.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls the width style of the text selection.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The brightness of the keyboard (e.g., light or dark).
  final Brightness? keyboardAppearance;

  /// Padding around the text field when scrolling.
  final EdgeInsets scrollPadding;

  /// Enable or disable interactive text selection (e.g., copy-paste).
  final bool enableInteractiveSelection;

  /// Controls how the field responds to drag gestures.
  final DragStartBehavior dragStartBehavior;

  /// The cursor to show when hovering over the text field.
  final MouseCursor? mouseCursor;

  /// Function to build a custom character counter widget.
  final InputCounterWidgetBuilder? buildCounter;

  /// The scroll physics for the text field (e.g., bounce, scroll inertia).
  final ScrollPhysics? scrollPhysics;
  final TextInputType? keyboardType;

  /// Scroll controller for managing text field scrolling.
  final ScrollController? scrollController;
  final EdgeInsets? contentPadding;

  /// Hints for autofill when typing text (e.g., email, name).
  final Iterable<String>? autofillHints;

  /// Configuration for text magnification when selecting text.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Whether the text field is read-only or not.
  final bool readOnly;
  final Color? clearIconColor;

  /// Configuration for content insertion (e.g., pasting).
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// Configuration for spell checking the text input.
  final SpellCheckConfiguration? spellCheckConfiguration;

  MaterialTextField({
    required this.controller,
    this.textInputType,
    this.textFieldType = TextFieldType.outline,
    this.hint,
    this.prefixIcon,
    this.suffix,
    required this.name,
    required this.label,
    this.suffixIcon,
    this.onChanged,
    this.contentPadding,
    this.clearIconColor,
    this.enabled,
    this.isPassword = false,
    this.validator,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.keyboardType,
    this.focusNode,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines,
    this.minLines,
    this.expands = false,
    this.contextMenuBuilder,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.buildCounter,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.magnifierConfiguration,
    this.readOnly = false,
    this.contentInsertionConfiguration,
    this.spellCheckConfiguration,
  });

  @override
  Widget build(BuildContext context) {
    final textFieldController = CustomTextFieldController(controller);

    return ValueListenableBuilder<String?>(
      valueListenable: textFieldController,
      builder: (context, value, child) {
        return FormBuilderTextField(
          key: key,
          controller: textFieldController.textController,
          name: name,
          onChanged: onChanged,
          autofocus: autofocus,
          autocorrect: autocorrect,
          keyboardType: keyboardType ?? TextInputType.name,
          textInputAction: textInputAction ?? TextInputAction.done,
          textCapitalization: textCapitalization,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textDirection: textDirection,
          showCursor: showCursor,
          focusNode: focusNode,
          obscureText: isPassword != null &&
              isPassword! &&
              !textFieldController.isPasswordVisible,
          obscuringCharacter: obscuringCharacter ?? '•',
          maxLines: maxLines ?? 1,
          minLines: minLines,
          expands: expands ?? false,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          cursorWidth: cursorWidth ?? 2.0,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          enableSuggestions: enableSuggestions,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          autofillHints: autofillHints,
          readOnly: readOnly,
          decoration: InputDecoration(

              disabledBorder: const OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.corner16)),
                  borderSide: BorderSide(
                      style: BorderStyle.none,
                      color: Colors.transparent,
                      strokeAlign: 0,
                      width: 0)),
              contentPadding: contentPadding ??
                  context.theme.inputDecorationTheme.contentPadding,
              border: const OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.corner16)),
                  borderSide: BorderSide(
                      style: BorderStyle.none,
                      color: Colors.transparent,
                      strokeAlign: 0,
                      width: 0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppRadius.corner16)),
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: context.colorScheme.primary,
                      strokeAlign: 1,
                      width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppRadius.corner16)),
                  borderSide: BorderSide(
                      color: context.colorScheme.outline,
                      strokeAlign: 0,
                      width: 1)),
              filled: true,
              fillColor: Colors.transparent,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              enabled: enabled ?? true,
              labelText: label ?? '',
              suffix: suffix,
              errorStyle: const TextStyle(
                fontSize: 12,
                height: 1.5,
              ),
              counterStyle: const TextStyle(
                fontSize: 12,
                height: 1.5,
              ),
              hintText: hint ?? '',
              suffixIconConstraints: BoxConstraints.loose(const Size(80, 80)),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ??
                  (isPassword != null && isPassword!
                      ? IconButton(
                          icon: Icon(
                            textFieldController.isPasswordVisible
                                ? FluentIcons.eye_24_regular
                                : FluentIcons.eye_off_24_regular,
                          ),
                          onPressed: () {
                            textFieldController.togglePasswordVisibility();
                          },
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                child: textFieldController.hasText
                                    ? IconButton(
                                        key: const ValueKey('clearIcon'),
                                        icon: const Icon(
                                          Icons.clear,
                                        ),
                                        onPressed: () {
                                          textFieldController.clearText();
                                        },
                                      )
                                    : const SizedBox(
                                        key: ValueKey('emptySizedBox'),
                                      ),
                              ),
                            ]))),
          validator: validator ?? null,
        );
      },
    );
  }
}
