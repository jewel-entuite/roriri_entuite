<!DOCTYPE html>
<html>
  <head>
    <title>Bootstrap Form Template</title>
    <!-- Include the Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  </head>
  <body>
    <div class="container">
      <h1>Bootstrap Form Template</h1>
      <form>
        <div class="form-group">
          <label for="name">Name:</label>
          <input type="text" class="form-control" id="name" placeholder="Enter your name">
        </div>
        <div class="form-group">
          <label for="email">Email address:</label>
          <input type="email" class="form-control" id="email" placeholder="Enter your email">
        </div>
        <div class="form-group">
          <label for="message">Message:</label>
          <textarea class="form-control" id="message" placeholder="Enter your message"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
    </div>
    
    <!-- Include the jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Include the Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </body>
</html>
