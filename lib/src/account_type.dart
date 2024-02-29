enum AccountType{OTC, MA}

String generateExpiryToken() {
  DateTime now = DateTime.now().add(const Duration(minutes: 3));

  String year = now.year.toString().padLeft(4, '0');
  String month = now.month.toString().padLeft(2, '0');
  String day = now.day.toString().padLeft(2, '0');
  String hour = now.hour.toString().padLeft(2, '0');
  String minute = now.minute.toString().padLeft(2, '0');
  String second = now.second.toString().padLeft(2, '0');

  String token = "$year$month$day $hour$minute$second";
  return token;
}