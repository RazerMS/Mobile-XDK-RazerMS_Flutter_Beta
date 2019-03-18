package com.molpay.molpaymobilexdkflutterbeta;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;
import com.molpay.molpayxdk.MOLPayActivity;
import android.app.Activity;
import android.content.Intent;
import java.lang.reflect.Field;
import java.util.HashMap;

/**
 * MolpayMobileXdkFlutterBetaPlugin
 */
public class MolpayMobileXdkFlutterBetaPlugin implements MethodCallHandler, ActivityResultListener {
  /**
   * Plugin registration.
   */
  private Activity activity;
  private Result results;

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "molpay_mobile_xdk_flutter_beta");
    MolpayMobileXdkFlutterBetaPlugin mp_flutter = new MolpayMobileXdkFlutterBetaPlugin(registrar.activity());
    registrar.addActivityResultListener(mp_flutter);
    channel.setMethodCallHandler(mp_flutter);
  }

  private MolpayMobileXdkFlutterBetaPlugin(Activity activity) {
    this.activity = activity;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("startMolpay")) {
      startMolpay(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void startMolpay(MethodCall call, Result result) {
    Field[] fields = MOLPayActivity.class.getDeclaredFields();
    HashMap<String, Object> paymentDetails = new HashMap<>();
    paymentDetails.put("is_submodule", true);
    paymentDetails.put("module_id", "molpay-mobile-xdk-flutter-beta-android");
    paymentDetails.put("wrapper_version", "2");
    paymentDetails.put("mp_credit_card_no", call.argument(""));
    paymentDetails.put("mp_credit_card_expiry", call.argument(""));
    paymentDetails.put("mp_credit_card_cvv", call.argument(""));

    if (call.argument("mp_credit_card_no") != null) {
      paymentDetails.put("mp_credit_card_no", call.argument("mp_credit_card_no"));
    }
    if (call.argument("mp_credit_card_expiry") != null) {
      paymentDetails.put("mp_credit_card_expiry", call.argument("mp_credit_card_expiry"));
    }
    if (call.argument("mp_credit_card_cvv") != null) {
      paymentDetails.put("mp_credit_card_cvv", call.argument("mp_credit_card_cvv"));
    }
    
    for (Field f : fields) {
      if (call.argument(f.getName()) != null) {
        paymentDetails.put(f.getName(), call.argument(f.getName()));
      }
    }

    Intent intent = new Intent(activity, MOLPayActivity.class);
    intent.putExtra(MOLPayActivity.MOLPayPaymentDetails, paymentDetails);
    activity.startActivityForResult(intent, MOLPayActivity.MOLPayXDK);
    this.results = result;
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == MOLPayActivity.MOLPayXDK && resultCode == Activity.RESULT_OK) {
      this.results.success(data.getStringExtra(MOLPayActivity.MOLPayTransactionResult));
    }
    return true;
  }
}
