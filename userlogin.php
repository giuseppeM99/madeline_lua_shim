<?php
require "vendor/autoload.php";
$settings = ['app_info' => ['api_id' => 6, 'api_hash' => 'eb06d4abfb49dc3eeb1aeb98ae0f581e'], 'logger' => ['loglevel' => \danog\MadelineProto\Logger::ERROR]];
$madeline = new \danog\MadelineProto\API($settings);
$madeline->phone_login(readline('Enter your phone number: '));
$authorization = $madeline->complete_phone_login(readline('Enter the code you received: '));
if ($authorization['_'] === 'account.noPassword') {
    throw new \danog\MadelineProto\Exception('2FA is enabled but no password is set!');
}
if ($authorization['_'] === 'account.password') {
    $authorization = $madeline->complete_2fa_login(readline('Please enter your password (hint '.$authorization['hint'].'): '));
}
if ($authorization['_'] === 'account.needSignup') {
    $authorization = $madeline->complete_signup(readline('Please enter your first name: '), readline('Please enter your last name (can be empty): '));
}

echo var_dump($authorization).PHP_EOL;

\danog\MadelineProto\Serialization::serialize('bot.madeline', $madeline);

echo PHP_EOL;

 ?>
