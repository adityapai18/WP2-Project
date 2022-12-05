<?php
try {
    $dbh = new PDO("mysql:host=localhost;dbname=mydoc_db", 'root', '');
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (\PDOException $err) {
    die("Couldn't connect to DB " . $err->getMessage());
}
if (isset($_GET['user_id'])) {
    $uid = $_GET['user_id'];
    $sql = "SELECT isPrivate FROM user_data WHERE UID=$uid;";
    $stmt =  $dbh->prepare($sql);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    $res = $stmt->fetch();
    if ($res['isPrivate']) {
        $update = "UPDATE user_data SET isPrivate = 0 WHERE UID = $uid;";
        $stmt =  $dbh->prepare($update);
        $stmt->execute();
    }
    else{
        $update = "UPDATE user_data SET isPrivate = 1 WHERE UID = $uid;";
        $stmt =  $dbh->prepare($update);
        $stmt->execute();
    }
    echo json_encode(['updated'=>true]);
}
