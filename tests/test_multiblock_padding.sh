#!/usr/bin/env bash
set -euo pipefail

# build
mkdir -p build
cd build
cmake ..
make

# plaintext dài > 64 bit (không chia hết 64)
PLAINTEXT="010101010111000111000111000111000111000111000111000111000111000111100001111"

KEY="0001001100110100010101110111100110011011101111001101111111110001"

# encrypt
CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)

# decrypt
DECRYPTED=$(echo -e "2\n$CIPHERTEXT\n$KEY" | ./des)

echo "Plaintext:  $PLAINTEXT"
echo "Encrypted:  $CIPHERTEXT"
echo "Decrypted:  $DECRYPTED"

# do zero padding manually để so sánh
PADDED="$PLAINTEXT"
while [ $((${#PADDED} % 64)) -ne 0 ]; do
    PADDED="${PADDED}0"
done

# check
if [ "$DECRYPTED" != "$PADDED" ]; then
    echo "❌ Multi-block padding FAILED"
    exit 1
fi

echo "✅ Multi-block padding PASSED"
