
<!-- Flappy Bird -->

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Flappy Bird</title>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/processing.js/1.4.16/processing.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/style.css">
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
		      <a class="navbar-brand" href="index.html">Home</a>
		    </div>

		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li class="active"><a href="index.html">Flappy Bird Online <span class="sr-only">(current)</span></a></li>
		        <li><a href="leaderboard.php">Leaderboard</a></li>
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>

		<div class="row">
		<div class="page-header">
			<h2>Flappy Bird Online <small>Clone of the popular iOS game</small></h2>
		</div>
		</div>

		<div class="row">
		<div class="well">
			<canvas id="game_canvas" data-processing-sources="flappy.pde"></canvas>
		</div>
		</div>
		<script type="text/javascript">
		   function getValue(v) {
				console.log(v);				
				$.ajax({
			      url: 'submit.php',
			      type: 'POST',
			      data: {'score': v},
			      success: function() {
			        location.href = "submit.php";
			      },
			      error: function(xhr, desc, err) {
			        console.log(xhr);
			        console.log("Details: " + desc + "\nError:" + err);
			      }
			    });
			}
		</script>

	</div>
</body>
</html>
