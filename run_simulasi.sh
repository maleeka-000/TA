#!/bin/bash

# Daftar 24 energi untuk simulasi Pristine (tanpa bobot, konstan 100.000 partikel)
energi_list=(120.00 119.14 118.49 117.84 117.18 116.53 115.87 115.20 114.54 113.87 113.20 112.52 111.85 111.17 110.48 109.79 109.10 108.41 107.71 107.01 106.30 105.60 104.88 104.17)

# Nama file template TOPAS
TEMPLATE="PRISTINE_TEMPLATE.txt"

echo "================================================="
echo " Memulai Otomatisasi 24 Simulasi Pristine TOPAS..."
echo "================================================="

for E in "${energi_list[@]}"
do
    echo "[>>] Menjalankan simulasi untuk Energi: $E MeV"

    # Mengganti ENERGIPLACEHOLDER dengan nilai $E
    sed "s/ENERGIPLACEHOLDER/$E/g" $TEMPLATE > pristine_temp.txt

    # Menjalankan TOPAS (pastikan path ini sesuai dengan instalasi TOPAS-mu)
    ~/topas/bin/topas pristine_temp.txt > /dev/null 2>&1

    # Mengamankan file hasil (DoseAtPhantom.csv) dengan nama baru
    if [ -f "DosePhantom.csv" ]; then
        mv DosePhantom.csv "Pristine_${E}MeV.csv"
        echo "[OK] Hasil disimpan: Pristine_${E}MeV.csv"
    else
        echo "[ERROR] File CSV tidak ditemukan untuk energi $E MeV."
    fi
    echo "-------------------------------------------------"
done

# Bersih-bersih file sementara
rm pristine_temp.txt

echo "================================================="
echo " SELESAI! 24 file CSV siap diolah."
echo "================================================="
