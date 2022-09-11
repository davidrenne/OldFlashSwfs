<?php


		require_once('lib/mysql.inc');
		mysql_access_connect();
	switch($command)
		{
			case 1 :
				require "page_init.php";
				break;
			case 2 :
				require "page_update.php";
				break;
			
			default	:
				break;
		}
	
?>
