#!/bin/bash

echo "🚀 Android Sohbet Uygulaması APK Builder"
echo "========================================="

# Flutter path ayarla
export PATH="/tmp/flutter/bin:$PATH"

# Flutter version kontrol
echo "📱 Flutter version kontrol ediliyor..."
flutter --version

# Dependencies yükle
echo "📦 Dependencies yükleniyor..."
flutter pub get

# Clean
echo "🧹 Proje temizleniyor..."
flutter clean

# Web version build (hızlı test için)
echo "🌐 Web version build ediliyor..."
flutter build web --base-href /chat_app/

echo ""
echo "✅ Web version başarıyla oluşturuldu!"
echo "📁 Konum: build/web/"
echo ""

# APK build deneme (Android SDK gerekli)
echo "📱 APK build deneniyor..."
if flutter build apk --release --no-tree-shake-icons; then
    echo "✅ APK başarıyla oluşturuldu!"
    echo "📁 Konum: build/app/outputs/flutter-apk/app-release.apk"
    echo "📦 APK boyutu:"
    ls -lh build/app/outputs/flutter-apk/app-release.apk 2>/dev/null || echo "APK dosyası bulunamadı"
else
    echo "⚠️  APK build başarısız - Android SDK gerekli"
    echo ""
    echo "💡 APK oluşturmak için:"
    echo "1. Android Studio'yu indirin ve yükleyin"
    echo "2. Android SDK'yı kurun"
    echo "3. flutter doctor komutunu çalıştırın"
    echo "4. Bu scripti tekrar çalıştırın"
    echo ""
    echo "🌐 Şimdilik web versiyonu kullanabilirsiniz!"
fi

echo ""
echo "🎯 Test için:"
echo "- Web: http://localhost:8080"
echo "- APK: build/app/outputs/flutter-apk/ klasörünü kontrol edin"
echo ""