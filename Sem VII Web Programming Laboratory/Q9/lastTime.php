<?php
//	echo "Something";
	
	if(ISSET($_COOKIE["lastVisit"])){
		setcookie("lastVisit",date('G:i -m/d/y'));
		echo "Last Visit Time : ".$_COOKIE['lastVisit'];
	}
	else{
		setcookie('lastVisit',date("G:i -m/d/y"));
		echo "This is the first visit.";
	}
?>
