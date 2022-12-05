<?php

use PHPMailer\PHPMailer\PHPMailer;

function sendMailToPatient(\PDO $dbh,$doc_id, $user_id, $booking_date, $book_time)
{
	require 'pass.php';
	require 'phpmailer/src/Exception.php';
	require 'phpmailer/src/PHPMailer.php';
	require 'phpmailer/src/SMTP.php';
	$mail = new PHPMailer(true);

	$mail->isSMTP();
	$mail->Host = 'smtp.gmail.com';
	$mail->SMTPAuth = true;
	$mail->Username = 'aditya.pai@somaiya.edu';
	$mail->Password = $password;
	$mail->SMTPSecure = 'ssl';
	$mail->Port = 465;
	$user_mail  = getUserEmail($dbh,$user_id);
	$mail->setFrom('aditya.pai@somaiya.edu');

	$mail->addAddress($user_mail);

	$mail->isHTML(true);

	$mail->Subject = 'MyDoctor Appointment';
	$mail->Body = "Your appoint with Dr." . getDocName($dbh , $doc_id) . ' has been scheduled on ' . $booking_date . " " . getTime($book_time);
	return $mail->send();
}
function getTime($time)
{
	if ($time > 12) {
		return ($time - 12) . "PM";
	} else return $time . "AM";
}
function getUserEmail(\PDO $dbh,$uid)
{
	$sql = "SELECT * FROM user_data WHERE UID=:id;";
	$stmt =  $dbh->prepare($sql);
	$stmt->bindParam(':id', $uid);
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$res = $stmt->fetch();
	return $res['EMAIL'];
}
function getDocName(\PDO $dbh,$uid)
{
	$sql = "SELECT * FROM doc_data WHERE UID=:id;";
	$stmt =  $dbh->prepare($sql);
	$stmt->bindParam(':id', $uid);
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$res = $stmt->fetch();
	return $res['NAME'];
}
