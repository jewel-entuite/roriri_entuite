<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Login</title>
    <style>
      /* Center the card and add shadow */
      .card-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }

      .card {
        display: flex;
        width: 80%;
        max-width: 900px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      }

      /* Split the card into two halves */
      .card-img {
        flex: 1;
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
        overflow: hidden;
      }

      .card-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

      .card-body {
        flex: 1;
        padding: 30px;
      }

      .form-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
      }

      .form-subtitle {
        font-size: 16px;
        color: #6c757d;
        margin-bottom: 20px;
      }

      .btn-primary {
        width: 100%;
      }

      .form-floating input {
        border-radius: 5px;
      }

      /* Ensure form fields have appropriate spacing */
      .form-floating {
        margin-bottom: 15px;
      }

      .form-check-label {
        color: #007bff;
      }
    </style>
  </head>
  <body>
    <div class="card-container">
      <div class="card">
        <!-- Left half for image -->
        <div class="card-img">
          <img src="assets/img/home_img.jpg" alt="Illustration" />
        </div>
        <!-- Right half for form -->
        <div class="card-body">
          <h2 class="form-title">Login</h2>
          <p class="form-subtitle">Please enter your credentials to continue.</p>
          <form action="../controller/_login.cfm?token=login" name="login" method="post">
            <div class="form-floating mb-3">
              <input type="email" class="form-control" id="email" placeholder="Email" name="email">
              <label for="email">Email</label>
            </div>
            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="password" placeholder="Password" name="password">
              <label for="password">Password</label>
            </div>
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" value="remember-me" id="rememberMe">
              <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <div class="d-flex justify-content-between mb-3">
              <a href="#" class="text-primary">Forgot Password?</a>
              <a href="#" class="text-primary">Sign Up</a>
            </div>
            <button class="btn btn-primary" type="submit">Login</button>
            <button class="btn btn-outline-dark mt-3 w-100" type="button">Login with Google</button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
