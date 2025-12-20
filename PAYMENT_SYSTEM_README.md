# سیستم پرداخت Halal Books

## بررسی کلی

سیستم پرداخت کامل برای اپلیکیشن Halal Books پیاده‌سازی شده است که شامل انواع مختلف پرداخت، درگاه‌های پرداخت متعدد و مدیریت کامل فرآیند پرداخت می‌باشد.

## ویژگی‌های اصلی

### 1. انواع پرداخت پشتیبانی شده
- **خرید کتاب** (`book`): برای خرید کتاب‌های منفرد یا چندتایی
- **خرید اشتراک** (`subscription`): برای خرید پلن‌های اشتراک
- **خرید کارت هدیه** (`gift_card`): برای خرید کارت هدیه
- **شارژ کیف پول** (`wallet`): برای شارژ کیف پول کاربر

### 2. درگاه‌های پرداخت
- **زرین‌پال** (`zarinpal`): درگاه پیش‌فرض
- **ملت** (`mellat`): درگاه جایگزین

### 3. قابلیت‌های اضافی
- اعمال کد تخفیف
- نمایش جزئیات فاکتور
- پیگیری پرداخت
- صفحه موفقیت پرداخت

## ساختار فایل‌ها

### مدل‌های داده
```
lib/data/api/payment/model/payment_model.dart
```
- `PaymentType`: enum برای انواع پرداخت
- `PaymentRequest`: مدل درخواست پرداخت
- `PaymentResponse`: مدل پاسخ پرداخت
- `PaymentTrackingResponse`: مدل پیگیری پرداخت

### API و Repository
```
lib/data/api/payment/payment_api.dart
lib/data/repository/payment_repository.dart
```
- تعریف endpoint های API
- مدیریت ارتباط با سرور

### State Management
```
lib/pages/payment/logic/payment_cubit.dart
lib/pages/payment/logic/payment_state.dart
```
- مدیریت state پرداخت با BLoC
- handle کردن loading، success و error states

### صفحات UI
```
lib/pages/payment/payment_success_page.dart
```
- صفحه موفقیت پرداخت
- پرداخت مستقیماً از صفحه سبد خرید انجام می‌شود

### سرویس‌های کمکی
```
lib/core/services/payment_service.dart
lib/core/services/payment_tracking_service.dart
lib/core/services/deep_link_service.dart
```
- سرویس اصلی پرداخت
- سرویس پیگیری پرداخت
- سرویس Deep Link برای بازگشت از درگاه پرداخت

## نحوه استفاده

### 1. پرداخت از سبد خرید
```dart
// در CartPage
void _handlePayment(BuildContext context, CartMeta meta) {
  final paymentUtility = GetIt.I<PaymentUtility>();
  final bookIds = meta.bookIds
      .map((id) => id is int ? id : int.tryParse(id.toString()))
      .where((id) => id != null)
      .cast<int>()
      .toList();

  paymentUtility.navigateToBookPayment(
    context,
    meta.total,
    bookIds,
  );
}
```

### 2. پرداخت اشتراک
```dart
final paymentUtility = GetIt.I<PaymentUtility>();
paymentUtility.navigateToSubscriptionPayment(
  context,
  amount,
  planId,
);
```

### 3. پرداخت کارت هدیه
```dart
final paymentUtility = GetIt.I<PaymentUtility>();
paymentUtility.navigateToGiftCardPayment(
  context,
  amount,
  mobileNumber,
);
```

### 4. شارژ کیف پول
```dart
final paymentUtility = GetIt.I<PaymentUtility>();
paymentUtility.navigateToWalletRecharge(
  context,
  amount,
);
```

## API Endpoints

### ایجاد پرداخت
```
POST /api/pay
```

**Request Body:**
```json
{
    "amount": 200000,
    "discount_code": "",
    "gateway_name": "zarinpal",
    "book_ids": [3, 1],
    "plan_id": 1,
    "type": "subscription"
}
```

**Response:**
```json
{
    "status": 200,
    "message": "اطلاعات درگاه پرداخت",
    "data": {
        "redirect_url": "https://sandbox.zarinpal.com/pg/StartPay/S000000000000000000000000000000vwo38",
        "paid_amount": 100000,
        "expire_time": 6
    },
    "code": 200
}
```

### پیگیری پرداخت
```
GET /api/payments/track/{trackingCode}
```

## Router Configuration

### مسیرهای جدید اضافه شده
```dart
// در lib/core/router/router.dart
static const String paymentSelectionRoute = '/paymentSelection';
static const String paymentSuccessRoute = '/paymentSuccess';
```

### تعریف Route ها
```dart
@TypedGoRoute<PaymentSelectionRoute>(
  path: PathRoute.paymentSelectionRoute,
)
class PaymentSelectionRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final extra = state.extra as Map<String, dynamic>;
    return PaymentSelectionPage(
      paymentType: extra['paymentType'] as PaymentType,
      amount: extra['amount'] as int,
      bookIds: extra['bookIds'] as List<int>?,
      planId: extra['planId'] as int?,
      mobile: extra['mobile'] as String?,
    );
  }
}
```

## Dependency Injection

### ثبت سرویس‌ها
```dart
// در lib/core/injection/injection.dart
@lazySingleton
PaymentService providePaymentService(PaymentCubit paymentCubit) => PaymentService(paymentCubit);

@lazySingleton
PaymentUtility providePaymentUtility(PaymentCubit paymentCubit) => PaymentUtility(paymentCubit);

@lazySingleton
PaymentTrackingService providePaymentTrackingService(PaymentCubit paymentCubit) => PaymentTrackingService(paymentCubit);
```

## Validation و Error Handling

### Validation مبلغ
```dart
bool isValidPaymentAmount(int amount) {
  return amount > 0 && amount <= 1000000000; // حداکثر 1 میلیارد تومان
}
```

### Error Handling
```dart
// در PaymentCubit
try {
  emit(const PaymentState.loading());
  final response = await _repository.createPayment(...);
  emit(PaymentState.success(response));
} catch (e) {
  emit(PaymentState.error(e.toString()));
}
```

## UI/UX Features

### 1. صفحه انتخاب درگاه پرداخت
- نمایش جزئیات پرداخت
- انتخاب درگاه پرداخت
- وارد کردن کد تخفیف
- نمایش loading state

### 2. صفحه موفقیت پرداخت
- نمایش آیکون موفقیت
- جزئیات پرداخت
- کد پیگیری
- دکمه‌های navigation

### 3. Responsive Design
- سازگار با اندازه‌های مختلف صفحه
- استفاده از Material Design
- رنگ‌بندی مناسب

## امنیت

### 1. Validation
- بررسی مبلغ پرداخت
- validation کد تخفیف
- بررسی نوع پرداخت

### 2. Error Handling
- مدیریت خطاهای شبکه
- نمایش پیام‌های مناسب
- fallback mechanisms

## تست

### تست‌های پیشنهادی
1. تست پرداخت موفق
2. تست پرداخت ناموفق
3. تست اعمال کد تخفیف
4. تست انواع مختلف پرداخت
5. تست navigation بین صفحات

## نکات مهم

### 1. Environment Variables
- تنظیم URL های API برای محیط‌های مختلف
- تنظیم درگاه‌های پرداخت

### 2. Localization
- تمام متن‌ها به فارسی
- پشتیبانی از RTL

### 3. Performance
- استفاده از lazy loading
- caching مناسب
- بهینه‌سازی network calls

## آینده‌نگری

### قابلیت‌های پیشنهادی برای آینده
1. پشتیبانی از درگاه‌های پرداخت بیشتر
2. سیستم loyalty points
3. پرداخت اقساطی
4. سیستم refund
5. گزارش‌گیری پیشرفته

## نتیجه‌گیری

سیستم پرداخت پیاده‌سازی شده یک راه‌حل کامل و قابل اعتماد برای مدیریت پرداخت‌های مختلف در اپلیکیشن Halal Books است. این سیستم با استفاده از بهترین practices و architecture patterns طراحی شده و قابلیت توسعه و نگهداری آسان را دارد.
