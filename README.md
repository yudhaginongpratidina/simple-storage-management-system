# STORAGE MANAGEMENT SYSTEM (EXPRESS + FLUTTER)

- CREATED BY <b>YUDHA GINONG PRATIDINA</b>
- VERSION <b>1.0.0</b>
- DOKUMENTASI API -

## STRUKTUR TABEL

- Tabel Users : 
    - id 
    - username 
    - password 
    - image
- Tabel Categories : 
    - id 
    - name
- Tabel Products: 
    - id, 
    - name 
    - qty 
    - categoryid 
    - url_product_image 
    - created_at 
    - updated_at 
    - created_by 
    - updated_by

## DETAIL PENGERJAAN DI SISI BACK END

- API untuk login
- API untuk register
- API untuk menampilkan semua kategori
- API untuk menampulkan semua produk
- API untuk menampilkan 1 produk berdasarkan id
- API untuk memasukkan produk baru
- API untuk mengubah data 1 produk
- API untuk menghapus 1 produk
- API untuk upload image

## DETAIL PENGERJAAN DI SISI FRONT END

- Login Page
- Register Page
- Main menu page untuk menampilkan daftar produk
- Form insert new product dan update product

## CATATEN PENTING

Jika proyek sudah selesai buatlah laporan berisi dikumentasi dari proyek yang sudah dibuat.
Laporan berisikan potongan code dan menjelaskan logika dari potangan yang dicantumkan. Sebagai contoh


```dart
Future<List<DataMitra>> allMitra() async {
    ApiService apiService = new ApiService();
    var url = baseUrlProd + mitraAll;
    var response = awail apiService.invokeHttp(url, RequestType.GET);
    return MitraResponse.fromJson(response.body).data!;
}
```

Logika : Script diatas digunakan untuk mengambil data dari API dengan url API dimasukkan
kedalam variabel url lalu response di convert dari json ke dalam model
