<HTML>
<HEAD>
<TITLE>PHP Mailform</TITLE>
<BODY>

<!-- Made for Flashkit by dj@petter.as -->

<?php 


$TextVariable = '&results=';
$response = 'Data Sent. Thank You..';


echo $TextVariable;
echo $response;

mail ("youremail@yourhost.com", "Mailform - by dJ_pEtTeR", "

Flash Form Response:

name:		$name
email:	        $email
url:		$url

user comments:

$comment

Sent From : $REMOTE_ADDR 


");


?>


</body> 
</html>