import 'dart:convert';
import 'package:http/http.dart';
import 'account_type.dart';

/// A Flutter package for integrating Easypaisa payments.

class EasypaisaFlutter {
  /// The username for authenticating Easypaisa requests.
  static String? username;

  /// The password for authenticating Easypaisa requests.
  static String? password;

  /// The store ID associated with the Easypaisa Merchant account.
  static String? storeId;

  /// Flag indicating whether to use the Easypaisa sandbox environment.
  static late bool isSandbox;

  /// The type of Easypaisa account (Mobile Account or Over the Counter).
  static late AccountType accountType;

  /// Initializes the Easypaisa credentials and settings.
  ///
  /// This method must be called before making any Easypaisa requests.
  /// - [username]: The Easypaisa account username.
  /// - [password]: The Easypaisa account password.
  /// - [storeId]: The Easypaisa store ID.
  /// - [isSandbox]: A flag indicating whether to use the Easypaisa sandbox environment (default is true).
  /// - [accountType]: The type of Easypaisa account (default is AccountType.MA).
  static void initialize(String username, String password, String storeId,
      bool? isSandbox, AccountType? accountType) {
    EasypaisaFlutter.username = username;
    EasypaisaFlutter.password = password;
    EasypaisaFlutter.storeId = storeId;
    EasypaisaFlutter.isSandbox = isSandbox ?? true;
    EasypaisaFlutter.accountType = accountType ?? AccountType.MA;
  }

  /// Initiates a payment request with Easypaisa.
  ///
  /// - [amount]: The transaction amount.
  /// - [accountNo]: The account or mobile number associated with the transaction.
  /// - [email]: The email address associated with the transaction.
  /// Returns a [Future] containing the HTTP response.
  static Future<Response> requestPayment({
    required String amount,
    required String accountNo,
    required String email,
  }) async {
    /// Check if required credentials are initialized.
    if (username == null || password == null || storeId == null) {
      throw Exception('Username and password must be initialized first.');
    }

    /// Generate an expiry token for the transaction.
    String expiryToken = generateExpiryToken();

    /// Prepare the request body for Mobile Account (MA) transaction.
    var requestBodyMA = {
      "orderId": "${DateTime.now().millisecondsSinceEpoch}",
      "storeId": storeId,
      "transactionAmount": amount,
      "transactionType": 'MA',
      "mobileAccountNo": accountNo,
      "emailAddress": email,
    };

    /// Prepare the request body for Over the Counter (OTC) transaction.
    var requestBodyOTC = {
      "orderId": "${DateTime.now().millisecondsSinceEpoch}",
      "storeId": storeId,
      "transactionAmount": amount,
      "transactionType": 'OTC',
      "msisdn": accountNo,
      "emailAddress": email,
      "tokenExpiry": expiryToken,
    };

    ///  Determine the end URL based on the account type.
    String endUrl = accountType == AccountType.MA
        ? "initiate-ma-transaction"
        : "initiate-otc-transaction";

    /// Determine the transaction URL based on the environment (sandbox/live).
    String sandBoxTransactionUrl =
        'https://easypaystg.easypaisa.com.pk/easypay-service/rest/v4/$endUrl';
    String liveTransactionUrl =
        'https://easypay.easypaisa.com.pk/easypay-service/rest/v4/$endUrl';

    String url = isSandbox ? sandBoxTransactionUrl : liveTransactionUrl;

    /// Encode the request body to JSON.
    var jsonBody = json
        .encode(accountType == AccountType.MA ? requestBodyMA : requestBodyOTC);

    /// Make the HTTP POST request to initiate the transaction.
    var response = await post(
      Uri.parse(url),
      headers: {
        "Credentials": base64.encode(utf8.encode('$username:$password')),
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );

    /// Check the response status.
    if (response.statusCode == 200) {
      // print(jsonBody);
      // print(url);
      // print("Transaction initiated successfully: ${response.body}");
      return response;
    } else {
      // print("Transaction initiate failed: ${response.body}");
      return response;
    }
  }

  /// Checks the status of a payment request with Easypaisa.
  ///
  /// - [orderId]: The unique identifier for the Easypaisa transaction.
  /// - [accountNo]: The account or mobile number associated with the transaction.
  /// Returns a [Future] containing the HTTP response.

  static Future<Response> requestPaymentStatus(
    String orderId,
    String accountNo,
  ) async {
    if (username == null || password == null || storeId == null) {
      throw Exception('Username and password must be initialized first.');
    }

    var requestBody = {
      "orderId ": orderId,
      "storeId": storeId,
      "accountNum": accountNo,
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
