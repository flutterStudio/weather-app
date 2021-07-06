class DateTimeUtils {
  /// Convert the given [dateTime] to the format `2 NOV 2020`.
  static String formatDate(DateTime dateTime) =>
      "${dateTime.day.toString()} ${abbrevMonthsName(dateTime.month)} ${dateTime.year.toString()}";

  static String? abbrevMonthsName(int month) =>
      _ABBREVIATED_MONTHS_FULL_NAMES[month];

  static String? abbrevDayName(int day) => _ABBREVIATED_DAYS_NAMES[day];

  static String? fullDayName(int day) => _FULL_DAYS_NAMES[day];

  static String? fullMonthsName(int month) => _FULL_MONTHS_NAMES[int];

  static const Map<int, String> _ABBREVIATED_MONTHS_FULL_NAMES = {
    DateTime.january: "JAN",
    DateTime.february: "FEB",
    DateTime.march: "MAR",
    DateTime.april: "APR",
    DateTime.may: "MAY",
    DateTime.june: "JUN",
    DateTime.july: "JUL",
    DateTime.august: "AUG",
    DateTime.september: "SEP",
    DateTime.october: "OCT",
    DateTime.november: "NOV",
    DateTime.december: "DEC"
  };

  static const Map<int, String> _FULL_MONTHS_NAMES = {
    DateTime.january: "January",
    DateTime.february: "February",
    DateTime.march: "March",
    DateTime.april: "April",
    DateTime.may: "May",
    DateTime.june: "June",
    DateTime.july: "July",
    DateTime.august: "August",
    DateTime.september: "September",
    DateTime.october: "October",
    DateTime.november: "November",
    DateTime.december: "December"
  };

  static const Map<int, String> _FULL_DAYS_NAMES = {
    DateTime.saturday: "Saturday",
    DateTime.sunday: "Sunday",
    DateTime.monday: "Monday",
    DateTime.tuesday: "Tuesday",
    DateTime.wednesday: "Wednesday",
    DateTime.thursday: "Thursday",
    DateTime.friday: "friday",
  };

  static const Map<int, String> _ABBREVIATED_DAYS_NAMES = {
    DateTime.saturday: "Sat",
    DateTime.sunday: "Sun",
    DateTime.monday: "Mon",
    DateTime.tuesday: "Tue",
    DateTime.wednesday: "Wed",
    DateTime.thursday: "Thu",
    DateTime.friday: "fri",
  };
}
