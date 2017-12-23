#!/usr/bin/env php
<?php
/*
Copyright 2016-2017 Daniil Gentili (https://daniil.it)
Copyright 2017-2018 Giuseppe Marino
This file is part of Madeline Lua TG
Madeline Lua TG is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
See LICENSE
*/

//See https://github.com/danog/MadelineProto/blob/master/lua/madeline.php
require 'vendor/autoload.php';
$Lua = false;

try {
    $Lua = new \danog\MadelineProto\Lua('start.lua', new \danog\MadelineProto\API('bot.madeline'));
} catch (\danog\MadelineProto\Exception $e) {
    die($e->getMessage().PHP_EOL);
}

if (!file_exists('download')) {
    mkdir('download');
}

$Lua->madeline_update_callback(['_' => 'init']);
$offset = 0;
while (true) {
    $updates = $Lua->MadelineProto->API->get_updates(['offset' => $offset, 'limit' => 50, 'timeout' => 0]);
    foreach ($updates as $update) {
        $offset = $update['update_id'] + 1;
        $Lua->madeline_update_callback($update['update']);
        echo PHP_EOL;
    }

    $Lua->doCrons();
    if (time()-60 >= $Lua->MadelineProto->serialized) {
        $Lua->MadelineProto->serialize();
    }
}
