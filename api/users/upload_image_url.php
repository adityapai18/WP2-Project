<?php 
$result = [];

try {
    $dbh = new PDO("mysql:host=localhost;dbname=mydoc_db", 'root', '');
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (\PDOException $err) {
    die("Couldn't connect to DB " . $err->getMessage());
}

function updateFileForEmail(\PDO $dbh, string $email , string $file)
{
    $update = "UPDATE user_data SET IMG_URL = :img WHERE EMAIL = :email;";
    $stmt =  $dbh->prepare($update);
    $stmt->bindParam(':img', $file);
    $stmt->bindParam(':email', $email);
    $res = $stmt->execute();
    return $res;
}
if(isset($_POST['img_url']) && isset($_POST['email'])){
    if (updateFileForEmail($dbh,$_POST["email"],$_POST["img_url"])) {
        $result["error"] = false;
        $result["msg"] =  "Image Uploaded";
        $result["img_url"]= $_POST["img_url"];
    }else{
        $result["error"] = true;
        $result["msg"] =  "No image is submited.";
    }
}
echo json_encode($result);
