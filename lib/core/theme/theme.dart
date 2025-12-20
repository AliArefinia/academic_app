import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const.dart';


class AppTheme {
  static const Color primaryColor = Color(0xFF3BA5B8); // سبز-آبی سرد روشن نزدیک به لوگو
  static const Color secondaryColor = Color(0xFFF1F3F6);
  static const Color textColor = Color(0xFF373737);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF3F3F3);
  static const Color surfaceContainer = Color(0xFFDADADA);
  static const Color onSurfaceColor = Color(0xFF4D4D4D);
  static const Color outlineColor = Color(0xFF838383);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFFFAFAFA);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x99E3E3E3);
  static const Color unEnabledButtonColor = Color(0xffCACACA);
  static const Color iconColor = Color(0xffa9a9a9);



  static const Color txtLabelColor = Color(0xFF8F8F8F);


  // رنگ‌های اصلی تم تیره
  static const Color bodyMediumTextColor = Color(0xFF747474);
  static const Color bodyLargeTextColor = Color(0xFFB9B9B9);
  
  // رنگ اصلی برای دارک مود - رنگ سبز-آبی سرد روشن نزدیک به لوگو
  static const Color darkPrimaryColor = Color(0xFF3BA5B8);
  
  // رنگ ثانویه در تم تیره - رنگ خاکستری روشن
  static const Color darkSecondaryColor = Color(0xFFF1F3F6);
  
  // رنگ متن اصلی در تم تیره - روشن و واضح
  static const Color darkTextColor = Color(0xFFE8E8E8);
  
  // رنگ پس‌زمینه در تم تیره - تیره اما نه کاملا سیاه
  static const Color darkBackgroundColor = Color(0xFF0F0F0F);
  
  // رنگ outline در تم تیره
  static const Color darkOutlineColor = Color(0xFF4A4A4A);
  
  // رنگ سطوح در تم تیره - کمی روشن‌تر از پس‌زمینه
  static const Color darkSurfaceColor = Color(0xFF1A1A1A);
  
  // رنگ container در تم تیره
  static const Color darkSurfaceContainer = Color(0xFF242424);
  
  // رنگ variant outline
  static const Color darkOutlineVariantColor = Color(0xFF5A5A5A);
  
  // رنگ روی سطح - متن روشن
  static const Color darkOnSurfaceColor = Color(0xFFE0E0E0);
  
  // رنگ variant روی سطح - کمی کم‌رنگ‌تر
  static const Color darkOnSurfaceVariant = Color(0xFFA8A8A8);
  
  // رنگ خطا در تم تیره - قرمز روشن
  static const Color darkErrorColor = Color(0xFFFF6B6B);
  
  // رنگ متن روی رنگ اصلی در تم تیره - سفید برای خوانایی روی آبی
  static const Color darkOnPrimaryColor = Color(0xFFFFFFFF);
  
  // رنگ متن روی رنگ ثانویه در تم تیره
  static const Color darkOnSecondaryColor = Color(0xFFE8E8E8);
  
  // رنگ متن روی رنگ خطا در تم تیره
  static const Color darkOnErrorColor = Color(0xFF1A1A1A);
  
  // رنگ label در تم تیره
  static const Color darkTxtLabelColor = Color(0xFF9E9E9E);
  
  // سایه در تم تیره
  static const Color darkShadow = Colors.transparent;
  
  // رنگ دکمه غیرفعال در تم تیره
  static const Color darkUnEnabledButtonColor = Color(0xFF3A3A3A);
  
  // رنگ آیکون در تم تیره
  static const Color darkIconColor = Color(0xFFB0B0B0);
  
  // رنگ کارت در تم لایت (تیره‌تر از سفید)
  static const Color lightCardColor = Color(0xFFF5F5F5);

  ThemeData myTheme(bool isLight) {
    return ThemeData(
      // Card theme با elevation مناسب
      cardTheme: CardThemeData(
        shadowColor: isLight ? shadow : darkShadow, 
        elevation: isLight ? 5 : 2,
        color: isLight ? lightCardColor : darkSurfaceColor,
        surfaceTintColor: isLight ? null : darkSurfaceColor,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: isLight ? backgroundColor : darkBackgroundColor,
      fontFamily: 'yakanBakh',
      
      // Icon theme با رنگ مناسب
      iconTheme: IconThemeData(
        color: isLight ? onSurfaceColor : darkIconColor,
      ),
      
      // Outlined button با رنگ‌های پویا
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(color: isLight ? outlineColor : darkOutlineColor),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.corner12),
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            isLight ? textColor : darkTextColor,
          ),
        ),
      ),
      
      // Elevated button با رنگ‌های صحیح
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.corner16),
            ),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: AppSpacing.s16),
          ),
          foregroundColor: WidgetStatePropertyAll(
            isLight ? onPrimaryColor : darkOnPrimaryColor,
          ),
          backgroundColor: WidgetStatePropertyAll(
            isLight ? primaryColor : darkPrimaryColor,
          ),
          elevation: WidgetStatePropertyAll(isLight ? 2 : 0),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? surfaceColor : darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          borderSide: BorderSide(
            color: isLight ? outlineColor : darkOutlineColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          borderSide: BorderSide(
            color: isLight ? outlineColor : darkOutlineColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          borderSide: BorderSide(
            color: isLight ? primaryColor : darkPrimaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          borderSide: BorderSide(
            color: isLight ? errorColor : darkErrorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          borderSide: BorderSide(
            color: isLight ? errorColor : darkErrorColor,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: isLight ? txtLabelColor : darkTxtLabelColor,
        ),
        hintStyle: TextStyle(
          color: isLight ? txtLabelColor : darkTxtLabelColor,
        ),
        prefixIconColor: isLight ? iconColor : darkIconColor,
        suffixIconColor: isLight ? iconColor : darkIconColor,
      ),
      
      // Divider theme
      dividerTheme: DividerThemeData(
        color: isLight ? outlineColor : darkOutlineColor,
        thickness: 1,
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isLight ? backgroundColor : darkSurfaceColor,
        selectedItemColor: isLight ? primaryColor : darkPrimaryColor,
        unselectedItemColor: isLight ? iconColor : darkIconColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // ColorScheme با brightness صحیح
      colorScheme: isLight 
        ? ColorScheme.light(
            primary: primaryColor,
            outline: outlineColor,
            surfaceContainer: surfaceContainer,
            onPrimary: onPrimaryColor,
            secondary: secondaryColor,
            onSecondary: onSecondaryColor,
            error: errorColor,
            onError: onErrorColor,
            surface: surfaceColor,
            onSurface: onSurfaceColor,
            shadow: shadow,
            surfaceTint: surfaceColor,
          )
        : ColorScheme.dark(
            primary: darkPrimaryColor,
            outline: darkOutlineColor,
            outlineVariant: darkOutlineVariantColor,
            surfaceContainer: darkSurfaceContainer,
            onPrimary: darkOnPrimaryColor,
            secondary: darkSecondaryColor,
            onSecondary: darkOnSecondaryColor,
            error: darkErrorColor,
            onError: darkOnErrorColor,
            surface: darkSurfaceColor,
            onSurface: darkOnSurfaceColor,
            shadow: darkShadow,
            surfaceTint: darkSurfaceColor,
            onSurfaceVariant: darkOnSurfaceVariant,
          ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: isLight ? Colors.grey.shade50 : darkSurfaceColor,
        foregroundColor: isLight ? textColor : darkTextColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isLight ? onSurfaceColor : darkIconColor,
        ),
        surfaceTintColor: isLight ? Colors.grey.shade50 : darkSurfaceColor,
        systemOverlayStyle: isLight 
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? textColor : darkTextColor,
            fontFamily: 'yakanBakh'
        ),
      ),
      textTheme: TextTheme(
        // 0
          displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.bold,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          displaySmall: TextStyle(
            fontSize: 36,
            letterSpacing: 0,
            wordSpacing: 0,
            fontWeight: FontWeight.w800,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          headlineLarge: TextStyle(
            fontSize: 32,
            letterSpacing: 0,
            wordSpacing: 0,
            fontWeight: FontWeight.bold,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          headlineMedium: TextStyle(
            fontSize: 18,
            letterSpacing: 0,
            wordSpacing: 0,
            fontWeight: FontWeight.w700,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? textColor : darkTextColor,
          ),
          // 1 font weight
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isLight ? textColor : darkTextColor,
            letterSpacing: 0,
            wordSpacing: 0,
          ),
          // 0
          titleSmall: TextStyle(
            letterSpacing: 0,
            wordSpacing: 0,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? bodyLargeTextColor : darkTextColor,
          ),
          // 0
          bodyMedium: TextStyle(
            letterSpacing: 0,
            wordSpacing: 0,
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w600,
            color: isLight ? bodyMediumTextColor : darkTextColor,
          ),
          // 0
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            wordSpacing: 0,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          labelLarge: TextStyle(
            fontSize: 14,
            letterSpacing: 0,
            wordSpacing: 0,
            fontWeight: FontWeight.w700,
            color: isLight ? textColor : darkTextColor,
          ),
          // 0
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            wordSpacing: 0,
            height: 1.5,
            color: isLight ? txtLabelColor : darkTxtLabelColor,
          ),
          // 0
          labelSmall: TextStyle(
            letterSpacing: 0,
            wordSpacing: 0,
            fontSize: 10,
            color: isLight ? textColor : darkTextColor,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
