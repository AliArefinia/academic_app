import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:academic/widgets/loading_widget.dart';

class CustomButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final bool? autofocus;
  final MaterialStatesController? statesController;
  final bool? isSemanticButton;
  final Widget? child;
  final IconAlignment iconAlignment;

  const CustomButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    this.isSemanticButton = true,
    required this.child,
    this.iconAlignment = IconAlignment.start,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  Future<void> _handlePressed() async {
    if (isLoading || widget.onPressed == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await widget.onPressed!();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Bounce(
        child: ElevatedButton(
          onPressed: isLoading ? null : _handlePressed,
          style: widget.style ??
              ElevatedButton.styleFrom(
                  backgroundColor: isLoading
                      ? Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withOpacity(0.5)
                      : Theme.of(context).colorScheme.primary,
                  disabledBackgroundColor: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withOpacity(0.5)),
          child: isLoading ? const LoadingWidget() : widget.child,
        ),
      ),
    );
  }
}