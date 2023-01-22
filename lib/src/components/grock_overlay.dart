part of grock_extension;

class _GrockOverlay {
  static OverlayState? overlayState =
      Grock.navigationKey.currentState!.overlay!;
  static OverlayEntry? overlayEntry;
  static void close() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  static bool get isOpen => overlayEntry != null;

  static void show({required Widget child}) {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
    overlayEntry = OverlayEntry(builder: (context) => child);
    overlayState?.insert(overlayEntry!);
  }
}
