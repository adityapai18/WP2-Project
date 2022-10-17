<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
    session_start();

    use Firebase\JWT\JWT;
    use Firebase\JWT\Key;
    require_once('./vendor/autoload.php');
    if(isset($_POST['submit']))
    {
        if($_POST['login'] == "" || $_POST['password'] == "")
        {
            $_SESSION['MESSAGE'] = "Login and password required";
            header('location: /jwt/');
            return;
        }
        
        $_SESSION['MESSAGE'] = '';
        $now = new \DateTime('now', new \DateTimeZone('Asia/Kolkata'));

        $user = $_POST['login'];
        $password = $_POST['password'];
        
        // Connection to database.

        $db = mysqli_connect('localhost', 'root', '', 'jtest');

        
        // Getting user details from database.

        $sql = mysqli_query($db, "SELECT * FROM users WHERE `name` LIKE '%$user%'");

        // Check if user exists.
        
        if(mysqli_num_rows($sql))
        {
            // Hide it in .env and never push to github-repo.

            $secretKey  = '678y76y&*^Y&*^H*&uihYIUYHi^*&^&H^&*HVk7mLQyzqaS34Q4oR1ew='; 

            $serverName = 'localhost';

            $issedRefresh = new \DateTime('now +10 minutes', new \DateTimeZone('Asia/Kolkata'));

            $expireRefresh = $issedRefresh->format("d-m-Y h:i:s");

            $expire = $now->modify('+5 minutes')->format("d-m-Y h:i:s"); 

            $data = [
                'iat' => $now->format("d-m-Y h:i:s"), // Issued At
                'iss' => $serverName, // Issuer
                'exp' => $expire,
                'userName' => $user,
                'password' => $password,
            ];

            while($row = mysqli_fetch_assoc($sql))
            {
                $userId = $row['id'];

                if((int) $row['token_expires'] == 0)
                {
                    // Generating access token.

                    $accessToken = JWT::encode($data, $secretKey, 'HS512');

                    // Generate refresh token.

                    $dataRefreshToken = [
                        'iat' => $now->format("d-m-Y h:i:s"), // Issued At
                        'iss' => $serverName, // Issuer
                        'exp' => $expireRefresh,
                        'userName' => $user,
                    ];

                    // Generate a refresh token.

                    $refreshToken = JWT::encode($dataRefreshToken, $secretKey, 'HS512');

                    // Store Access token.

                    mysqli_query($db, "UPDATE users SET token='$accessToken', 
                        token_expires='$expire'");

                    //Storing Refresh token.

                    mysqli_query($db, "INSERT INTO refresh_token (user_id, refresh_token, expiry) VALUES
                        ('$userId', '$refreshToken', '$expireRefresh')");

                    if($accessToken)
                    {
                        $_SESSION['access_token'] = $accessToken;
                        $_SESSION['access_token_expires'] = $expire;
                        $_SESSION['refresh_token_expires'] = $expireRefresh;

                        $_SESSION['MESSAGE'] = "Access Token Generated";
                        header("location: /jwt/");
                        return;

                    }

                }
                else
                {
                    // Incase token present in database.

                    $currentTime = new \DateTime('now', new \DateTimeZone('Asia/Kolkata'));
                
                    if($_SESSION['access_token_expires'] < $currentTime->format("d-m-Y h:i:s"))
                    {
                        // means access token expired.

                        $res = mysqli_query($db, "SELECT * FROM refresh_token WHERE user_id='$userId'");
                    
                        while($resRow = mysqli_fetch_assoc($res))
                        {
                            $currentTime = new \DateTime('now', new \DateTimeZone('Asia/Kolkata'));

                            if(isset($resRow['refresh_token']))
                            {
                                if($resRow['expiry'] < $currentTime->format("d-m-Y h:i:s"))
                                {
                                    // If refresh token is expired.

                                    $_SESSION['MESSAGE'] = "Refresh Token Expired on ".$resRow['expiry'] ;
                                    
                                    unset($_SESSION['access_token']);
                                    unset($_SESSION['access_token_expires']);
                                    
                                    
                                    header("location: /jwt/");
                                    return;
                                }
                                else
                                {
                                    // If refresh token is not expired. Generate new acces token.
    
                                    $accessToken = JWT::encode($data, $secretKey, 'HS512');

                                    // UPDATE access token.


                                    mysqli_query($db, "UPDATE users SET token='$accessToken', 
                                                            token_expires='$expire'");

                                    $_SESSION['access_token'] = $accessToken;
                                    $_SESSION['access_token_expires'] = $expire;
                                }
                            }
                        }
                    }

                    header('location: /jwt/');
                    return;
                
                }

                header('location: /jwt/');
                    return;
            }

        }
    }



?>