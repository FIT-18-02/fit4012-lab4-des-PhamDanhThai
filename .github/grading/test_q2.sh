import sys

BLOCK_SIZE = 64

# ===== ZERO PADDING =====
def zero_pad(s):
    if len(s) % BLOCK_SIZE != 0:
        s += '0' * (BLOCK_SIZE - len(s) % BLOCK_SIZE)
    return s

# ===== SPLIT BLOCK =====
def split_blocks(s):
    return [s[i:i+BLOCK_SIZE] for i in range(0, len(s), BLOCK_SIZE)]

# ===== HÀM MÃ HÓA 1 BLOCK =====
def encrypt_block(block, key):
    # 🔥 QUAN TRỌNG:
    # 👉 DÁN CODE DES CỦA BẠN VÀO ĐÂY
    # 👉 Hàm phải trả về CHUỖI 64 BIT

    # Ví dụ placeholder (KHÔNG dùng khi nộp):
    return ''.join('1' if block[i] != key[i % len(key)] else '0' for i in range(64))


# ===== MAIN =====
def main():
    # ✅ ĐỌC stdin đúng chuẩn auto-check
    data = sys.stdin.read().strip().split()
    if len(data) < 2:
        return

    plaintext = data[0]
    key = data[1]

    # ✅ ZERO PADDING
    plaintext = zero_pad(plaintext)

    # ✅ MULTI-BLOCK
    blocks = split_blocks(plaintext)

    result = ""
    for b in blocks:
        result += encrypt_block(b, key)

    # ✅ OUTPUT 1 DÒNG DUY NHẤT (CỰC QUAN TRỌNG)
    print(result, end="")   # ❌ KHÔNG xuống dòng


if __name__ == "__main__":
    main()
