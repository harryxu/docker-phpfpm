<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$host = 'mysqlsrv';
$db   = 'playground';
$user = 'root';
$pass = '111111';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];
try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     throw new \PDOException($e->getMessage(), (int)$e->getCode());
}

$pdo->prepare("CREATE DATABASE IF NOT EXISTS $db")->execute();
$pdo->prepare("use $db")->execute();
$pdo->prepare("CREATE TABLE IF NOT EXISTS `users` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(30) COLLATE utf8mb4_unicode_ci,
    `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")->execute();
$smt = $pdo->prepare("SELECT * FROM users");
$smt->execute();
$users = $smt->fetchAll();
if (empty($users)) {
    $pdo->prepare("INSERT INTO users (name, email) VALUES ('harry', 'harry@example.com')")->execute();
    $smt->execute();
    $users = $smt->fetchAll();
}

echo 'MySQL data: <pre>';
print_r($users);
echo '</pre>';

phpinfo();
