#!/usr/bin/env bash
set -euo pipefail

# build
mkdir -p build
cd build
cmake ..
make

# input mẫu (64-bit)
INPUT="1
0000000100100011010001010110011110001001101010111100110111101111
0001001100110100010101110111100110011011101111001101111111110001"

# output mong đợi (DES chuẩn)
EXPECTED="1000010111101000000100110101010000001111000010101011010000000101"

# chạy chương trình
OUTPUT=$(echo -e "$INPUT" | ./des)

echo "Output:   $OUTPUT"
echo "Expected: $EXPECTED"

if [ "$OUTPUT" != "$EXPECTED" ]; then
    echo "❌ Test failed"
    exit 1
fi

echo "✅ Test passed"
