class TimerItem {
  int seconds;
  bool isRunning;
  bool isPaused;

  TimerItem(
      {required this.seconds, this.isRunning = false, this.isPaused = false});
}
