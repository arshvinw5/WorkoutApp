//return today's data as yymmdd

String todaysDateYYYMMDD() {
  //today
  var dateTimeObject = DateTime.now();

  //year in the format yyyy
  String year = dateTimeObject.year.toString();

  //month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

//covert string yymmdd to dateTime object

DateTime createDateTineObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

//covert datetime object to string  yyymmdd

String covertDateTimeToYYYYMMDD(DateTime datetime) {
  //year in the format
  String year = datetime.year.toString();

  //month in the format
  String month = datetime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //day in the format
  String day = datetime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
