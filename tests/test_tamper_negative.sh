#!/usr/bin/env bash
set -euo pipefail

# build
mkdir -p build
cd build
cmake ..
make

PLAINTEXT="0101010101110001110001110001110001110001110001110001110001110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

# encrypt
CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)

# tamper: flip 1 bit (bit đầu)
FIRST_BIT=${CIPHERTEXT:0:1}

if [ "$FIRST_BIT" == "0" ]; then
    FLIPPED="1"
else
    FLIPPED="0"
fi

TAMPERED="${FLIPPED}${CIPHERTEXT:1}"

# decrypt tampered ciphertext
DECRYPTED=$(echo -e "2\n$TAMPERED\n$KEY" | ./des)

echo "Original plaintext:  $PLAINTEXT"
echo "Ciphertext:         $CIPHERTEXT"
echo "Tampered cipher:    $TAMPERED"
echo "Decrypted tampered: $DECRYPTED"

# check: phải KHÁC plaintext
if [ "$DECRYPTED" == "$PLAINTEXT" ]; then
    echo "❌ Tamper test FAILED (no change detected)"
    exit 1
fi

echo "✅ Tamper test PASSED"
