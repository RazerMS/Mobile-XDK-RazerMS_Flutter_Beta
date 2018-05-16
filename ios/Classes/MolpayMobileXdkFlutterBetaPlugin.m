#import "MolpayMobileXdkFlutterBetaPlugin.h"
#import <MOLPayXDK/MOLPayLib.h>

@interface MolpayMobileXdkFlutterBetaPlugin() <MOLPayLibDelegate>
{
    MOLPayLib *mp;
    BOOL isCloseButtonClick;
    BOOL isPaymentInstructionPresent;
}@end

@implementation MolpayMobileXdkFlutterBetaPlugin{
    FlutterResult _result;
    NSDictionary *_paymentDetails;
    UIViewController *_viewController;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"molpay_mobile_xdk_flutter_beta"
            binaryMessenger:[registrar messenger]];
  UIViewController *viewController =
  [UIApplication sharedApplication].delegate.window.rootViewController;
  MolpayMobileXdkFlutterBetaPlugin* instance = [[MolpayMobileXdkFlutterBetaPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if([@"startMolpay"isEqualToString:call.method]){
        _result = result;
        _paymentDetails = call.arguments;
        [self startMolpay];
    } else{
        result(FlutterMethodNotImplemented);
    }
}

- (IBAction)closemolpay:(id)sender
{
    // Closes MOLPay
    [mp closemolpay];
    
    isCloseButtonClick = YES;
}

-(void)startMolpay{
    
    // Default setting for Cash channel payment result conditions
    isPaymentInstructionPresent = NO;
    isCloseButtonClick = NO;
    
    mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:_paymentDetails];
    mp.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(closemolpay:)];
    mp.navigationItem.hidesBackButton = YES;
    
    // Push method (This requires host navigation controller to be available at this point of runtime process,
    // refer AppDelegate.m for sample Navigation Controller implementations)
    //[self.navigationController pushViewController:mp animated:YES];
    
    // Present method (Simple mode)
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mp];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
        viewController = viewController.presentedViewController;
    }
    [viewController presentViewController:nc animated:NO completion:nil];
}

// MOLPayLibDelegates
- (void)transactionResult: (NSDictionary *)result
{
    // Payment status results returned here
    NSLog(@"transactionResult result = %@", result);
    
    // All success cash channel payments will display a payment instruction, we will let the user to close manually
    if ([[result objectForKey:@"pInstruction"] integerValue] == 1 && isPaymentInstructionPresent == NO && isCloseButtonClick == NO)
    {
        isPaymentInstructionPresent = YES;
    }
    else
    {
        // Push method
        // [self.navigationController popViewControllerAnimated:NO];
        
        // Present method
        UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
            viewController = viewController.presentedViewController;
        }
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
