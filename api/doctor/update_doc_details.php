<?php
require("../doctor/auth/dbConfig.php");
require '../doctor/auth/dbFunctions.php';
try {
    $dbh = new PDO("mysql:host=$hostname;dbname=$database", $username, $password);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (\PDOException $err) {
    die("Couldn't connect to DB " . $err->getMessage());
}
session_start();
if (isset($_POST)) {
    $update = "UPDATE doc_data SET NAME = :name , SPECIALITY = :speciality , LOCATION = :loc , DESCRIPTION = :desc   WHERE EMAIL = :email;";
    $stmt =  $dbh->prepare($update);
    $stmt->bindParam(':name', $_POST['uname']);
    $stmt->bindParam(':speciality', $_POST['speciality']);
    $stmt->bindParam(':loc', $_POST['loc']);
    $stmt->bindParam(':desc', $_POST['desc']);
    $stmt->bindParam(':email', $_POST['email']);
    $status = $stmt->execute();
    if ($status) {
        $sql = "SELECT * FROM doctors WHERE EMAIL=:email ;";
        $stmt =  $dbh->prepare($sql);
        $stmt->bindParam(':email', $_POST['email']);
        $stmt->execute();
        $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $res = $stmt->fetchAll();
        $user_data = getUserData($dbh, $res[0]["UID"]);
        $_SESSION["user_data"] = $user_data;
        $_SESSION["user_data"]["IMG_URL"] = 'http://localhost/wp/bucket/images/' . $_SESSION["user_data"]["IMG_URL"];
        header('Location: ../../doc_end/home/static', true);
    } else {
        header('Location: ../../doc_end/error', true);
    }
    print_r($_POST);
}
