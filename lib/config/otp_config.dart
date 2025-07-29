import '../services/twilio_service.dart';

class OTPConfig {
  // Check if Twilio is properly configured
  static bool get isTwilioConfigured {
    return TwilioService.accountSid != 'YOUR_ACCOUNT_SID_HERE' &&
           TwilioService.authToken != 'YOUR_AUTH_TOKEN_HERE' &&
           TwilioService.serviceSid != 'YOUR_VERIFY_SERVICE_SID_HERE' &&
           TwilioService.serviceSid != 'VAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' &&
           TwilioService.accountSid.isNotEmpty &&
           TwilioService.authToken.isNotEmpty &&
           TwilioService.serviceSid.isNotEmpty &&
           TwilioService.accountSid.startsWith('AC') &&
           TwilioService.serviceSid.startsWith('VA');
  }
  
  // Send OTP using Twilio service
  static Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    if (!isTwilioConfigured) {
      return {
        'success': false,
        'message': 'يرجى تكوين بيانات Twilio أولاً في ملف twilio_service.dart',
      };
    }
    return await TwilioService.sendOTP(phoneNumber);
  }
  
  // Verify OTP using Twilio service
  static Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String code) async {
    if (!isTwilioConfigured) {
      return {
        'success': false,
        'message': 'يرجى تكوين بيانات Twilio أولاً في ملف twilio_service.dart',
      };
    }
    return await TwilioService.verifyOTP(phoneNumber, code);
  }
  
  // Get service status
  static String getServiceStatus() {
    if (isTwilioConfigured) {
      return 'استخدام خدمة Twilio الحقيقية';
    } else {
      return 'يرجى تكوين بيانات Twilio';
    }
  }
  
  // Check if service is ready
  static bool isServiceReady() {
    return isTwilioConfigured;
  }
  
  // Get configuration instructions
  static Map<String, String> getConfigurationInstructions() {
    if (isTwilioConfigured) {
      return {
        'title': 'خدمة Twilio مفعلة',
        'instructions': 'سيتم إرسال رمز التحقق الحقيقي إلى رقم هاتفك',
        'note': 'تأكد من أن رقم هاتفك صحيح ومحقق في Twilio',
      };
    } else {
      return {
        'title': 'يرجى إعداد خدمة Twilio',
        'instructions': 'قم بإضافة بيانات Twilio في ملف twilio_service.dart',
        'note': 'راجع ملف TWILIO_SETUP.md للتعليمات التفصيلية',
      };
    }
  }
}
