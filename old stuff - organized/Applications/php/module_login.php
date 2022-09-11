<?php
	
			require('lib/mysql.inc');
			mysql_access_connect();


		
        $sql1 = "select login from admin";
        $query1 = mysql_query($sql1) or die ("Couldn't get Login.");
        $res1 = mysql_fetch_array($query1);
		$Login = $res1['login'] ;
		
		$sql2 = "select password from admin";
        $query2 = mysql_query($sql2) or die ("Couldn't get Password.");
        $res2 = mysql_fetch_array($query2);
		$Password = $res2['password'] ;

		if ($Login == $LoginFlash && $Password == $PasswordFlash) {
		
				$sendlogin = "sendlogin=1";
		        echo "$sendlogin" ;	
			
		} else {
		
				$sendlogin = "sendlogin=0";
		        echo "$sendlogin" ;	 
		
		}
		
		

?>
