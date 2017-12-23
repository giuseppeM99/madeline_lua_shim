<?php
require "vendor/autoload.php";

$settings = ['app_info' => ['api_id' => 6, 'api_hash' => 'eb06d4abfb49dc3eeb1aeb98ae0f581e'], 'logger' => ['logger_level' => \danog\MadelineProto\Logger::ERROR], 'rollbar_token' => NULL];
$madeline = new \danog\MadelineProto\API($settings);

try {
    $authorization = $madeline->bot_login(readline("Enter the bot token here: "));
} catch (\danog\MadelineProto\RPCErrorException $e) {
    die($e->getMessage().PHP_EOL);
}

echo $authorization['_'] == "auth.authorization"? "LOGGED AS ".$authorization['user']['first_name']." (".$authorization['user']['username'].") [".$authorization['user']['id']."]\n" : "LOGIN ERROR, RETRY LATER\n";
$madeline->serialize('bot.madeline');
echo PHP_EOL;
