<?php

header('Access-Control-Allow-Origin: *');
$con = mysqli_connect('localhost', 'root', '', 'mydoc_db');

//Received JSON into $json variable
$json = file_get_contents('php://input');

//Decoding the received JSON and store into $obj variable.
$obj = json_decode($json, true);
$res=[];
if (!$con) {
    $res['message']="error";
    echo json_encode($res);
}
if (isset($obj["email"]) && isset($obj["password"]) && isset($obj["name"])) {

    $email = mysqli_real_escape_string($con, $obj['email']);
    $pwd = mysqli_real_escape_string($con, $obj['password']);
    $name = mysqli_real_escape_string($con, $obj['name']);
    $sql = "SELECT * FROM users WHERE EMAIL = '" . $email . "'";

    $result = mysqli_query($con, $sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        $res['message']="error";
    } else {
        $insert = "INSERT INTO users(EMAIL,UPASS,NAME)VALUES('" . $email . "','" . $pwd . "','" . $name . "')";
        $query = mysqli_query($con, $insert);
        if ($query) {
            $res['message']="success";
        }
        else{
            $res['message']="error";
        }
    }
    echo json_encode($res); 
}
else{
    $res['message']="error";
    echo json_encode($res);
}
