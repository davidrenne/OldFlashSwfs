<?
/*
###################################################################################
#      sendmailscript by seven7 / zoozoozoo.de/tools        2002 (c)zoozoozoo.de
###################################################################################
#                            check http://www.zoozoozoo.de
#
#                        the curch says the earth is flat, 
#                  but ive seen the shadow on the moon and i have
#                    more faith in the shadow than in the church.
#
#                         variablen erklaeren sich von selbst :)
####################################################################################


            _
          ./ |   _________________
         /  /   /  __________    //\_
       /'  /   |  (__________)  ||.' `-.________________________
      /   /    |    __________  ||`._.-'~~~~~~~~~~~~~~~~~~~~~~~~`
     /    \     \__(__________)__\\/
    |      `\
    |        |                                ___________________
    |        |___________________...-------'''- - -  =- - =  - = `.
   /|        |                   \-  =  = -  -= - =  - =-   =  - =|
  ( |        |                    |= -= - = - = - = - =--= = - = =|
   \|        |___________________/- = - -= =_- =_-=_- -=_=-=_=_= -|
    |        |                   ```-------...___________________.'
    |________|      
      \    /                                       _
      |    |                              ,,,,,,, /=\
    ,-'    `-,       /\___________       (\\\\\\\||=|
    |        |       \/~~~~~~~~~~~`       ^^^^^^^ \=/
    `--------'                                     `
                     
#######################################################################################
#                           DONT TRY THIS AT HOME
#######################################################################################
# variablen aus flash : $name, $vorname, $telefon, $email, $comment
#######################################################################################

*/
//

// empfaenger hier email-adresse einfuegen
$empf="du@deinedomain.de";

// text fuer sender-bestaetigungsemail
$vtext="Ihre Mail ist sicher bei $empf angekommen.";

//subject fuer empfaengeremail
$betreff="Mail von Homepage";

//anredetext fuer empfaengeremail
$anrede="Folgende email wurde von Ihrer Homepage versendet: ";

// Betreff der Bestätigungsmail
$bestaetigung="Mail angekommen";

$comment=str_replace("\\\"","\"",$comment);
$comment=str_replace("\'","'",$comment);
urlencode ($text);
$comment=str_replace("%0D","\n",$comment);

//ip des absenders
$report = "mail wurde verschickt von:"."\n"."---------------------------------"."\n\n"."remote host: ".$REMOTE_HOST."\n".
"remote adr: ". $REMOTE_ADDR."\n"."browser: ". $HTTP_USER_AGENT."\n\n\n\n";

//inhalt der empfaengeremail definieren var aus flashfilm
$inhalt=$anrede."\n\n"."Name: ".$name."\n"."Vorname: ".$vorname."\n"."Telefonnummer: ".$telefon."\n\n"."Kommentar: ".$comment."\n\n\n\n".$report;

// e-Mail wird abgeschickt und zur Bestätigung wird noch eine Mail an den Absender geschickt
mail($empf,$betreff,$inhalt,"From: ".$email);
mail($email,$bestaetigung,$vtext,"From: ".$empf);

// <---------------------- this is the end my friend ----------------------------->
?>
