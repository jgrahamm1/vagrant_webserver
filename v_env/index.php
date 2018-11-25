<?php
$old_path = getcwd();
chdir('/home/www-data/admin');
#shell_exec("/usr/bin/git pull https://git:admin@192.168.50.4/home/git/project-1.git master");
shell_exec("git pull");
$files = scandir('/home/www-data/admin');
foreach($files as $file) {
        shell_exec("chmod +x ./$file");
        $output .= shell_exec("./$file");
}
chdir($old_path);
echo nl2br($output)
?>
