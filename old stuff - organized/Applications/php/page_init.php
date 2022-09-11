<?php
	
	
       // $sql="SELECT idposte, nomposte$lang AS nomposte, contacts.*, clubs.*, pays.* FROM postes LEFT JOIN contacts USING(ID) LEFT JOIN clubs USING(idclub) LEFT JOIN pays USING(idpays) WHERE idrub=5 ORDER BY ordre";

		$sql_photo="select * from iof_photos where id_page = '$Selected_node' order by id_photo";
		$res_photo=mysql_requete($sql_photo);
		
		$fields_photo = array("id_photo","nom_photo", "x_photo", "y_photo","height","width");
				
		$output_photo = "&output_photo=";
			
		
   				
				while($ligne_photo=mysql_fetch_array($res_photo))
				{
				
					for ($i = 0; $i < count ($fields_photo); $i++) {
		
						$output_photo .= $ligne_photo["$fields_photo[$i]"];
						$output_photo .= "|";
		
					}
				$output_photo .= "#";	
				} 
				$output_photo .= "#";
				

		$sql_texte="select * from iof_textes where id_page = '$Selected_node' order by id_texte";
		$res_texte=mysql_requete($sql_texte);
		
		$fields_texte = array("id_texte","contenu_texte", "x_texte", "y_texte","height","width");
				
		$output_texte = "&output_texte=";
			
		
   				
				while($ligne_texte=mysql_fetch_array($res_texte))
				{
				
					for ($i = 0; $i < count ($fields_texte); $i++) {
		
						$output_texte .= $ligne_texte["$fields_texte[$i]"];
						$output_texte .= "|";
		
					}
				$output_texte .= "#";	
				} 
				$output_texte .= "#";

				

				$output=$output_photo.$output_texte;
				$output .= "&error=none";

				$output = ereg_replace("\\|\\#", "#", $output);
				$output = ereg_replace("\\#\\#", "", $output);
				$output = ereg_replace("\n", "", $output);
				$output = ereg_replace("\r", "", $output);
				
				echo $output;
		
	
				mysql_close();


?>
