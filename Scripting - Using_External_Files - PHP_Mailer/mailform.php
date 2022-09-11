<?  

/******************************************************
**
**   This script is easy to configure. Just change the variables below to
**    suit your environment and PHP does the rest!
**
**   http://www.bigjolt.com
**   
*******************************************************/

// Enter your email address here
$adminaddress = "you@your.site"; 

// Enter the address of your website here MUST include http://www. 
$siteaddress ="http://www.your.site"; 

// Enter your company name or site name here 
$sitename = "Your Site Name"; 

// Gets the date and time from your server
$date = date("m/d/Y H:i:s");

// Gets the IP Address
if ($REMOTE_ADDR == "") $ip = "no ip";
else $ip = getHostByAddr($REMOTE_ADDR);

//Process the form data!
// and send the information collected in the Flash form to Your nominated email address
IF ($action != ""): 
mail("$adminaddress","Info Request", 
"FAO: Admin @ $sitename \n
First Name: $fname 
Last Name: $lname
Email: $vemail
Company: $cname
Telephone: $telno\n
The visitor commented:
------------------------------
$comments
------------------------------

Logged Info :
------------------------------
Using: $HTTP_USER_AGENT
Hostname: $ip
IP address: $REMOTE_ADDR
Date/Time:  $date","FROM:$adminaddress"); 


//This sends a confirmation to your visitor
mail("$vemail","Thank You for visiting $sitename", "Hi $fname,\n
Thank you for your interest in $sitename!\n
Cheers,
$sitename
$siteaddress","FROM:$adminaddress"); 

//Confirmation is sent back to the Flash form that the process is complete
$sendresult = "Done!";
$send_answer = "answer=";
$send_answer .= rawurlencode($sendresult);
echo "$send_answer";

ENDIF;
?>

