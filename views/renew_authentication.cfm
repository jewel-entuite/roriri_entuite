<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="./assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!--- <link rel="stylesheet" href="../assets/css/style.css"> --->
    <title>RORIRI -Employee Management : Login</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
    <!-- Bootstrap core CSS -->
<!--- <link href="./assets/dist/css/bootstrap.min.css" rel="stylesheet"> --->

    <style>

      *{
       padding: 0; margin: 0; 
     }
      html, body, .container {
          min-height: 100% !important;
          height: 100%;
      }
      body{
        background-image: url('./images/bg_img4.jpg');
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
        background-color: #2B173C; 
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
        width: 60px;
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
          width: 50px;
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
          width: 40px;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <!--- <link href="signin.css" rel="stylesheet"> --->
  </head>
    <body class="text-center">
      <cfoutput>
      <div class="error-message" id="error"></div>
        <cfif structKeyExists(url, "d")>
          <script>
            document.getElementById("error").innerHTML= "invalid Login"
          </script>
        </cfif>
<div class="container">
  <div class="login-section">
      <div class="card p-5">
        <main class="form-signin">
          <form action="../controller/_login.cfm" name="create_password" method="post">
            <h4>Create Password</h4>
            <input type="hidden" value="50" name="create_password">
            <cfif structKeyExists(url,"token")>
              <input type="hidden" value="#url.token#" name="en_id">
            </cfif>
            <div class="form-floating my-4">
              <input type="text" class="form-control" id="username" placeholder="User Name" name="username">
              <label for="floatingPassword">User Name</label>
            </div>
            <div class="form-floating my-4">
              <input type="password" class="form-control" id="password" placeholder="New Password" name="password">
              <label for="floatingPassword">New Password</label>
            </div>
             <div class="form-floating my-4">
              <input type="password" class="form-control" id="cpassword" placeholder="Confirm Password" name="cpassword">
              <label for="floatingPassword">Confirm Password</label>
            </div>
                <button class="btn btn-lg btn-primary my-2 login-button" type="submit">Submit</button>
          </form>
        </main>
      </div>
    </div>
    </div>
  </cfoutput>
  </body>
</html>