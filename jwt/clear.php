<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
session_start();
require_once('vendor/autoload.php');


if(isset($_GET['clear']) && $_GET['clear'] == "yes")
{
      // Connection to database.

      $db = mysqli_connect('localhost', 'root', '', 'jtest');


      mysqli_query($db, "UPDATE users SET token='', token_expires=''");
      mysqli_query($db, "DELETE FROM refresh_token");

      session_unset();

      header('location: /jwt/');
      return;
}