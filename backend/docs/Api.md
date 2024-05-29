# API DOCUMENTAION

```text
http://<hostname>:<port>/<endpoint>
```

```text
http://localhost:8000/users
```

## API UNTUK USER DAN AUTHENTICATION

| **METHOD** | **END POINT** | **DESKRIPSI**                        |
|------------|---------------|--------------------------------------|
| GET        | /users        | Mendapatkan semua data user          |
| GET        | /users/:id    | Mendapatkan data user berdasarkan id |
| POST       | /users        | Membuat user baru / register         |
| POST       | /login        | Login user                           |
| DELETE     | /users/:id    | Menghapus data user berdasarkan id   |


## API UNTUK CATEGORY

| **METHOD** | **END POINT**        | **DESKRIPSI**                                 |
|------------|----------------------|-----------------------------------------------|
| GET        | /categories          | Mendapatkan semua data kategori               |
| GET        | /categories/:id      | Mendapatkan data kategori berdasarkan id      |
| POST       | /categories          | Mebuat / menambah data kategori               |
| PATCH      | /categories/:id      | Mengupdate data kategori berdasarkan id       |
| DELETE     | /categories/:id      | Menghapus data kategori berdasarkan id        |


## API UNTUK PRODUCT


## API UNTUK AKSES IMAGE