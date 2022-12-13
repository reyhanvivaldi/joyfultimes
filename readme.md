# Kelompok B05 - JoyfulTimes 🏥
You don't have to struggle in silence, don't carry everything alone ❤️

[![Build status](https://build.appcenter.ms/v0.1/apps/2b4a93b8-db52-4a27-a7bc-5c641a0a9703/branches/main/badge)](https://appcenter.ms)
[Link APK](https://install.appcenter.ms/orgs/joyfultimes/apps/joyfultimes/distribution_groups/public)

## 📱 Aplikasi



## 🔗 Alur Pengintegrasian
Integrasi dilakukan dengan mengimplementasikan API endpoint pada backend Django dari [web](https://github.com/reyhanvivaldi/pbp-group) yang sudah dibuat sebelumnya dengan menggunakan JsonResponse. Selanjutnya, mengimplementasikan desain frontend mobile yang menyesuaikan desain [web](https://github.com/reyhanvivaldi/pbp-group), serta melakukan integrasi frontend-backend dengan menggunakan konsep asynchronous HTTP.


## 👨‍💻 Anggota Kelompok:
1. Reyhan Vivaldi Adrian - 2106750811
2. Naznien Fevrianne Malano - 2106751404
3. Prita Elisabeth Laura Tarigan - 2106751190
4. Alia Widyanita Puspaningrum - 2106751625
5. Muhammad Alif Ismady - 2106654492


## 📖 Cerita Aplikasi
Berdasarkan data dari WHO, sejak terjadinya pandemi COVID-19, tingkat kecemasan dan depresi meningkat hingga 25%. Di Indonesia saja, per tahun 2021 silam, diperkirakan setidaknya 1 dari 5 orang menderita atau berpotensi mengalami gangguan mental. Sayangnya, di Indonesia isu kesehatan mental ini sendiri masih dianggap sebagai topik yang tabu, padahal kesehatan mental sama pentingnya dengan kesehatan fisik. Hal ini menyebabkan penderita takut dan malu untuk mengakui kondisinya dan berujung pada isu yang lebih kompleks lagi. JoyfulTimes adalah aplikasi yang bertujuan untuk meruntuhkan dinding ke-tabuan topik kesehatan mental demi menciptakan Indonesia yang lebih bahagia. Melalui aplikasi ini, kami ingin memberikan tempat bagi para penderita dan orang-orang di sekitar untuk saling berbagi cerita, berbagi kebahagiaan, dan menyemangati satu dengan yang lainnya. Melalui JoyfulTimes, kami ingin membuat wadah yang aman dan nyaman bagi semua orang untuk belajar dan meningkatkan kualitas diri.


## 📝 Daftar Modul dan Fitur
### Mood Tracker -- Prita
Fitur ini hanya dapat diakses oleh user yang sudah login.
- User dapat membuat _record_ baru mengenai _mood_ mereka pada hari itu.
- Record tersebut berisi tipe _mood_, deskripsi, _mood rate_, _start time_, dan _end time_.

### Mental Health Assessment -- Alia
Fitur ini hanya dapat diakses oleh user yang sudah login.
- User dapat mengerjakan _assessment_ mengenai _mental health_, seperti _Depression Assessment_, _Anxiety Assessment_, dan _Stress Assessment_.
- Jika sudah pernah mengerjakan _assessment_, hasil terakhir dari _assessment_ tersebut akan di tampilkan terlebih dahulu.

### Diary -- Reyhan
Pengguna bisa membuat diary hariannya yang berisi segala cerita melalui fitur ini.
- Hanya dapat diakses oleh user yang sudah login.
- User dapat membuat entri baru dalam diary.

### Forum -- Naznien
Fitur ini dapat diakses oleh user yang belum dan sudah login.
- User yang belum login hanya dapat melihat post yang sudah dibuat user-user yang sudah login.
- User yang sudah login dapat membuat forum baru dan juga dapat reply forum yang ada.

### Notes -- Alif
Fitur ini dapat diakses oleh user yang belum dan sudah login.
- User yang belum login hanya dapat melihat notes yang sudah dibuat user-user yang sudah login.
- User yang sudah login dapat membuat notes baru.


## 👨‍👩‍👧‍👦 Peran
### User Yang Tidak Login
- Melihat Homepage
- Melihat Forum
- Melihat Notes

### User Yang Sudah Login
- Mengakses semua modul dari user yang tidak login
- Mengakses Mood Tracker
- Mengakses Mental Health Assessment
- Mengakses Diary
- Membuat Forum
- Membuat Notes
