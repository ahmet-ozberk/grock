part of grock_x_menu_overlay;

class GrockXMenuController {
  late _GrockXMenuOverlayState _state;

  void _init(_GrockXMenuOverlayState state) {
    _state = state;
  }

  void open() {
    _state.initialize();
  }

  void close() {
    _state.animationController.reverse();
    final duration = _state.animationController.duration ?? Duration.zero;
    Future.delayed(duration, () {
      Grock.closeGrockOverlay();
    });
  }

  void toggle() {
    if (isOpen) {
      close();
    } else {
      open();
    }
  }

  void setAnimationController(AnimationController animationController) {
    _state.animationController = animationController;
  }

  void setItems(List<XMenuItem> items) {
    // ignore: invalid_use_of_protected_member
    _state.setState(() {
      _state.widget.items.clear();
      _state.widget.items.addAll(items);
    });
  }

  Duration get duration => _state.animationController.duration ?? Duration.zero;

  bool get isOpen => _state.animationController.isCompleted;

  bool get isClose => _state.animationController.isDismissed;

  bool get isAnimating => _state.animationController.isAnimating;

  AnimationController get animationController => _state.animationController;
}
