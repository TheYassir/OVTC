extension DatetimeFormat on DateTime {
  String toDateFormat() => toString().substring(0, 10).replaceAll("-", "/");

  String toHoursFormat() => toString().substring(10, 16).replaceAll(":", "h");
}
