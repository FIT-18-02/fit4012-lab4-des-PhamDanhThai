#!/usr/bin/env bash
set -euo pipefail

# build
mkdir -p build
cd build
cmake ..
make

PLAINTEXT="0101010101110001110001110001110001110001110001110001110001110001"

KEY_CORRECT="0001001100110100010101110111100110011011101111001101111111110001"
KEY_WRONG="1111000011110000111100001111000011110000111100001111000011110000"

# encrypt với key đúng
CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY_CORRECT" | ./des)


# decrypt với key sai
DECRYPTED=$(echo -e "2\n$CIPHERTEXT\n$KEY_WRONG" | ./des)

echo "Plaintext:   $PLAINTEXT"
echo "Ciphertext:  $CIPHERTEXT"
echo "Wrong key:   $KEY_WRONG"
echo "Decrypted:   $DECRYPTED"

# check: KHÔNG được khôi phục đúng
if [ "$DECRYPTED" == "$PLAINTEXT" ]; then
    echo "❌ Wrong-key test FAILED"
    exit 1
fi

echo "✅ Wrong-key test PASSED"
