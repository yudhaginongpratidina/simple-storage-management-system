# INSTALLATION

## CLONE REPOSITORY

```bash
git clone https://github.com/yudhaginongpratidina/simple-storage-management-system.git
cd simple-storage-management-system/backend
```

## INSTALL DEPENDENCIES
```bash
npm install
```

## SETUP ENVIRONMENT
rubah .env copy menjadi .env. kemudian edit sesuai kebutuhan

```env
# ==================================================
# KONFIGURASI ENVIROMENT UNTUK APLIKASI BACKEND
# ==================================================
APP_PORT=8000
APP_HOST=localhost


# ==================================================
# KONFIGURASI DATABASE
# ==================================================
DATABASE_URL="mysql://johndoe:randompassword@localhost:3306/mydb"
```

## MELAKUKAN MIGRATE DATABASE
```bash
npx prisma db push
```

## RUNNING BACKEND

```bash
npm run dev
```