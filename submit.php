<?php
	session_save_path('');
	session_start();
	$host = '';
	$username = '';
	$password = '';
	$database = '';

	global $nameErr;

	$connection = @mysqli_connect($host, $username, $password, $database);
	if (!$connection) {
		echo "Error: Unable to connect to MySQL." . PHP_EOL;
		echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
		echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
		exit;
	}
	if (isset($_POST['score'])) {
		$_SESSION['score'] = $_POST['score'];
	}
	
 //check to see that the form has been submitted
if(isset($_POST['submit-form']) && isset($_SESSION['score'])) { 
 
    //retrieve the $_POST variables
    $name = $_REQUEST['name'];
    $score = $_SESSION['score'];

    //initialize variables for form validation
    if (!preg_match('/^[a-zA-Z0-9@_]*$/', $name) || preg_match('/\S/', $name)) {
    	$success = false;
        $nameErr = "Only alphanumeric characters and '_' are allowed";
    } else {
        $success = true;
        $nameErr = "";
    }
 
    if($success)
    {
        $query = "INSERT INTO flappybird_leaderboard (name,score) VALUES ('$name', '$score')";

        $result = @mysqli_query($connection, $query);
        unset($_SESSION['score']);

        if(! $result ) {
      		die('Could not enter data!!! ' . @mysql_error());
  		}

        //redirect them to a welcome page
        header("Location: http://minhtran.comuf.com/flappybird/leaderboard.php");
 
    }

    @mysqli_close();

}


?>


<!-- Flappy Bird -->

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Leaderboards</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<style type="text/css">
		#h2obj {
			padding-bottom: 15px;
		}
	</style>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand" href="http://minhtran.comuf.com">Home</a>
		    </div>

		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li><a href="http://minhtran.comuf.com/flappybird">Flappy Bird Online</a></li>
		        <li><a href="http://minhtran.comuf.com/flappybird/leaderboard.php">Leaderboard</a></li>
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>

		<div class="row">
		<div class="page-header">
			<h2>Leaderboard</h2>
		</div>
		</div>

		<div class="well">
		<div class="row">

			<h3 id="h2obj">Enter a name to be added to the leaderboards.</h3>
		</div>
		<div class="row">
			<form class="form-horizontal" method='post'>
			  <div class="form-group">
			    <label for="inputName3" class="col-sm-4 control-label">Name</label>
			    <div class="col-sm-4">
			      <input type="name" class="form-control" id="inputName3" placeholder="Name" name="name" method="post">
			    </div>
			  </div>
			  <?php
			  	//if (!empty($nameErr)) {
			  		echo "<div class=\"form-group\">";
			  		echo "<div class=\"alert alert-danger col-smo-offset-3 col-md-4\" role=\"alert\">";
					echo "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>";
					echo "<span class=\"sr-only\">Error:</span>";
					echo "$nameErr";
					echo "</div>";
					echo "</div>";
			  	//}

			  ?>
			  <div class="form-group">
			    <div class="col-sm-offset-3 col-sm-6">
			      <button type="submit" class="btn btn-primary" value="submit" name="submit-form" method="post">Submit</button>
			    </div>
			  </div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>	