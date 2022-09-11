<?
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 * Copyright (c) Polar Lights Studios (www@ok.ru)
 *
 *
 * You may freely distribute this script as-is with any  modifications.
 * You may use this script freely, and modify it for your own purposes.
 * There is no charge for this script. But if you like it, please leave
 * that comment and $php_hearder without modifications :)
 * I hope that this script is the simplest way to send mail using PHP3.
 *
 *          Ilya Rudev
 *                    March 2000
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
*  Script modified to send confirmation email to user
*    
*  In first frame of .fla set Variable: "to" = "you@yoursite.com"
*  In script below change $confirm_header = "From: your name<mail@yoursite.com>";
*
*            Stephen Moran (testguy@hotmail.com)
*	          July 2000           
*
***********************************************************/

/****Here is the only two variables, that need to be defined.****/

/*How many times at a stretch visitor can send mail using the script (2 times default)*/
$opss = 50;

/*And after what amount of time allow that visitor to send mail again (1 hour default)*/
$ok = 3600;

$php_header = "From: $name <$from>\n".
                  "X-Mailer: Polar Lights Studios/Flash-PHP3 script";
$antispam = $HTTP_COOKIE_VARS["times"];
$message_tosent=$message."\n\n send by $REMOTE_ADDR.";
if ($antispam < $opss){
	setcookie("times",$antispam+1,gmdate(time()) +$ok);
	if (@Mail($to,
      	    $subject,
		    $message_tosent,
      	    $php_header)){
		    echo "&info=Mail sent. Thank you. A confirmation email wil be sent. &";
$confirm_to = $name . "<$from>";
$confirm_header = "From: Customer Service<mail@yoursite.com>";
$confirm_message = "Your message has been sent. \nTo: $to\nSubject: $subject\n";
$confirm_subject = "Email Confirmation";
@mail($confirm_to,$confirm_subject,$confirm_message,$confirm_header);
	}else{
		    echo "&info=Error. Please try later.&";
      }
}
else{
	echo "&info=Sorry. Spamming not allowed here.&";
}
?>