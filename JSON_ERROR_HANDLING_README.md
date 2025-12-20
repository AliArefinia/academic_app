# 🔥 سیستم مدیریت خطای JSON پارسینگ

## مشکل قبلی
قبلاً وقتی در زمان پارس کردن JSON خطایی رخ می‌داد:
- هیچ لاگ مفصلی نشان داده نمی‌شد
- Stack trace کامل نمایش داده نمی‌شد  
- اطلاعات کافی برای دیباگ وجود نداشت
- هر مدل به شکل متفاوتی خطاها را مدیریت می‌کرد

## راه‌حل جدید

### 1. JsonParsingErrorHandler
یک کلاس جامع برای مدیریت خطاهای JSON پارسینگ که شامل:
- لاگ مفصل خطاها با timestamp
- نمایش کامل Stack trace  
- تجزیه و تحلیل JSON برای شناسایی مشکلات
- نمایش اطلاعات endpoint و HTTP method
- تشخیص مشکلات رایج (null values، type mismatches)

### 2. ParseErrorLogger
پیاده‌سازی ParseErrorLogger برای کدهای تولید شده Retrofit

## مدل‌های بروزرسانی شده

### ✅ مدل‌هایی که بروزرسانی شده‌اند:

#### Core Models:
- `PersonModel` - مدل اشخاص
- `BookModel` - مدل کتاب‌ها  
- `UserModel` - مدل کاربر
- `AuthResponse` - پاسخ احراز هویت
- `UserReviewModel` - نظرات کاربران

#### Product Models:
- `ProductModel` - مدل محصول
- `ExcerptModel` - مدل گزیده‌ها
- `CommentModel` - مدل نظرات
- `HeadlineModel` - مدل سرفصل‌ها
- `TimeModel` - مدل زمان

#### Payment Models:
- `PaymentRequest` - درخواست پرداخت
- `PaymentResponse` - پاسخ پرداخت
- `PaymentApiResponse` - پاسخ API پرداخت
- `PaymentTrackingResponse` - پاسخ پیگیری پرداخت
- `PaymentVerifyRequest` - درخواست تایید پرداخت
- `PaymentVerifyResponse` - پاسخ تایید پرداخت

#### Home Models:
- `HomeResponse` - پاسخ صفحه اصلی
- `SliderSection` - بخش اسلایدر
- `BannerSection` - بخش بنر
- `CategorySection` - بخش دسته‌بندی
- `BookSection` - بخش کتاب‌ها
- `SliderModel` - مدل اسلایدر
- `BannerModel` - مدل بنر

#### Cart & Purchase Models:
- `CartResponse` - پاسخ سبد خرید
- `CartMeta` - متادیتای سبد خرید
- `CartItemModel` - مدل آیتم سبد خرید
- `PurchasedBookModel` - مدل کتاب خریداری شده
- `PurchaseItemModel` - مدل آیتم خرید
- `MyPurchasesResponse` - پاسخ خریدهای من

#### Auth Models:
- `LoginResponse` - پاسخ ورود
- `User` - کاربر
- `AuthPhoneModel` - مدل احراز هویت تلفن

#### Subscription Models:
- `SubscriptionPlanModel` - مدل پلان اشتراک
- `SubscriptionPlansResponse` - پاسخ پلان‌های اشتراک

#### My Books Models:
- `MyBooksRootResponse` - پاسخ ریشه کتاب‌های من
- `MyBooksResponse` - پاسخ کتاب‌های من
- `MyBookItem` - آیتم کتاب من

#### Other Models:
- `CategoryModel` - مدل دسته‌بندی

## نحوه استفاده

### برای مدل‌های جدید:

```dart
import 'package:halalbooks/core/error/json_parsing_error_handler.dart';

factory YourModel.fromJson(Map<String, dynamic> json) {
  return JsonParsingErrorHandler.handleParsingError<YourModel>(
    modelName: 'YourModel',
    json: json,
    parseFunction: () => _$YourModelFromJson(json),
  );
}
```

### برای مدل‌های پیچیده:

```dart
factory ComplexModel.fromJson(Map<String, dynamic> json) {
  return JsonParsingErrorHandler.handleParsingError<ComplexModel>(
    modelName: 'ComplexModel',
    json: json,
    parseFunction: () {
      // منطق پیش‌پردازش
      if (json['someField'] != null && json['someField'] is! Map) {
        json['someField'] = {'id': json['someField']};
      }
      return _$ComplexModelFromJson(json);
    },
  );
}
```

## خروجی نمونه خطا

```
🔥 JSON_PARSING_ERROR ═══════════════════════════════════════
⏰ Timestamp: 2024-01-15T10:30:45.123Z
🏷️  Model: BookModel
🌐 Endpoint: /api/books/123
📊 HTTP Method: GET
💥 Error Type: FormatException
📝 Error Message: Invalid number format

📋 JSON Analysis:
   • Keys count: 8
   • Keys: [id, name, author, price, discount_price, publisher, type, image]
   • Potential Issues:
     - String "invalid_price" for key "price" might should be double
     - Null value for key: author

📍 Stack Trace:
   00: #0      _$BookModelFromJson (package:halalbooks/data/api/home/model/book_model.g.dart:15:23)
   01: #1      BookModel.fromJson.<anonymous closure> (package:halalbooks/data/api/home/model/book_model.dart:72:32)
   02: #2      JsonParsingErrorHandler.handleParsingError (package:halalbooks/core/error/json_parsing_error_handler.dart:25:18)
   ...
═══════════════════════════════════════════════════════════════════════════
```

## مزایای سیستم جدید

### 🔍 دیباگ بهتر
- لاگ کامل و مفصل خطاها
- تشخیص خودکار مشکلات رایج
- نمایش JSON دریافتی برای بررسی

### 🛡️ مدیریت یکپارچه
- همه مدل‌ها از یک سیستم واحد استفاده می‌کنند
- کد تمیز و قابل نگهداری
- عدم تکرار کد

### 📊 اطلاعات کامل
- Endpoint و HTTP method
- Timestamp دقیق
- تجزیه و تحلیل JSON
- Stack trace کامل

### 🚀 عملکرد بهتر
- فقط در صورت خطا لاگ می‌کند
- در حالت release قابل تنظیم
- بهینه‌سازی شده برای production

## نکات مهم

1. **همیشه modelName را صحیح وارد کنید** - برای شناسایی بهتر خطاها
2. **از parseFunction برای منطق پیچیده استفاده کنید** - نه در خود fromJson
3. **Import را فراموش نکنید** - `import 'package:halalbooks/core/error/json_parsing_error_handler.dart';`
4. **برای مدل‌های Freezed** - از extension SafeJsonParsing استفاده کنید

## تست کردن

برای تست کردن سیستم، می‌توانید JSON نامعتبر ارسال کنید:

```dart
// JSON با خطا
final invalidJson = {'price': 'invalid_number', 'author': null};
try {
  final book = BookModel.fromJson(invalidJson);
} catch (e) {
  // خطای مفصل در کنسول نمایش داده می‌شود
}
```

---

**نکته:** این سیستم در حال حاضر برای بیش از 30 مدل اصلی پروژه پیاده‌سازی شده است. برای مدل‌های جدید، حتماً از این الگو استفاده کنید.
