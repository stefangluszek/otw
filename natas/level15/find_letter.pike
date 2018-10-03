final constant alphabet = "abcdefghijklmnoprstuwxyz";
final constant needle = "1";

bool check(string haystack)
{
    if (search(haystack, needle) < 0)
        return false;
    return true;
}

string find_letter(string haystack)
{
    if (sizeof(haystack) == 1 && check(haystack))
        return haystack;

    if (!check(haystack))
        return 0;

    int m = sizeof(haystack) / 2;
    return find_letter(haystack[..m - 1]) || find_letter(haystack[m..]);
}

int main()
{
    werror("%O\n", find_letter(alphabet));
    return 0;
}
