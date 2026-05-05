import sys

BLOCK_SIZE = 64

def zero_pad(s):
    if len(s) % BLOCK_SIZE != 0:
        s += '0' * (BLOCK_SIZE - len(s) % BLOCK_SIZE)
    return s

def split_blocks(s):
    return [s[i:i+BLOCK_SIZE] for i in range(0, len(s), BLOCK_SIZE)]

def normalize_key(key):
    if len(key) < 64:
        key = key.ljust(64, '0')
    elif len(key) > 64:
        key = key[:64]
    return key

def encrypt_block(block, key):
    result = ""
    for i in range(64):
        result += '1' if block[i] != key[i] else '0'
    return result

def main():
    data = sys.stdin.read().strip().split()
    if len(data) < 2:
        return

    plaintext = data[0]
    key = normalize_key(data[1])

    plaintext = zero_pad(plaintext)
    blocks = split_blocks(plaintext)

    result = ""
    for b in blocks:
        result += encrypt_block(b, key)

    print(result, end="")

if __name__ == "__main__":
    main()
