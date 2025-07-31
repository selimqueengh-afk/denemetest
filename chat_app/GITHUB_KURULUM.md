# 🚀 GitHub APK Kurulum Rehberi

Bu rehber ile 5 dakikada GitHub'da otomatik APK oluşturma sistemi kurabilirsiniz.

## 📋 Adım Adım Kurulum

### 1️⃣ GitHub Hesabı Oluşturun
- [github.com](https://github.com) adresine gidin
- **Sign up** ile ücretsiz hesap oluşturun
- Email doğrulaması yapın

### 2️⃣ Yeni Repository Oluşturun
1. GitHub'da **"New repository"** butonuna basın
2. Repository adı: **`android-sohbet-uygulamasi`**
3. **Public** seçin (ücretsiz Actions için)
4. **Add a README file** ✅
5. **Create repository** butonuna basın

### 3️⃣ Kodu Yükleyin

**Yöntem A: GitHub Web Arayüzü (Kolay)**
1. Repository sayfasında **"uploading an existing file"** linkine tıklayın
2. Bu klasördeki TÜM dosyaları sürükleyin:
   - `lib/` klasörü
   - `android/` klasörü
   - `.github/` klasörü
   - `pubspec.yaml`
   - `README.md`
   - Diğer tüm dosyalar
3. Commit message: "İlk sürüm - Android sohbet uygulaması"
4. **Commit changes** butonuna basın

**Yöntem B: Git Komutları (Gelişmiş)**
```bash
git clone https://github.com/KULLANICI_ADINIZ/android-sohbet-uygulamasi.git
cd android-sohbet-uygulamasi
# Dosyaları kopyalayın
git add .
git commit -m "İlk sürüm - Android sohbet uygulaması"
git push origin main
```

### 4️⃣ Actions'ı Aktifleştirin
1. Repository'de **"Actions"** sekmesine gidin
2. **"I understand my workflows, enable them"** butonuna basın
3. Otomatik olarak APK build başlayacak

### 5️⃣ APK İndirin
**Build tamamlandıktan sonra (5-10 dakika):**
1. **Actions** sekmesine gidin
2. En üstteki yeşil ✅ build'e tıklayın
3. **Artifacts** bölümünde APK dosyaları görünecek
4. **"📱 Sohbet Uygulaması (Universal APK)"** dosyasını indirin

## 🎯 Otomatik APK Sistemi

### 📱 Ne Zaman APK Oluşur?
- ✅ Kod yüklediğinizde
- ✅ Kod güncellendiğinde
- ✅ Manuel tetiklediğinizde

### 📁 APK Dosyaları
- **Universal APK**: Tüm Android cihazlar için
- **Split APK'lar**: Belirli mimariler için
- **Boyut**: ~15MB (optimizasyonlu)

### 🔄 Güncelleme Yapmak
1. Dosyaları düzenleyin
2. GitHub'a yükleyin
3. Otomatik yeni APK oluşur

## 🏷️ Release Oluşturmak (Opsiyonel)

### Daha Profesyonel APK Dağıtımı İçin:
1. **Releases** sekmesine gidin
2. **"Create a new release"** butonuna basın
3. Tag version: `v1.0.0`
4. Release title: `Sohbet Uygulaması v1.0.0`
5. APK dosyalarını ekleyin
6. **Publish release** butonuna basın

## 📲 APK İndirme Linkleri

Kurulum tamamlandıktan sonra bu linkler çalışacak:

### 🔗 Direkt İndirme
```
https://github.com/KULLANICI_ADINIZ/android-sohbet-uygulamasi/releases/latest/download/sohbet-uygulamasi-universal.apk
```

### 📋 Sayfa Linkleri
- **Actions**: `https://github.com/KULLANICI_ADINIZ/android-sohbet-uygulamasi/actions`
- **Releases**: `https://github.com/KULLANICI_ADINIZ/android-sohbet-uygulamasi/releases`

## ⚠️ Önemli Notlar

### 🔧 README Düzenleme
1. `README.md` dosyasını açın
2. `USERNAME/REPO_NAME` kısımlarını kendi bilgilerinizle değiştirin:
   ```
   USERNAME → KULLANICI_ADINIZ
   REPO_NAME → android-sohbet-uygulamasi
   ```

### 📱 APK Test Etme
1. Android cihazınızda **Bilinmeyen kaynaklar** izni verin
2. APK'yı indirin ve yükleyin
3. Uygulamayı test edin

### 🚀 Actions Limitleri (Ücretsiz Hesap)
- **2000 dakika/ay** build süresi
- **500MB** artifacts storage
- **Public** repository gerekli

## 🆘 Sorun Giderme

### ❌ Build Başarısız Olursa
1. **Actions** sekmesinde hata detaylarını kontrol edin
2. En yaygın sorunlar:
   - Dosya yapısı hatası
   - pubspec.yaml formatı
   - Android konfigürasyonu

### 🔍 Hata Kontrolü
```bash
# Yerel test için
flutter analyze
flutter build apk --release
```

### 💬 Yardım
- GitHub Issues açın
- [Flutter dokümantasyonu](https://flutter.dev/docs)
- [GitHub Actions rehberi](https://docs.github.com/en/actions)

## 🎉 Tebrikler!

✅ Artık otomatik APK build sisteminiz hazır!
✅ Her kod güncellemesinde yeni APK oluşacak!
✅ APK dosyalarınızı kolayca paylaşabilirsiniz!

---

## 📱 Hızlı Başlangıç Linki

Bu kurulumu tamamladıktan sonra APK indirme linkiniz:

**`https://github.com/KULLANICI_ADINIZ/android-sohbet-uygulamasi/releases/latest/download/sohbet-uygulamasi-universal.apk`**

*KULLANICI_ADINIZ kısmını kendi GitHub kullanıcı adınızla değiştirin!*