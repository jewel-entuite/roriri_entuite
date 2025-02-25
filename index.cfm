<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <title>RORIRI -Employee Management : Login</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
    <!-- Bootstrap core CSS -->

    <style>

      *{
       padding: 0; margin: 0; 
     }
      html, body, .container {
          min-height: 100% !important;
          height: 100%;
      }
      body{
        background-image: url('./images/bg_img.jpg');
        background: f6f5fa;
        background-repeat: no-repeat;
        background-size: cover;
        font-family: sans-serif;
      }
      .container{
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
      }
      .login-section{
        height: 520px;
      }
      .card{
        width: 460px;
        align-items: center;
        height: 460px;
        opacity: 75%; 
        background-color: #57429f; 
        color: white ;
        border-radius: 20px;
      }
      .footer{
        position: absolute;
        bottom: 0;
        width: 20%;
        left: 40%;
      }
      .form-floating{
        color: black;
      }
      .form-signin{
        width: 380px;
      }.font{
        font-size: 20px;
      }
      .img{
        width: 200px;
      }
      @media (max-width: 700px) {
        .login-section{
          height: 560px;
        }
        .card{
          width: 360px;
          height: 500px;
        }
        .form-signin{
          width: 280px;
        }
        .font{
          font-size: 16px;
        }
        .img{
          width: 200px;
        }
      }
      @media (max-width: 400px) {
        .login-section{
          height: 580px;
        }
        .card{
          width: 260px;
          height: 520px;
        }
        .form-signin{
          width: 180px;
        }
        .font{
          font-size: 14px;
        }
        .img{
          width: 200px;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
  </head>
    <body class="text-center">
      
      <div class="error-message" id="error"></div>
        <cfif structKeyExists(url, "d")>
          <script>
            document.getElementById("error").innerHTML= "invalid Login"
          </script>
        </cfif>
<div class="container">
  <div class="login-section">
      <div class="card">
        <main class="form-signin">
          <form action="../controller/_login.cfm?token=login" name="login" method="post" enctype="multipart/form-data">
            <div class="justify-content-center">
              <img class="mb-0 img" src="../images/logo.jpeg" alt="">
                <h5 class="mb-0 my-3 font">Human Resource Management System</h5>
            </div>
            <h5 class="my-2 font">Welcome!</h5>
            <br>
            <div class="form-floating">
              <input type="text" class="form-control" id="userid" placeholder="userid" name="userid">
              <input type="hidden" name="login">
              <label for="userid">User ID</label>
            </div>
            <br>
            <div class="form-floating">
              <input type="password" class="form-control" id="password" placeholder="Password" name="password">
              <label for="floatingPassword">Password</label>
            </div>
            <br>
            <div class="checkbox mb-2">
              <label><input type="checkbox" value="remember-me"> Remember me</label>
            </div>
                <button class="btn btn-lg btn-light my-2 login-button" type="submit">Login</button>
          </form>

        </main>
      </div>
    </div>
    </div>
      <div class="footer">
        <p class="mt-5 mb-3 text-muted">&copy;<cfoutput>#year(now())#</cfoutput></p>
      </div>
      
  </body>
</html>