import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseButton extends StatefulWidget {
  BaseButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.baseDecoration,
    this.hoverDecoration,
    this.clickDecoration,
    this.disabledDecoration,
    this.enabled = true,
  });

  // The callback when this button is pressed
  final VoidCallback onPressed;

  // The child element inside this button
  final Widget child;

  // External padding of the button. Note: The GestureDetector is still the entire area.
  final EdgeInsetsGeometry? padding;

  // Is this button enabled?
  final bool enabled;

  // Decorations for different states of the widget
  final BoxDecoration? baseDecoration;
  final BoxDecoration? hoverDecoration;
  final BoxDecoration? clickDecoration;
  final BoxDecoration? disabledDecoration;

  // The state that our decoration currently is in
  BoxDecoration? currentDecoration;

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  void initState() {
    super.initState();

    widget.currentDecoration = widget.baseDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Changing the decoration on mouse hover
      onEnter: (event) => enterHover(event),
      onExit: (event) => exitHover(event),

      // Set the cursor to the click cursor when hovering here
      cursor: SystemMouseCursors.click,

      // The child gesture detector -> for registering button presses
      child: GestureDetector(
        // Change the decoration depending on if we're in a clicking state
        onTapDown: (details) => tapDown(details),
        onTapUp: (details) => tapUp(details),

        // Trigger the passed function when pressed
        onTap: widget.onPressed,
        child: AnimatedContainer(
          // The decoration is stateful -> whatever our current decoration is
          // Also a check incase this button is disabled, we set our disabled decoration
          decoration: widget.enabled
              ? widget.currentDecoration
              : widget.disabledDecoration,
          duration: const Duration(milliseconds: 100),
          child: Center(
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  void enterHover(PointerEnterEvent event) {
    // When we start to hover, we want to change decoration to any hover decoration
    if (widget.hoverDecoration != null) {
      setState(() {
        widget.currentDecoration = widget.hoverDecoration;
      });
    }
  }

  void exitHover(PointerExitEvent event) {
    // When we exit hover, we want to change back to the original decoration
    if (widget.baseDecoration != widget.currentDecoration) {
      setState(() {
        widget.currentDecoration = widget.baseDecoration;
      });
    }
  }

  void tapDown(TapDownDetails details) {
    // When we start clicking, we want to change to our clicking decoration
    if (widget.clickDecoration != null) {
      setState(() {
        widget.currentDecoration = widget.clickDecoration;
      });
    }
  }

  void tapUp(TapUpDetails details) {
    // When we finish clicking, we want to change back to the original decoration
    setState(() {
      widget.currentDecoration = widget.hoverDecoration;
    });
  }
}
