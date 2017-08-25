<?php
require "vendor/autoload.php";

$settings = ['app_info' => ['api_id' => 6, 'api_hash' => 'eb06d4abfb49dc3eeb1aeb98ae0f581e'], 'logger' => ['logger_level' => \danog\MadelineProto\Logger::ERROR], 'rollbar_token' => '260ca5acd9c1443faef9f19c29f2a6e3'];
$madeline = new \danog\MadelineProto\API($settings);

try {
    $madeline->phone_login(readline('Enter your phone number: '));
} catch (danog\MadelineProto\RPCErrorException $e) {
    die ($e->getMessage().PHP_EOL);
}

try {
    $authorization = $madeline->complete_phone_login(readline('Enter the code you received: '));
} catch (danog\MadelineProto\RPCErrorException $e) {
    die ($e->getMessage().PHP_EOL);
}

if ($authorization['_'] === 'account.noPassword') {
    die('2FA is enabled but no password is set!');
}

if ($authorization['_'] === 'account.password') {
    try {
        $authorization = $madeline->complete_2fa_login(readline('Please enter your password (hint '.$authorization['hint'].'): '));
    } catch (danog\MadelineProto\RPCErrorException $e) {
        die ($e->getMessage().PHP_EOL);
    }
}

if ($authorization['_'] === 'account.needSignup') {
    $authorization = $madeline->complete_signup(readline('Please enter your first name: '), readline('Please enter your last name (can be empty): '));
}

echo $authorization['_'] == "auth.authorization"? "LOGGED AS ".$authorization['user']['first_name']
.(isset($authorization['user']['last_name']) ? " ".$authorization['user']['last_name'] : "")
.(isset($authorization['user']['username']) ? " (".$authorization['user']['username'].")" : "")
." [".$authorization['user']['id']."]\n" : "LOGIN ERROR, RETRY LATER\n";

$madeline->serialize('bot.madeline');
echo PHP_EOL;

 ?>
