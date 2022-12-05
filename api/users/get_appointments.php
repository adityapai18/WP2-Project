<?php
$result = [];

try {
    $dbh = new PDO("mysql:host=localhost;dbname=mydoc_db", 'root', '');
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (\PDOException $err) {
    die("Couldn't connect to DB " . $err->getMessage());
}
function dateCheck($var)
{
    $date = new DateTime($var['apt_date']);
    $now = new DateTime();
    if ($date < $now) {
        return;
    }
    return $var;
}
function checking($var)
{
    return $var;
}
function isFuture($date)
{
    $current = strtotime(date("Y-m-d"));
    $date    = strtotime($date);
    $datediff = $date - $current;
    $difference = floor($datediff / (60 * 60 * 24));
    if ($difference > 1) {
        return true;
    }
    return false;
}
function getDocData(\PDO $dbh, string $id)
{
    $sql = "SELECT * FROM doc_data WHERE UID=:id;";
    $stmt =  $dbh->prepare($sql);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    $res = $stmt->fetch();
    return $res;
}

function getBookingArray(\PDO $dbh, string $id)
{
    $sql = "SELECT * FROM booking WHERE user_id=:id;";
    $stmt =  $dbh->prepare($sql);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    $res = $stmt->fetchAll();
    $arr = array_filter($res);
    foreach ($arr as $key => $value) {
        $arr[$key]['doc_data'] = getDocData($dbh, $value['doc_id']);
        unset($arr[$key]['doc_data']['BOOKING']);
    }
    usort(
        $arr,
        function ($a, $b) {
            return strtotime($a['apt_date']) - strtotime($b['apt_date']);
        }
    );
    return array_reverse($arr);
}

function getAllBooking(\PDO $dbh, string $id)
{
    $sql = "SELECT * FROM booking WHERE user_id=:id;";
    $stmt =  $dbh->prepare($sql);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    $res = $stmt->fetchAll();
    $arr = array_filter($res, function ($var) {
        return $var;
    });
    foreach ($res as $key => $value) {
        $arr[$key]['doc_data'] = getDocData($dbh, $value['doc_id']);
        unset($arr[$key]['doc_data']['BOOKING']);
    }
    usort(
        $arr,
        function ($a, $b) {
            return strtotime($a['apt_date']) - strtotime($b['apt_date']);
        }
    );
    return array_reverse($arr);
}

if (isset($_GET['user_id'])) {
    $result = getBookingArray($dbh, $_GET['user_id']);
    if (isset($_GET['latest']) && $_GET['latest'] && count($result) > 0)
        $result = $result[0];
    else if (isset($_GET['all'])) {
        $newArr = [];
        $newArr['upcoming'] = [];
        $newArr['past'] = [];
        $result = getAllBooking($dbh, $_GET['user_id']);
        foreach ($result as $key => $value) {
            if (isFuture($value['apt_date'])) {
                array_push($newArr['upcoming'], $value);
            } else {
                array_push($newArr['past'], $value);
            }
        }
        $result = $newArr;
    }
}

echo json_encode($result);
