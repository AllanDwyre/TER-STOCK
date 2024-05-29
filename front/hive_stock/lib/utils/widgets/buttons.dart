import 'package:flutter/material.dart';

// -------------------------------------------------------------------------------
// -------------------------------- PrimaryButton --------------------------------
// -------------------------------------------------------------------------------

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        key: widget.key,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)))),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            if (widget.icon != null) const SizedBox(width: 5),
            if (widget.icon != null) Icon(widget.icon)
          ],
        ));
  }
}

// -------------------------------------------------------------------------------
// -------------------------------- SecondaryButton ------------------------------
// -------------------------------------------------------------------------------

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        key: widget.key,
        style: ButtonStyle(
            // TODO: empty background
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                  style: BorderStyle.solid
                ),
              borderRadius: BorderRadius.circular(5.0)))),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            if (widget.icon != null) const SizedBox(width: 5),
            if (widget.icon != null) Icon(widget.icon)
          ],
        ));
  }
}


// -------------------------------------------------------------------------------
// -------------------------------- TerniaryButton -------------------------------
// -------------------------------------------------------------------------------