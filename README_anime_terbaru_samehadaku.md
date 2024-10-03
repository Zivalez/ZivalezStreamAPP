
## Cara Mengambil Data Anime Terbaru dari XML Sitemap Samehadaku.email dan Menggunakan di Flutter

### Pendahuluan
Pada pembahasan ini, kita akan mengambil informasi anime terbaru dari XML Sitemap **samehadaku.email** dan menampilkannya di aplikasi **Flutter**. Langkah-langkah ini meliputi:
1. Mengambil dan Memproses XML Sitemap.
2. Membuat API backend menggunakan Flask.
3. Menggunakan API di aplikasi Flutter untuk menampilkan data.

---

## Langkah 1: Mengambil dan Memproses XML Sitemap

Di situs **samehadaku.email**, terdapat sitemap di **https://samehadaku.email/sitemap_index.xml** yang mengarah ke sub-sitemaps seperti **https://samehadaku.email/post-sitemap9.xml**, yang berisi informasi anime terbaru.

### 1.1 Install Dependencies (Python)
Anda akan menggunakan **Python** dengan library **requests** dan **xml.etree.ElementTree** untuk mengambil dan memproses sitemap.

1. Pastikan Python sudah terinstall di sistem Anda.
2. Install **requests** library untuk mengambil data dari URL:
   ```bash
   pip install requests
   ```

### 1.2 Buat Skrip Python untuk Memproses Sitemap XML

Buat file Python baru, misalnya **scrape_sitemap.py**, lalu tambahkan kode berikut:

```python
import requests
import xml.etree.ElementTree as ET

# Fungsi untuk mengambil konten XML dari sitemap
def fetch_sitemap(sitemap_url):
    response = requests.get(sitemap_url)
    if response.status_code == 200:
        return response.text
    else:
        return None

# Fungsi untuk parsing data XML dan mengekstrak informasi anime
def parse_sitemap(xml_data):
    root = ET.fromstring(xml_data)  # Parse XML
    namespace = {'ns': 'http://www.sitemaps.org/schemas/sitemap/0.9'}  # Namespace XML
    
    anime_list = []
    
    # Cari semua elemen <url> dalam XML
    for url in root.findall('ns:url', namespace):
        loc = url.find('ns:loc', namespace).text  # URL anime
        lastmod = url.find('ns:lastmod', namespace).text  # Waktu modifikasi terakhir

        # Coba untuk mengambil gambar (jika ada)
        image = url.find('{http://www.google.com/schemas/sitemap-image/1.1}image/{http://www.google.com/schemas/sitemap-image/1.1}loc')
        if image is not None:
            image_url = image.text
        else:
            image_url = "No Image Available"

        # Tambahkan ke list anime
        anime_list.append({
            'url': loc,
            'lastmod': lastmod,
            'image_url': image_url
        })
    
    return anime_list

# URL sitemap dari samehadaku.email
sitemap_url = 'https://samehadaku.email/post-sitemap9.xml'

# Ambil XML dari sitemap
xml_data = fetch_sitemap(sitemap_url)
if xml_data:
    anime_list = parse_sitemap(xml_data)
    
    # Cetak hasilnya
    for anime in anime_list:
        print(f"URL: {anime['url']}")
        print(f"Last Modified: {anime['lastmod']}")
        print(f"Image URL: {anime['image_url']}")
        print('-' * 40)
else:
    print("Gagal mengambil sitemap.")
```

### 1.3 Jalankan Skrip
Untuk menjalankan skrip, buka terminal atau command prompt, lalu jalankan perintah:
```bash
python scrape_sitemap.py
```

Hasilnya akan mencetak **URL anime**, **waktu modifikasi terakhir**, dan **URL gambar** dari sitemap **post-sitemap9.xml**.

---

## Langkah 2: Membuat API dengan Flask

Setelah berhasil mengambil data dari sitemap, kita akan membuat API sederhana yang akan menyediakan data tersebut dalam format **JSON**. API ini nantinya bisa diakses dari aplikasi Flutter.

### 2.1 Install Flask
Untuk membuat API, Anda akan menggunakan **Flask**. Install Flask dengan perintah:
```bash
pip install Flask
```

### 2.2 Buat API Backend
Buat file baru, misalnya **app.py**, yang akan menyajikan data dari sitemap dalam format **JSON**.

```python
from flask import Flask, jsonify
import requests
import xml.etree.ElementTree as ET

app = Flask(__name__)

# Fungsi untuk mengambil XML sitemap
def fetch_sitemap(sitemap_url):
    response = requests.get(sitemap_url)
    if response.status_code == 200:
        return response.text
    else:
        return None

# Fungsi untuk parsing data XML dan mengekstrak informasi anime
def parse_sitemap(xml_data):
    root = ET.fromstring(xml_data)
    namespace = {'ns': 'http://www.sitemaps.org/schemas/sitemap/0.9'}
    
    anime_list = []
    
    for url in root.findall('ns:url', namespace):
        loc = url.find('ns:loc', namespace).text
        lastmod = url.find('ns:lastmod', namespace).text
        image = url.find('{http://www.google.com/schemas/sitemap-image/1.1}image/{http://www.google.com/schemas/sitemap-image/1.1}loc')
        if image is not None:
            image_url = image.text
        else:
            image_url = "No Image Available"

        anime_list.append({
            'url': loc,
            'lastmod': lastmod,
            'image_url': image_url
        })
    
    return anime_list

# Route API untuk menampilkan data anime terbaru
@app.route('/api/latest_anime', methods=['GET'])
def latest_anime():
    sitemap_url = 'https://samehadaku.email/post-sitemap9.xml'
    xml_data = fetch_sitemap(sitemap_url)
    if xml_data:
        anime_list = parse_sitemap(xml_data)
        return jsonify(anime_list)
    else:
        return jsonify({"error": "Failed to fetch sitemap"}), 500

if __name__ == '__main__':
    app.run(debug=True)
```

### 2.3 Jalankan API
Jalankan API dengan perintah:
```bash
python app.py
```

API ini sekarang berjalan di **http://localhost:5000/api/latest_anime**, yang akan memberikan daftar anime terbaru dalam format **JSON**.

---

## Langkah 3: Menggunakan API di Aplikasi Flutter

Sekarang kita akan menggunakan **API Flask** di aplikasi Flutter untuk mengambil data dan menampilkannya.

### 3.1 Tambahkan Dependency `http` di Flutter
Buka file **pubspec.yaml** di proyek Flutter Anda, dan tambahkan package **http** untuk melakukan request HTTP.

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
```

Jalankan perintah:
```bash
flutter pub get
```

### 3.2 Buat Kode Flutter untuk Mengambil Data dari API

Buat kode berikut di aplikasi Flutter Anda untuk mengambil data dari **API Flask** yang sudah Anda buat.

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimeList(),
    );
  }
}

class AnimeList extends StatefulWidget {
  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  List<dynamic> animeList = [];

  @override
  void initState() {
    super.initState();
    fetchAnimeData();
  }

  Future<void> fetchAnimeData() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/latest_anime'));

    if (response.statusCode == 200) {
      setState(() {
        animeList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load anime');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anime Terbaru')),
      body: animeList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: animeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(animeList[index]['image_url']),
                  title: Text(animeList[index]['url']),
                  subtitle: Text('Last Modified: ${animeList[index]['lastmod']}'),
                );
              },
            ),
    );
  }
}
```

### 3.3 Jalankan Aplikasi Flutter
Jalankan aplikasi Flutter Anda, dan aplikasi akan mengambil data dari **API Flask** yang menyediakan data anime terbaru dari **sitemap XML**.

---

## Kesimpulan:
1. **Mengambil Data dari Sitemap**: Anda telah mengambil data dari sitemap XML **samehadaku.email** menggunakan **Python** dan memprosesnya menjadi informasi yang dapat digunakan.
2. **Membuat API**: API Flask menyediakan data dari sitemap dalam format JSON, yang bisa diakses oleh aplikasi Flutter.
3. **Menggunakan API di Flutter**: Aplikasi Flutter Anda sekarang bisa menampilkan anime terbaru secara otomatis berdasarkan data dari sitemap XML.

Jika ada langkah yang tidak jelas, Anda bisa menghubungi untuk mendapatkan bantuan lebih lanjut. 
