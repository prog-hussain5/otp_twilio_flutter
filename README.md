# تطبيق التحقق من OTP باستخدام Twilio

## إعداد التطبيق

### 1. إنشاء حساب Twilio

1. اذهب إلى [Twilio Console](https://console.twilio.com)
2. أنشئ حساب جديد أو سجل الدخول إلى حسابك الحالي
3. تحقق من رقم هاتفك

### 2. إعداد Verify Service

1. في لوحة تحكم Twilio، انتقل إلى **Verify** > **Services**
2. اضغط على **Create new Service**
3. أدخل اسم الخدمة (مثل: "My OTP App")
4. احفظ **Service SID** الذي سيظهر

### 3. الحصول على بيانات الاعتماد

### Account SID و Auth Token
1. في الصفحة الرئيسية للوحة التحكم
2. انسخ **Account SID**
3. انسخ **Auth Token** (اضغط على "Show" لإظهاره)

### Service SID
1. انتقل إلى **Verify** > **Services**
2. اختر الخدمة التي أنشأتها
3. انسخ **Service SID**

### 2. تكوين البيانات

افتح ملف `lib/services/twilio_service.dart` وأضف بياناتك:

```dart
static const String accountSid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
static const String authToken = 'your_auth_token_here';
static const String serviceSid = 'VAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
```

### 3. تشغيل التطبيق

```bash
flutter pub get
flutter run
```

## الحزم المستخدمة

- **intl_phone_field**: لإدخال رقم الهاتف مع اختيار الدولة
- **pinput**: لحقل إدخال OTP بتصميم جميل
- **google_fonts**: للخطوط العربية الجميلة
- **lottie**: للرسوم المتحركة
- **flutter_spinkit**: لمؤشرات التحميل
- **http**: للتواصل مع API
- **shared_preferences**: لحفظ البيانات محلياً
