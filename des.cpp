#include <bits/stdc++.h>
using namespace std;

// ===== BASIC =====
string xor_strings(string a, string b) {
    string res = "";
    for (int i = 0; i < a.size(); i++)
        res += (a[i] == b[i] ? '0' : '1');
    return res;
}

// ===== TABLE =====
int IP[64] = {58,50,42,34,26,18,10,2,60,52,44,36,28,20,12,4,
62,54,46,38,30,22,14,6,64,56,48,40,32,24,16,8,
57,49,41,33,25,17,9,1,59,51,43,35,27,19,11,3,
61,53,45,37,29,21,13,5,63,55,47,39,31,23,15,7};

int FP[64] = {40,8,48,16,56,24,64,32,39,7,47,15,55,23,63,31,
38,6,46,14,54,22,62,30,37,5,45,13,53,21,61,29,
36,4,44,12,52,20,60,28,35,3,43,11,51,19,59,27,
34,2,42,10,50,18,58,26,33,1,41,9,49,17,57,25};

int E[48] = {32,1,2,3,4,5,4,5,6,7,8,9,
8,9,10,11,12,13,12,13,14,15,16,17,
16,17,18,19,20,21,20,21,22,23,24,25,
24,25,26,27,28,29,28,29,30,31,32,1};

int P[32] = {16,7,20,21,29,12,28,17,
1,15,23,26,5,18,31,10,
2,8,24,14,32,27,3,9,
19,13,30,6,22,11,4,25};

int PC1[56] = {57,49,41,33,25,17,9,
1,58,50,42,34,26,18,
10,2,59,51,43,35,27,
19,11,3,60,52,44,36,
63,55,47,39,31,23,15,
7,62,54,46,38,30,22,
14,6,61,53,45,37,29,
21,13,5,28,20,12,4};

int PC2[48] = {14,17,11,24,1,5,3,28,
15,6,21,10,23,19,12,4,
26,8,16,7,27,20,13,2,
41,52,31,37,47,55,30,40,
51,45,33,48,44,49,39,56,
34,53,46,42,50,36,29,32};

int shift_table[16] = {1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1};

// ===== SBOX (đã đủ) =====
int S[8][4][16] = { /* giữ nguyên như bạn đã có */ };

// ===== CORE =====
string permute(string in, int* table, int n) {
    string out = "";
    for (int i = 0; i < n; i++) out += in[table[i]-1];
    return out;
}

string shift_left(string k, int shifts) {
    rotate(k.begin(), k.begin()+shifts, k.end());
    return k;
}

vector<string> generate_keys(string key) {
    vector<string> round_keys;
    key = permute(key, PC1, 56);

    string L = key.substr(0,28), R = key.substr(28,28);

    for (int i = 0; i < 16; i++) {
        L = shift_left(L, shift_table[i]);
        R = shift_left(R, shift_table[i]);
        round_keys.push_back(permute(L+R, PC2, 48));
    }
    return round_keys;
}

string sbox_sub(string input) {
    string output = "";
    for (int i = 0; i < 8; i++) {
        string block = input.substr(i*6,6);
        int row = (block[0]-'0')*2 + (block[5]-'0');
        int col = stoi(block.substr(1,4), nullptr, 2);
        output += bitset<4>(S[i][row][col]).to_string();
    }
    return output;
}

string f(string R, string K) {
    return permute(sbox_sub(xor_strings(permute(R,E,48),K)),P,32);
}

string des_encrypt(string block, vector<string> keys) {
    block = permute(block, IP, 64);
    string L = block.substr(0,32), R = block.substr(32,32);

    for (int i = 0; i < 16; i++) {
        string tmp = R;
        R = xor_strings(L, f(R, keys[i]));
        L = tmp;
    }
    return permute(R+L, FP, 64);
}

string des_decrypt(string block, vector<string> keys) {
    reverse(keys.begin(), keys.end());
    return des_encrypt(block, keys);
}

// ===== PADDING =====
string pad(string s) {
    while (s.size() % 64 != 0) s += '0';
    return s;
}

// ===== MAIN =====
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int mode;
    cin >> mode;

    string data;
    cin >> data;

    data = pad(data);

    string result = "";

    if (mode == 1) {
        string k;
        cin >> k;
        auto keys = generate_keys(k);

        for (int i = 0; i < data.size(); i += 64)
            result += des_encrypt(data.substr(i,64), keys);
    }
    else if (mode == 2) {
        string k;
        cin >> k;
        auto keys = generate_keys(k);

        for (int i = 0; i < data.size(); i += 64)
            result += des_decrypt(data.substr(i,64), keys);
    }
    else if (mode == 3) {
        string k1,k2,k3;
        cin >> k1 >> k2 >> k3;

        auto k_1 = generate_keys(k1);
        auto k_2 = generate_keys(k2);
        auto k_3 = generate_keys(k3);

        for (int i = 0; i < data.size(); i += 64) {
            string b = data.substr(i,64);
            b = des_encrypt(b, k_1);
            b = des_decrypt(b, k_2);
            b = des_encrypt(b, k_3);
            result += b;
        }
    }

    cout << result;
}
