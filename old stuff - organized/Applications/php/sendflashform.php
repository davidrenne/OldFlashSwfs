<? 

// Copyright by filedesign.com 2001, 2002
// Information: Do not change the name of this file, it' ill not work !


// Configuration of recipient and subject.
       $recipient = "alex_zbg@yahoo.fr";
       $subject = "Message from Iris Open Flash";
	   

// Please do not change anything below this line!!!
// ________________________________________________
	 
       $mailheaders = "From: <$sender_email> \n";
       $mailheaders .= "Reply-To: <$sender_email>\n\n";

       $msg = "_____________________________________________________________________\n";
	   $msg .= "Sender's Name:      $sender_name\n";
	   $msg .= "\n";
       $msg .= "Sender's E-Mail:    $sender_email\n";
	   $msg .= "\n";
	   $msg .= "Message:\n\n$sender_message\n";
	   $msg .= "\n";
	   $msg .= "_____________________________________________________________________";
	   
       mail($recipient, $subject, $msg, $mailheaders) or die ("Couldn't send mail!");

?>



