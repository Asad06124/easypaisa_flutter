/// Enumeration representing the type of Easypaisa account.

enum AccountType {
  /// Over the Counter type.
  OTC,

  /// Mobile Account type.

  MA
}

/// Generates an expiry token for the Easypaisa request.
///
/// This method should be implemented based on the specific requirements for token generation.
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
