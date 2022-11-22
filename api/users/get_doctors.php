<?php 
include '../users/auth/dbConfig.php';

header("Access-Control-Allow-Origin: *");
try {
    $dbh = new PDO("mysql:host=$hostname;dbname=$database", $username, $password);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (\PDOException $err) {
    die("Couldn't connect to DB " . $err->getMessage());
}

$result = [];

if(isset($_GET)){
    $sql = "SELECT * FROM doc_data";
    $stmt =  $dbh->prepare($sql);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    $res = $stmt->fetchAll();
    $result = $res;
}
else{
    $result['message'] = "error";
}
echo json_encode($result);

?>