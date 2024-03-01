# easypaisa_flutter

Easily integrate easypaisa payment option in your Flutter app.

<!-- ![Example](https://github.com/Asad06124/easypaisa_flutter/tree/main/example) -->

## :rocket: Installation

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
easypaisa_flutter : latest_version
```


## :hammer: Initialization
initialize in main.dart
```dart
EasypaisaFlutter.initialize(
 'username', //merchant account username
 'password', //merchant account password
'storeId', //merchant storeId
 true, //is testing account or not
 AccountType.MA, //Merchant account type either Mobile account or OTC 
);
```

## : Usage
> :pushpin: Note :
>
> All requested perameters are String type 

```dart
 Response response = await EasypaisaFlutter.requestPayment(
      'amount', //amount that you wanna charge
      'account number', //user account number
      'email', //user email address
    );



print(response.body); // to print response body
```
## : Response

   ```dart

{"orderId":"1709272404426","storeId":"storeId","transactionDateTime":"01/03/2024 10:53 AM","responseCode":"0001","responseDesc":"your response descriptions"}

```

## :incoming_envelope: PaymobResponse

| Variable      | Type    | Description          |
| ------------- |---------| -------------------- |
| success       | bool    | Indicates if the transaction was successful or not |
| transactionID | String? | The ID of the transaction |
| responseCode  | String? | The response code for the transaction |
| message       | String? | A brief message describing the transaction |


## :test_tube: Testing Cards

#### :white_check_mark: Successful payment

| Variable     | Description      |
|--------------|------------------|
| Card Number  | 5123456789012346 |
| Expiry Month | 12               |
| Expiry Year  | 25               |
| CVV          | 123              |
| Name         | Test Account     |


## Support the package

If you find this package useful, you can support it for free by giving it a thumbs up at the top of this page. Here's another option to support the package:

## <p align='center'><a href="https://www.buymeacoffee.com/asadbalqanw"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=jonhanson&button_colour=5F7FFF&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00" width="450" height="200"></a></p>


