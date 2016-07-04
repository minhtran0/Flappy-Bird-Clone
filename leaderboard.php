<!-- Flappy Bird -->

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Leaderboard</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<style type="text/css">
		#h3obj {
			padding-bottom: 15px;
		}
		.tableheading {
			text-align: center;
		}
		#page {
			padding-bottom: 30px;
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
		      <a class="navbar-brand" href="index.html">Home</a>
		    </div>

		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li><a href="index.html">Flappy Bird Online</a></li>
		        <li class="active"><a href="leaderboard.php">Leaderboard<span class="sr-only">(current)</span></a></li>
		      </ul>
		      
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>

		<div class="row">
		<div class="page-header">
			<h2>Leaderboard</h2>
		</div>
		</div>


		<div class="panel panel-default">
		<div class="row">
			<h3 id="h3obj">Top Scores Overall</h3>
		</div>
		<?php

			session_save_path('');
			session_start();

			if (isset($_SESSION['name'])) {

				// Log into database
				$host = '';
				$username = '';
				$password = '';
				$database = '';

				$connection = @mysqli_connect($host, $username, $password, $database);
				if (!$connection) {
			    	echo "Error: Unable to connect to MySQL." . PHP_EOL;
					echo "Debugging errno: " . @mysqli_connect_error() . PHP_EOL;
					echo "Debugging error: " . @mysqli_connect_error() . PHP_EOL;
					exit;
				}

				$query = "SELECT * FROM flappybird_leaderboard ORDER BY score DESC, id ASC";
				$rank = 1;

				$data = @mysqli_query($connection, $query);

				while ($row = @mysqli_fetch_assoc($data)) {
					if ($row['name'] == $_SESSION['name']) {
						break;
					}
					$rank++;
				}
				$_SESSION['rank'] = $rank;

				echo "<div class=\"row\">\n";
				echo "<h4>'<strong>". $_SESSION['name'] . "</strong>' is ranked <strong>$rank" . "th</strong></h4>\n";
				echo "</div>\n";

				unset($_SESSION['name']);
				@mysqli_close($connection);
			}

		?>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
			<table class="table table-striped table-bordered table-hover">
				<tr>
					<th class="tableheading col-md-2">Rank</th>
					<th class="tableheading col-md-5">Name</th>
					<th class="tableheading col-md-5">Score</th>
				</tr>
				
				  <?php

				  	$host = '';
				  	$username = '';
				  	$password = '';
				  	$database = '';

				  	$connection = @mysqli_connect($host, $username, $password, $database);
				  	if (!$connection) {
					    echo "Error: Unable to connect to MySQL." . PHP_EOL;
					    echo "Debugging errno: " . @mysqli_connect_error() . PHP_EOL;
					    echo "Debugging error: " . @mysqli_connect_error() . PHP_EOL;
					    exit;
					}

				  	$query = "SELECT name, score FROM flappybird_leaderboard ORDER BY score DESC, id ASC LIMIT 100";
				  	$result = @mysqli_query($connection, $query);
				  	$rank = 1;

			        while($row = @mysqli_fetch_assoc($result)) { 
			        	if (isset($_SESSION['rank']) &&$_SESSION['rank'] == $rank) {
				        	echo "\t\t\t\t<tr>\n";
				        	echo "\t\t\t\t\t<td class=\"bg-success\">" . $rank . "</td>\n";
				        	if ($rank <= 10)
				        		echo "\t\t\t\t\t<td class=\"bg-success\">" . $row['name'] . "</strong></td>\n";
				        	else
				        		echo "\t\t\t\t\t<td class=\"bg-success\">" . $row['name'] . "</td>\n";
				        	echo "\t\t\t\t\t<td class=\"bg-success\">" . $row['score'] . "</td>\n";
				        	echo "\t\t\t\t</tr>\n";
				        	$rank++;
			        	}
			        	else {
			        		echo "\t\t\t\t<tr>\n";
				        	echo "\t\t\t\t\t<td>" . $rank . "</td>\n";
				        	if ($rank <= 10)
				        		echo "\t\t\t\t\t<td><strong>" . $row['name'] . "</strong></td>\n";
				        	else
				        		echo "\t\t\t\t\t<td>" . $row['name'] . "</td>\n";
				        	echo "\t\t\t\t\t<td>" . $row['score'] . "</td>\n";
				        	echo "\t\t\t\t</tr>\n";
				        	$rank++;
			        	}
			        }
			        unset($_SESSION['rank']);

			        @mysqli_close($connection);
			    ?>


			</table>
			</div>
			<div class="col-md-3"></div>
		</div>
		<div class="row" id="page">
			<div class="btn-group" id="prevpage" role="group" aria-label="...">
			<button type="button" class="btn btn-default">&lt</button>
			<button type="button" id="page" class="btn btn-default">1</button>
  			<button type="button" id="nextpage" class="btn btn-default">&gt</button>
			</div>
		</div>
		</div>
	</div>
</body>
</html>
		