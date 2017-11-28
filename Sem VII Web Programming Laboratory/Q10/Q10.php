<?php
	session_start();
	if(ISSET($_SESSION['visitCount'])){
		$_SESSION['visitCount'] += 1;
		echo "Total Visit Count : ".$_SESSION['visitCount'];
	}
	else{
		$_SESSION['visitCount'] = 1;
		echo "Total Visit Count : ".$_SESSION['visitCount'];
	}
?>
