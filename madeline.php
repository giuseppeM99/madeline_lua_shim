#!/usr/bin/env php
<?php
/*
Copyright 2016-2017 Daniil Gentili
(https://daniil.it)
This file is part of MadelineProto.
MadelineProto is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
MadelineProto is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.
You should have received a copy of the GNU General Public License along with MadelineProto.
If not, see <http://www.gnu.org/licenses/>.
*/
//See https://github.com/danog/MadelineProto/blob/master/lua/madeline.php
require 'vendor/autoload.php';
$settings = ['app_info' => ['api_id' => 6, 'api_hash' => 'eb06d4abfb49dc3eeb1aeb98ae0f581e']];
$Lua = false;
try {
    $Lua = \danog\MadelineProto\Serialization::deserialize('bot.madeline');
} catch (\danog\MadelineProto\Exception $e) {
}
    if (file_exists('token.php') && !is_object($Lua)) {
        include_once 'token.php';
        $MadelineProto = new \danog\MadelineProto\API($settings);
        $authorization = $MadelineProto->bot_login($token);
        \danog\MadelineProto\Logger::log([$authorization], \danog\MadelineProto\Logger::NOTICE);
        $Lua = new \danog\MadelineProto\Lua('start.lua', $MadelineProto);
    }

$Lua->MadelineProto->lua = true;
foreach ($Lua->MadelineProto->get_methods_namespaced() as $method => $namespace) {
    $Lua->MadelineProto->{$namespace}->lua = true;
}

$offset = 0;
while (true) {
    $updates = $Lua->MadelineProto->API->get_updates(['offset' => $offset, 'limit' => 50, 'timeout' => 0]); // Just like in the bot API, you can specify an offset, a limit and a timeout
    foreach ($updates as $update) {
        $offset = $update['update_id'] + 1; // Just like in the bot API, the offset must be set to the last update_id
        $Lua->madeline_update_callback($update['update']);
        echo PHP_EOL;
    }
    \danog\MadelineProto\Serialization::serialize('bot.madeline', $Lua);
}
