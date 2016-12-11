#!/usr/bin/env php
<?php
/*

// single file
php --file update_json.php -- -f eval-win81x64-enterprise.json

// *.json
ls -1 *.json | xargs -n1 -I% php --file update_json.php -- -f %
git diff --ignore-all-space --ignore-blank-lines >out
git co -- .
git apply out
rm out

*/

$shortopts = "";
$shortopts .= "f:";  // Required value

$options = getopt($shortopts);

$jfile = $options["f"];
$data = json_decode(file_get_contents($jfile), true);
for ($i = 0; $i < count($data['builders']); $i++) {
    if ($data['builders'][$i]['type'] == 'virtualbox-iso') {
        $data['builders'][$i]['post_shutdown_delay'] = "1m";
        $data['builders'][$i]['shutdown_timeout'] = "1h";
    }
}
file_put_contents($jfile, json_encode($data));
file_put_contents($jfile, shell_exec("jq . $jfile"));
