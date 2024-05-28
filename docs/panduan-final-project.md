# PANDUAL FINAL PROJECT BACKEND AND FRONTEND

Buatlah storage managament system. Backend menggunakan NodeJs dan mobile
apps menggunakan flutter.

## DETAIL PENGERJAN FINAL PROJECT (SISI BACKEND)

* Buat Tabel
    * tabel users : 
        - id, 
        - username 
        - password 
        - image
    * tabel categories : 
        - id 
        - name
    * tabel products : 
        - id 
        - name 
        - qty 
        - categoryid 
        - url_product_image 
        - created_at 
        - updated_at 
        - created_by 
        - updated_by

* Buat API :
    * untuk login
    * untuk register
    * untuk menampilkan semua kategori
    * untuk menampulkan semua produk
    * untuk menampilkan 1 produk berdasarkan id
    * untuk memasukkan produk baru
    * untuk mengubah data 1 produk
    * untuk menghapus 1 produk
    * untuk upload image


## DETAIL PENGERJAN FINAL PROJECT (SISI FRONTEND)

* Login Page
* Register Page
* Home Page
* Detail Page


## CATATAN TAMBAHAN

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

