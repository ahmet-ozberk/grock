String grockTimeFormat(Duration time) {
  late String result;
  if (time.inHours > 0) {
    result =
        "${time.inHours.toString().padLeft(2, '0')}:${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${time.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  } else {
    result =
        "${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${time.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
  return result;
}
