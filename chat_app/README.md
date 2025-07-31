# 📱 Android Sohbet Uygulaması

[![🚀 Android APK Build](https://github.com/USERNAME/REPO_NAME/actions/workflows/build_apk.yml/badge.svg)](https://github.com/USERNAME/REPO_NAME/actions/workflows/build_apk.yml)
[![📱 Latest Release](https://img.shields.io/github/v/release/USERNAME/REPO_NAME?label=Son%20S%C3%BCr%C3%BCm)](https://github.com/USERNAME/REPO_NAME/releases/latest)

Flutter ile geliştirilmiş modern ve kullanıcı dostu **Android sohbet uygulaması**.

## 📲 APK İNDİR

### 🎯 Hızlı İndirme

**👆 [En Son APK İndir](https://github.com/USERNAME/REPO_NAME/releases/latest/download/sohbet-uygulamasi-universal.apk)** 

### 📁 Tüm Sürümler
- **[Releases Sayfası](https://github.com/USERNAME/REPO_NAME/releases)** - Tüm APK dosyaları
- **[Actions Sayfası](https://github.com/USERNAME/REPO_NAME/actions)** - En güncel build'ler

## 🎮 Uygulama Özellikleri

### ✨ Ana Özellikler
- 🗨️ **Çoklu Sohbet Odaları** - Farklı konularda sohbet edin
- 💬 **Gerçek Zamanlı Mesajlaşma** - Anlık mesaj gönderimi
- 👤 **Profil Yönetimi** - Kullanıcı adını düzenleyin
- 💾 **Yerel Veri Saklama** - Veriler güvenle cihazda saklanır
- 🎨 **Modern UI/UX** - Material Design 3 arayüzü
- 🌙 **Türkçe Arayüz** - Tamamen Türkçe kullanıcı deneyimi

### 📱 Teknik Özellikler
- **Flutter 3.32.8** ile geliştirildi
- **Android 5.0+** (API 21) desteği
- **SharedPreferences** ile veri saklama
- **Optimizasyonlu APK** (~15MB)
- **ARM, ARM64, x64** mimari desteği

## 📲 Kurulum

### 1️⃣ APK İndirin
- [Releases sayfasından](https://github.com/USERNAME/REPO_NAME/releases/latest) **sohbet-uygulamasi-universal.apk** dosyasını indirin

### 2️⃣ Bilinmeyen Kaynakları Aktifleştirin
- **Ayarlar** > **Güvenlik** > **Bilinmeyen kaynaklar** ✅
- Veya Chrome'da indirme sırasında izin verin

### 3️⃣ APK'yı Yükleyin
- İndirilen APK dosyasına dokunun
- **Yükle** butonuna basın
- Kurulum tamamlanana kadar bekleyin

### 4️⃣ Uygulamayı Açın
- Ana ekranda "Sohbet Uygulaması" ikonuna dokunun
- İlk açılışta örnek sohbet odaları otomatik oluşturulur

## 🎯 Nasıl Kullanılır

### 🏠 Ana Ekran
- **Sohbet odaları listesi** görüntülenir
- **+** butonu ile yeni oda oluşturun
- **Profil** ikonundan ayarlara gidin

### 💬 Sohbet Etme
1. Bir sohbet odasına dokunun
2. Alt kısımdaki metin kutusuna mesajınızı yazın
3. **Gönder** butonuna basın
4. Diğer kullanıcılardan otomatik mesajlar gelecek

### 👤 Profil Düzenleme
1. Ana ekranda **profil** ikonuna dokunun
2. **Kalem** ikonuna basarak kullanıcı adını değiştirin
3. **✓** işareti ile kaydedin

## 🛠️ Geliştirici Bilgileri

### 📋 Proje Yapısı
```
lib/
├── main.dart                    # Ana uygulama
├── models/                      # Veri modelleri
│   ├── message.dart            # Mesaj modeli
│   └── chat_room.dart          # Sohbet odası modeli
├── services/                    # İş mantığı
│   └── chat_service.dart       # Veri yönetimi
└── screens/                     # UI ekranları
    ├── chat_rooms_screen.dart  # Ana sohbet listesi
    ├── chat_screen.dart        # Mesajlaşma ekranı
    ├── create_room_screen.dart # Oda oluşturma
    └── profile_screen.dart     # Profil yönetimi
```

### 🔧 Build Etme
```bash
# Dependencies yükle
flutter pub get

# APK build et
flutter build apk --release

# APK konumu
build/app/outputs/flutter-apk/app-release.apk
```

### 📦 Dependencies
- `flutter` - Flutter framework
- `shared_preferences` - Yerel veri saklama
- `intl` - Tarih/saat formatlaması

## 🤝 Katkıda Bulunma

1. **Fork** oluşturun
2. **Feature branch** oluşturun (`git checkout -b feature/yeni-ozellik`)
3. **Commit** edin (`git commit -m 'Yeni özellik eklendi'`)
4. **Push** edin (`git push origin feature/yeni-ozellik`)
5. **Pull Request** oluşturun

## 📝 Sürüm Notları

### v1.0.0 (İlk Sürüm)
- ✅ Temel sohbet odası işlevselliği
- ✅ Mesaj gönderme/alma
- ✅ Profil yönetimi
- ✅ Yerel veri saklama
- ✅ Material Design UI

## 🐛 Sorun Bildirme

Bir sorun mu buldunuz? [Issue oluşturun](https://github.com/USERNAME/REPO_NAME/issues/new)!

**Bilgi verirken:**
- 📱 Android sürümünüz
- 📋 Hatanın ayrıntılı açıklaması
- 🔍 Hatayı tekrarlama adımları

## 📄 Lisans

Bu proje MIT lisansı altında yayınlanmıştır. Detaylar için [LICENSE](LICENSE) dosyasını inceleyebilirsiniz.

## 📞 İletişim

- 📧 GitHub Issues
- 💬 Discussions sekmesi
- ⭐ Star vererek destek olun!

---

## 🚀 Hemen İndirin!

**[📱 APK İNDİR](https://github.com/USERNAME/REPO_NAME/releases/latest/download/sohbet-uygulamasi-universal.apk)**

*Android 5.0+ | Boyut: ~15MB | Ücretsiz*
