part of grock_extension;

class GrockAdaptiveDialogButton extends StatelessWidget {
  const GrockAdaptiveDialogButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });
  final Widget child;
  final VoidCallback onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return materialDialogButton(
          context: context,
          child: child,
          onPressed: onPressed,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return cupertinoDialogButton(
          context: context,
          child: child,
          onPressed: onPressed,
        );
    }
  }

  Widget materialDialogButton(
      {required BuildContext context,
      required Widget child,
      required VoidCallback onPressed,
      Color? textColor}) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
      ),
      child: TextButton(
        child: defaultTextStyle(context: context, child: child),
        onPressed: onPressed,
      ),
    );
  }

  Widget cupertinoDialogButton(
      {required BuildContext context,
      required Widget child,
      required VoidCallback onPressed,
      Color? textColor}) {
    return CupertinoDialogAction(
      child: defaultTextStyle(context: context, child: child),
      onPressed: onPressed,
      isDefaultAction: true,
      isDestructiveAction: true,
    );
  }

  DefaultTextStyle defaultTextStyle(
      {required BuildContext context, required Widget child}) {
    return DefaultTextStyle(
      style: TextStyle(
        color: isDestructiveAction
            ? CupertinoColors.systemRed
            : Theme.of(context).primaryColor,
        fontWeight: isDefaultAction ? FontWeight.bold : FontWeight.normal,
        fontFamily: '.SF UI Text',
        inherit: false,
        fontSize: 16.8,
        textBaseline: TextBaseline.alphabetic,
      ),
      child: child,
    );
  }
}
