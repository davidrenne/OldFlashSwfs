<?
// Shopping Cart Version 1.0
// Copyright Ben Miles, 2002

// subject
$subject = "Order from $inputName $date";

// additional header pieces for errors, From cc's, bcc's, etc 
$headers = "From: $inputName <$inputEmail>\n";
$headers .= "X-Sender: <$inputEmail>\n";
$headers .= "X-Mailer: PHP\n"; // mailer
$headers .= "X-Priority: 1\n"; // Urgent message!
$headers .= "Return-Path: $inputName <$inputEmail>\n";  // Return path for errors

// get ip and date
$date = date("m/d/Y H:i:s");
if ($REMOTE_ADDR == "") $ip = "no ip";
else $ip = getHostByAddr($REMOTE_ADDR);

// recipients (enter your e-mail here)
$recipient = "youremail@email.com";

// message 
$message = "
Order from $inputName : $inputEmail : $date : 
The Shopping Cart Version 1.0
------------------------------
Name: $inputName
Address: $inputAddress
City: $inputCity
State: $inputState 
Zip: $inputZip
Email: $inputEmail
Message: $inputMessage
Quanity of Black Stickers Ordered: $inputItem1q
Quanity of White Stickers Ordered: $inputItem2q
Order Total: $inputTotal

------------------------------
Logged Info :
------------------------------
Using: $HTTP_USER_AGENT
Hostname: $ip
IP address: $REMOTE_ADDR
Date/Time:  $date";

// mail it
mail($recipient, $subject, $message, $headers);

// Send information to comstomer
// ---------------------------

/* subject */
$subject = "Ordering Information for $inputName";

/* additional header pieces for errors, From cc's, bcc's, etc */
// Change this info to meat your name ect...
$headers = "From: Sales <youremail@email.com>\n";
$headers .= "X-Sender: <youremail@email.com>\n";
$headers .= "X-Mailer: PHP\n"; // mailer
$headers .= "X-Priority: 1\n"; // Urgent message!
$headers .= "Return-Path: Sales <youremail@email.com>\n";  // Return path for errors

/* recipients */
$recipient = $inputEmail;

/* message */
$message = "
Thank you $inputName for visiting us, 
and ordering from the store!
Your order form has been submitted and 
we will ship the product once we recieve payment.  
Remember that we only except cash, check, and money orders.  
If you decide to pay by check expect an extra week to 
allow the check to clear.
Here is your ordering information:

------------------------------
Enquiry from the Shopping Cart Version 1.0:
------------------------------
Name: $inputName
Address: $inputAddress
City: $inputCity
State: $inputState 
Zip: $inputZip
Email: $inputEmail
Message: $inputMessage
Quantity of Black Stickers Ordered: $inputItem1q
Quantity of White Stickers Ordered: $inputItem2q
Total Amount Due: $inputTotal

If any of the information above is incorrect
please e-mail us with the fixes.

-------------------------------
Here is the shipping information on where to send payment of $inputTotal to:
Enter where you want payment to be shipped to:

You will receive an e-mail once we have collected your payment and shipped the product.
Thank you";

mail($recipient, $subject, $message, $headers);
?>