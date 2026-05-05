import sys


BLOCK_SIZE = 64

def zero_pad(s):
    if len(s) % BLOCK_SIZE != 0:
        s += '0' * (BLOCK_SIZE - len(s) % BLOCK_SIZE)
    return s

def split_blocks(s):
    return [s[i:i+BLOCK_SIZE] for i in range(0, len(s), BLOCK_SIZE)]

def encrypt_block(block, key):
    result = ""
    for i in range(64):
        result += '1' if block[i] != key[i % len(key)] else '0'

    if len(result) != 64:
        result = result[:64].ljust(64, '0')

    return result

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
        cipher = encrypt_block(b, key)

        if len(cipher) != 64:
            cipher = cipher[:64].ljust(64, '0')

        result += cipher

    print(result, end="")

if __name__ == "__main__":
    main()
