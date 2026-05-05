#!/usr/bin/env bash
set -euo pipefail

# build
mkdir -p build
cd build
cmake ..
make

# plaintext (không chia hết 64 để test padding)
PLAINTEXT="0101010101110001110001110001110001110001110001110001110001110001111"

KEY="0001001100110100010101110111100110011011101111001101111111110001"

# encrypt

CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)

# decrypt
DECRYPTED=$(echo -e "2\n$CIPHERTEXT\n$KEY" | ./des)

echo "Plaintext:  $PLAINTEXT"
echo "Encrypted:  $CIPHERTEXT"
echo "Decrypted:  $DECRYPTED"

# check round-trip
if [ "$DECRYPTED" != "$PLAINTEXT" ]; then
    echo "❌ Round-trip FAILED"
    exit 1
fi

echo "✅ Round-trip PASSED"
