#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'molpay_mobile_xdk_flutter_beta'
  s.version          = '0.0.1'
  s.summary          = 'MOLPay mobile payment for Flutter (BETA).'
  s.description      = <<-DESC
This is the beta but functional MOLPay Flutter payment module that is ready to be implemented into any Flutter project. An example application project is provided for MOLPayXDK framework integration reference.
                       DESC
  s.homepage         = 'https://github.com/MOLPay/molpay-mobile-xdk-flutter-beta'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'MOLPay' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.resource = 'MOLPayXDK.bundle' 
  s.vendored_frameworks = 'MOLPayXDK.framework'
  s.static_framework = true
  
  s.ios.deployment_target = '8.0'
end

