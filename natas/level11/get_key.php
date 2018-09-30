<?php
function xor_encrypt($in, $key)
{
    $text = $in;
    $outText = '';

    for($i=0;$i<strlen($text);$i++) {
        $outText .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $outText;
}

$defaultdata = array("showpassword"=>"no", "bgcolor"=>"#ffffff");
$encrypted_data = "ClVLIh4ASCsCBE8lAxMacFMZV2hdVVotEhhUJQNVAmhSEV4sFxFeaAw=";
$tmp = json_encode($defaultdata);
$tmp2 = base64_decode($encrypted_data);
echo "The key is here: \n";
for ($i=0; $i<strlen($tmp); $i++)
{
    echo $tmp[$i] ^ $tmp2[$i];
}
echo "\n";

$key = "qw8J";
$mydata = array("showpassword"=>"yes", "bgcolor"=>"#ffffff");
$enc_test = base64_encode(xor_encrypt(json_encode($mydata), $key));
print "Use this cookie:\n";
print urlencode($enc_test)."\n";

$cookie = "ClVLIh4ASCsCBE8lAxMacFMOXTlTWxooFhRXJh4FGnBTVF4sFxFeLFMK";
$tempdata = json_decode(xor_encrypt(base64_decode($cookie), $key), true);
print_r($tempdata);
?>
