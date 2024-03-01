import 'dart:convert';
import 'package:http/http.dart';
import 'account_type.dart';

class EasypaisaFlutter {
  static String? username;
  static String? password;
  static String? storeId;
  static late bool isSandbox;
  static late AccountType accountType;

 static void initialize(String username, String password, String storeId,
      bool? isSandbox, AccountType? accountType) {
    EasypaisaFlutter.username = username;
    EasypaisaFlutter.password = password;
    EasypaisaFlutter.storeId = storeId;
    EasypaisaFlutter.isSandbox = isSandbox ?? true;
    EasypaisaFlutter.accountType = accountType ?? AccountType.MA;
  }

  static Future<Response> requestPayment(
    String amount,
    String accountNo,
    String email,
  ) async {
    if (username == null || password == null) {
      throw Exception('Username and password must be initialized first.');
    }

    String expiryToken = generateExpiryToken();

    var requestBodyMA = {
      "orderId": "${DateTime.now().millisecondsSinceEpoch}",
      "storeId": storeId,
      "transactionAmount": amount,
      "transactionType": 'MA',
      "mobileAccountNo": accountNo,
      "emailAddress": email,
    };
    var requestBodyOTC = {
      "orderId": "${DateTime.now().millisecondsSinceEpoch}",
      "storeId": storeId,
      "transactionAmount": amount,
      "transactionType": 'OTC',
      "msisdn": accountNo,
      "emailAddress": email,
      "tokenExpiry": expiryToken,
    };
    String endUrl = accountType == AccountType.MA
        ? "initiate-ma-transaction"
        : "initiate-otc-transaction";
    String sandBoxTransactionUrl =
        'https://easypaystg.easypaisa.com.pk/easypay-service/rest/v4/$endUrl';
    String liveTransactionUrl =
        'https://easypay.easypaisa.com.pk/easypay-service/rest/v4/$endUrl';

    var jsonBody = json
        .encode(accountType == AccountType.MA ? requestBodyMA : requestBodyOTC);
    var response = await post(
      Uri.parse(isSandbox ? sandBoxTransactionUrl : liveTransactionUrl),
      headers: {
        "Credentials": base64.encode(utf8.encode('$username:$password')),
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print("Transaction initiated successfully: ${response.body}");
      return response;
    } else {
      print("Transaction initiate failed: ${response.body}");
      return response;
    }
  }

  static Future<Response> requestPaymentStatus(
    bool isSandbox,
    String orderId,
  ) async {
    if (username == null || password == null || storeId == null) {
      throw Exception('Username and password must be initialized first.');
    }

    var requestBody = {
      "orderId ": orderId,
      "storeId": storeId,
      "accountNum": "654123987",
    };

    String sandBoxTransactionUrl =
        'https://easypaystg.easypaisa.com.pk/easypay-service/rest/v4/inquire-transaction';
    String liveTransactionUrl =
        'https://easypay.easypaisa.com.pk/easypay-service/rest/v4/inquire-transaction';

    var jsonBody = json.encode(requestBody);
    var response = await post(
      Uri.parse(isSandbox ? sandBoxTransactionUrl : liveTransactionUrl),
      headers: {
        "Credentials": base64.encode(utf8.encode('$username:$password')),
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print("Transaction initiated successfully: ${response.body}");
      return response;
    } else {
      print("Transaction initiate failed: ${response.body}");
      return response;
    }
  }
}
