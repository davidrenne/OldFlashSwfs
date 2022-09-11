<?
	$Name = ereg_replace("[^A-Za-z0-9 ]", "", $Name);
	$Name = stripslashes($Name);

	$Pass = ereg_replace("[^A-Za-z0-9 ]", "", $Pass);
	$Pass = stripslashes($Pass);

        $Email = ereg_replace("[^A-Za-z0-9 \@\.\-\/\']", "", $Email); 
	$Email = stripslashes($Email);

if ($Submit == "Yes") {
	$filename = "/home/swishdbc/public_html/mlogin/Members.txt";
	$fp = fopen( $filename,"r"); 
	$OldData = fread($fp, 80000); 
	fclose( $fp ); 
	$Input = "$Name,$Pass,$Email";
	$New = "$OldData\n$Input";
	$fp = fopen( $filename,"w+"); 
	fwrite($fp, $New, 80000); 
	fclose( $fp ); 
       }
?>