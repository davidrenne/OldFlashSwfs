<?php
error_reporting(E_ALL & ~E_NOTICE);
function mysql_access_mysql_error($error_code)
{
$output = "&error=";
			$output .= "Error n°".$error_code." occured while trying to connect to your database server!";
			
			$output = ereg_replace("\n", "", $output);
			$output = ereg_replace("\r", "", $output);
			echo $output;
   exit();	
}
function mysql_access_connect()
{
	@mysql_connect("localhost","root","password") or mysql_access_mysql_error(1);
	@mysql_select_db("iris_open_flash") or mysql_access_mysql_error(2);
}
function mysql_requete($requete)
{
   if(!($resultat=@mysql_query($requete)))
   {
      print $requete;
	  mysql_access_mysql_error(3);
   }
   return $resultat;
}
function mysql_lire_ligne($resultat_requete)
{
   if(!($resultat=@mysql_fetch_array($resultat_requete)))
   {
      print $resultat_requete;
   }
   return $resultat;
}
function mysql_access_nettoye($resultat_requete)
{
   mysql_free_result($resultat_requete);
}
function mysql_nombre_resultat($resultat_requete)
{
   return mysql_num_rows($resultat_requete);
}
?>
