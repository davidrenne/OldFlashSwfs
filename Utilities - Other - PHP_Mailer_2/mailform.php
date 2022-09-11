<?  

/******************************************************
**
**   PHP Mailer 2.0   
**
**   This script is easy to configure. Just change the variables below to
**    suit your environment and PHP does the rest!
**
**   http://www.bigjolt.com
**   
*******************************************************/

/******************************************************* 

Enter your site details below!

*******************************************************/

// Enter your contact email address here
$adminaddress = "bigjolt@bigjolt.com"; 

// Enter the address of your website here include http://www. 
$siteaddress ="http://www.your.site"; 

// Enter your company name or site name here 
$sitename = "Your Site Name"; 

/*******************************************************

No need to change anything below ... 

*******************************************************/

// Gets the date and time from your server
$date = date("m/d/Y H:i:s");

// Gets the IP Address
if ($REMOTE_ADDR == "") $ip = "no ip";
else $ip = getHostByAddr($REMOTE_ADDR);

//Process the form data!
// and send the information collected in the Flash form to Your nominated email address
if ($action != ""): 
mail("$adminaddress","Info Request", 
"A visitor at $sitename has left the following information\n
First Name: $fname 
Last Name: $lname
Email: $email
Company: $cname
Telephone: $telno\n
The visitor commented:
------------------------------
$comments

Logged Info :
------------------------------
Using: $HTTP_USER_AGENT
Hostname: $ip
IP address: $REMOTE_ADDR
Date/Time:  $date","FROM:$adminaddress"); 

//This sends a confirmation to your visitor
mail("$email","Thank You for visiting $sitename", 
"Hi $fname,\n
Thank you for your interest in $sitename!\n
Cheers,
$sitename
$siteaddress","FROM:$adminaddress"); 

//Confirmation is sent back to the Flash form that the process is complete
$sendresult = "Thank you for visiting <a href = \"$siteaddress\" target = \"_blank\"><u>$sitename</u></a>. You will receive a confirmation email shortly. ";
$send_answer = "answer=";
$send_answer .= rawurlencode($sendresult);
echo "$send_answer";

endif;

?>

