import 'package:flutter/material.dart';
import 'package:molpay_mobile_xdk_flutter_beta/molpay_mobile_xdk_flutter_beta.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('MolpayMobileXDK'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                child: const Text('Start Molpay'),
                onPressed: () async {
                  
                  var paymentDetails = {
                    // Mandatory String. A value more than '1.00'
                    'mp_amount': '1.1',

                    // Mandatory String. Values obtained from MOLPay
                    'mp_username': '',
                    'mp_password': '',
                    'mp_merchant_ID': '',
                    'mp_app_name': '',
                    'mp_verification_key': '',

                    // Mandatory String. Payment values
                    'mp_order_ID': 'Flutter0002',
                    'mp_currency': 'MYR',
                    'mp_country': 'MY',

                    // Optional String.
                    'mp_channel': '', // Use 'multi' for all available channels option. For individual channel seletion, please refer to "Channel Parameter" in "Channel Lists" in the MOLPay API Spec for Merchant pdf. 
                    'mp_bill_description': 'Flutter payment test',
                    'mp_bill_name': 'anyname',
                    'mp_bill_email': 'example@email.com',
                    'mp_bill_mobile': '0161111111',
                    // 'mp_channel_editing': true, // Option to allow channel selection.
                    'mp_editing_enabled': true, // Option to allow billing information editing.

                    // Optional for Escrow
                    // 'mp_is_escrow': '', // Optional for Escrow, put "1" to enable escrow

                    // Optional for credit card BIN restrictions
                    'mp_bin_lock': ['414170', '414171'], // Optional for credit card BIN restrictions
                    'mp_bin_lock_err_msg': 'Only UOB allowed', // Optional for credit card BIN restrictions

                    // For transaction request use only, do not use this on payment process
                    // 'mp_transaction_id': '', // Optional, provide a valid cash channel transaction id here will display a payment instruction screen.
                    // 'mp_request_type': '', // Optional, set 'Status' when doing a transactionRequest

                    // Optional, use this to customize the UI theme for the payment info screen, the original XDK custom.css file is provided at Example project source for reference and implementation.
                    // 'mp_custom_css_url': '',

                    // Optional, set the token id to nominate a preferred token as the default selection, set "new" to allow new card only
                    // 'mp_preferred_token': '',

                    // Optional, credit card transaction type, set "AUTH" to authorize the transaction
                    // 'mp_tcctype': '',

                    // Optional, set true to process this transaction through the recurring api, please refer the MOLPay Recurring API pdf  
                    // 'mp_is_recurring': false,

                    // Optional for channels restriction 
                    'mp_allowed_channels': ['credit','credit3'],

                    // Optional for sandboxed development environment, set boolean value to enable.
                    // 'mp_sandbox_mode': false,

                    // Optional, required a valid mp_channel value, this will skip the payment info page and go direct to the payment screen.
                    // 'mp_express_mode': false,
                    // 'mp_bill_description_edit_disabled': false,
                    // 'mp_timeout' : 300,
                  };

                  String result = await molpay.startMolpay(paymentDetails);
                  print("Result" + result);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
