import 'dart:convert';
import 'package:http/http.dart' as http;

class TwilioService {

  // أضف Account SID الخاص بك من لوحة تحكم Twilio
  static const String accountSid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  
  // أضف Auth Token الخاص بك من لوحة تحكم Twilio  
  static const String authToken = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  
  // أضف Service SID الخاص بك من خدمة Verify
  static const String serviceSid = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  
  // Base URL for Twilio Verify API
  static const String _baseUrl = 'https://verify.twilio.com/v2/Services';
  
  // Send OTP
  static Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    try {
      final url = Uri.parse('$_baseUrl/$serviceSid/Verifications');
      
      final credentials = base64Encode(utf8.encode('$accountSid:$authToken'));
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': phoneNumber,
          'Channel': 'sms',
        },
      );
      
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': 'OTP sent successfully',
          'data': data,
        };
      } else {
        final errorData = json.decode(response.body);
        String errorMessage = 'فشل في إرسال رمز التحقق';
        
        if (errorData['code'] == 21608) {
          errorMessage = 'رقم الهاتف غير محقق في Twilio.\n'
                        'الحلول:\n'
                        '1. تحقق من رقم هاتفك في لوحة تحكم Twilio\n'
                        '2. قم بترقية حسابك من Trial إلى Live\n'
                        '3. استخدم رقم محقق للاختبار';
        } else if (errorData['message'] != null) {
          errorMessage = errorData['message'];
        }
        
        return {
          'success': false,
          'message': errorMessage,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sending OTP: $e',
      };
    }
  }
  
  // Verify OTP
  static Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String code) async {
    try {
      final url = Uri.parse('$_baseUrl/$serviceSid/VerificationCheck');
      
      final credentials = base64Encode(utf8.encode('$accountSid:$authToken'));
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': phoneNumber,
          'Code': code,
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'approved') {
          return {
            'success': true,
            'message': 'OTP verified successfully',
            'data': data,
          };
        } else {
          return {
            'success': false,
            'message': 'Invalid OTP code',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to verify OTP: ${response.body}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error verifying OTP: $e',
      };
    }
  }
}
