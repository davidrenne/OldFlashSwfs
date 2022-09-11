<html>
<head>
<title>Power Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<?
$corps=$name."\n".$forname."\n".$adress."\n".$zip."\n".$city."\n".$country."\n".$telephone."\n".$admail."\n".$message."\n";
mail($recipient,$subject,$corps,"From: $admail\nReply-To:$admail\nX-Mailer: PHP/");
?>
</body>
</html>
