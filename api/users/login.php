<?php 
    header('Access-Control-Allow-Origin: *');
  //MySQL database Connection
  $con=mysqli_connect('localhost','root','','mydoc_db');
  
  //Received JSON into $json variable
  $json = file_get_contents('php://input');
  
  //Decoding the received JSON and store into $obj variable.
  $obj = json_decode($json,true);
  $result=[];
  if(isset($obj["email"]) && isset($obj["password"])){
    
    $email = mysqli_real_escape_string($con,$obj['email']);
    $pwd = mysqli_real_escape_string($con,$obj['password']);
    
    //Declare array variable
    
    //Select Query
    $sql="SELECT * FROM users WHERE EMAIL='{$email}' and UPASS='{$pwd}'";
    $res=$con->query($sql);
    
    if($res->num_rows>0){
      
      $row=$res->fetch_assoc();
      
      $result['loginStatus']=true;
      $result['message']="success";
      
      $result["userInfo"]=$row;
      
    }else{
      
      $result['loginStatus']=false;
      $result['message']="invalid";
    }
    
    // Converting the array into JSON format.
    $json_data=json_encode($result);
      
    // Echo the $json.
    echo $json_data;
  }
  else{
    $result['message']="error";
    echo json_encode($result);
  }
?>