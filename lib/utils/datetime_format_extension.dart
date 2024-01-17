extension DatetimeFormat on DateTime {
  String toDateFormat() =>
      toLocal().toString().substring(0, 10).replaceAll("-", "/");

  String toHoursFormat() =>
      toLocal().toString().substring(10, 16).replaceAll(":", "h");
}
