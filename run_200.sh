#!/bin/bash

# Daftar 16 energi untuk simulasi Pristine (tanpa bobot, konstan 100.000 partikel)
energi_list=(
    199.71 199.06 198.40 197.75 197.09 196.43 195.77 195.11
    194.44 193.77 193.11 192.44 191.76 191.09 190.41 189.74
)

# Nama file template TOPAS
TEMPLATE="PRISTINE_TEMPLATE.txt"

echo "================================================="
echo " Memulai Otomatisasi 16 Simulasi Pristine TOPAS..."
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
echo " SELESAI! 16 file CSV siap diolah."
echo "================================================="
