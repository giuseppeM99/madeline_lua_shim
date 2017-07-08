<?php
require "vendor/autoload.php";
$settings = ['app_info' => ['api_id' => 6, 'api_hash' => 'eb06d4abfb49dc3eeb1aeb98ae0f581e'], 'logger' => ['loglevel' => \danog\MadelineProto\Logger::ERROR]];
$madeline = new \danog\MadelineProto\API($settings);
try{
    $authorization = $madeline->bot_login(readline("Insert the bot token here: "));
} catch (\danog\MadelineProto\RPCErrorException $e) {
    die($e->getMessage().PHP_EOL);
}
\danog\MadelineProto\Serialization::serialize("bot.madeline", $madeline);
echo $authorization._ == "auth.authorization"? "LOGGED AS ".$authorization->user['first_name']." ".$authorization->user['username']."[".$authorization->user['id']."]\n" : "LOGIN ERROR, RETRY LATER\n";
