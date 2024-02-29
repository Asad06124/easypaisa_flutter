# easypaisa_flutter

Easily integrate easypaisa payment option in your Flutter app.

<!-- ![Example](https://github.com/Asad06124/easypaisa_flutter/tree/main/example) -->

## :rocket: Installation

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
easypaisa_flutter : latest_version
```

## :hammer: Initialization

```dart
EasypaisaFlutter.initialize(
 'username',
 'password',
'storeId',
 true/*is testing account or not*/,
 AccountType.MA/*Merchant account type either Mobile account or OTC */
);
```

> :pushpin: Note :
>
> You can use this singleton (instance) 
> or 
> Create your own  
> if you want to create different iFrames or integrations
```dart
final PaymobPakistan paymobPakistan = PaymobPakistan();
  paymobPakistan.initialize(
  apiKey: "", 
  jazzcashIntegrationId: 123123, 
  easypaisaIntegrationID: 123123,  
  integrationID: 123456, 
  iFrameID: 123456, 
);
```

## :bookmark: Usage

```dart
final PaymobResponse? response = await PaymobPakistan.instance.pay(
  context: context,
  currency: "PKR",
  paymentType: PaymentType.card, // or you can User paymentType: PaymentType.jazzcash OR PaymentType.easypaisa
  amountInCents: "50000", // 500 PKR
  onPayment: (response) => setState(() => this.response = response), // Optional
)
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


#### :negative_squared_cross_mark: Declined payment

Change cvv to 111 or expiry year to 20

##  Credits

> All API Credits goes to [Paymob Pakistan](https://paymob.pk)

> :pushpin: Note :
> 
> Visit [Paymob Pakistan](https://paymob.pk) to get your PayMob account for accepting Digital Payments on your Flutter Application.
> May be you have to contact paymob support to activate your test card 


