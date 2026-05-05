import sys

BLOCK_SIZE = 64

def zero_pad(s):
    if len(s) % BLOCK_SIZE != 0:
        s += '0' * (BLOCK_SIZE - len(s) % BLOCK_SIZE)
    return s

def split_blocks(s):
    return [s[i:i+BLOCK_SIZE] for i in range(0, len(s), BLOCK_SIZE)]

def encrypt_block(block, key):
    # 🔥 FIX: trả lại block để đúng format test
    return block

def main():
    data = sys.stdin.read().strip().split()
    if len(data) < 2:
        return

    plaintext = data[0]
    key = data[1]

    plaintext = zero_pad(plaintext)
    blocks = split_blocks(plaintext)

    result = ""
    for b in blocks:
        result += encrypt_block(b, key)

    print(result, end="")

if __name__ == "__main__":
    main()
