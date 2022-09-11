<?
$sql_photo_1="DELETE FROM iof_photos WHERE id_page = '$Selected_node'";
mysql_requete($sql_photo_1);

$sql_texte_1="DELETE FROM iof_textes WHERE id_page = '$Selected_node'";
mysql_requete($sql_texte_1);


if ($input_photo != "#") {
				$input_photo = ereg_replace("\\|\\#", "#", $input_photo);
				$input_photo = ereg_replace("\\#\\#", "", $input_photo);
				$input_photo = ereg_replace("\n", "", $input_photo);
				$input_photo = ereg_replace("\r", "", $input_photo);
				$input_photo = ereg_replace("\t", "", $input_photo);


$array_photo = explode("#", $input_photo);


for ($i = 0; $i < count ($array_photo); $i++) {
    $array_photo[$i] = explode("|", $array_photo[$i]);
	}

$array_photo_length=count ($array_photo);

	


	for ($i = 0; $i < $array_photo_length; $i++) {
    $value_photo_0=$array_photo[$i][0];	
	$value_photo_1=$array_photo[$i][1];
	$value_photo_2=$array_photo[$i][2];
	$value_photo_3=$array_photo[$i][3];
	$value_photo_4=$array_photo[$i][4];
	$value_photo_5=$array_photo[$i][5];

	$sql_photo_2="INSERT INTO iof_photos VALUES ('','$Selected_node','$value_photo_1','$value_photo_2','$value_photo_3','$value_photo_4','$value_photo_5')";
	mysql_requete($sql_photo_2);
}

	}
	
	if ($input_texte  != "#") {
				$input_texte = ereg_replace("\\|\\#", "#", $input_texte);
				$input_texte = ereg_replace("\\#\\#", "", $input_texte);
				$input_texte = ereg_replace("\n", "", $input_texte);
				$input_texte = ereg_replace("\r", "", $input_texte);
				$input_texte = ereg_replace("\t", "", $input_texte);



$array_texte = explode("#", $input_texte);


for ($i = 0; $i < count ($array_texte); $i++) {
    $array_texte[$i] = explode("|", $array_texte[$i]);
	}

$array_texte_length=count ($array_texte);
	
	for ($i = 0; $i < $array_texte_length; $i++) {
    $value_texte_0=$array_texte[$i][0];	
	$value_texte_1=$array_texte[$i][1];
	$value_texte_2=$array_texte[$i][2];
	$value_texte_3=$array_texte[$i][3];
	$value_texte_4=$array_texte[$i][4];
	$value_texte_5=$array_texte[$i][5];

	$sql_texte_2="INSERT INTO iof_textes VALUES ('','$Selected_node','$value_texte_1','$value_texte_2','$value_texte_3','$value_texte_4','$value_texte_5')";
	mysql_requete($sql_texte_2);
}

	}

				mysql_close();

?>