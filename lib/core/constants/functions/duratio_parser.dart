class DurationParser{
  static Map<String,String> parseDurationToMapHMS(Duration duration) {
        print(duration);
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        String twoDigitHours = twoDigits(duration.inHours);
        String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
        print("seconds");
        print(duration.inSeconds.remainder(60));
      return{ 
        "hours": twoDigitHours,
        "minutes": twoDigitMinutes,
        "seconds": twoDigitSeconds};
  }
}