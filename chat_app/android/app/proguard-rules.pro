# Flutter ve Dart optimizasyonu
-keep class io.flutter.** { *; }
-keep class androidx.** { *; }
-keep class com.google.** { *; }

# SharedPreferences için
-keep class android.content.SharedPreferences { *; }

# JSON parsing için
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }

# Uygulama sınıfları
-keep class com.sohbet.chat_app.** { *; }

# Genel optimizasyon
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-verbose
-optimizationpasses 5