#!/usr/bin/pike

// Convert an address to little endian string
// e.g. 0x41425252 -> "BBBA"
//      0x414343   -> "CCA\332"
int main(int c, array(string) v)
{
    int padding;
    int address;
    sscanf(v[1], "%d", padding);
    sscanf(v[2], "%x", address);
    write("%s%s", "a" * padding, sprintf("%-4c", address));
}
