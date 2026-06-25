#!/bin/bash

# Daftar 23 energi untuk simulasi Pristine (tanpa bobot, konstan 100.000 partikel)
energi_list=(
    150.00 149.27 148.72 148.17 147.63 147.08 146.53 145.97
    145.42 144.86 144.31 143.75 143.19 142.62 142.06 141.49
    140.92 140.35 139.78 139.21 138.64 138.06 137.48 136.90
)

# Nama file template TOPAS
TEMPLATE="PRISTINE_TEMPLATE.txt"

echo "================================================="
echo " Memulai Otomatisasi 23 Simulasi Pristine TOPAS..."
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
echo " SELESAI! 23 file CSV siap diolah."
echo "================================================="
