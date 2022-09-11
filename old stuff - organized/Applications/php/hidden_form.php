<HTML>
	<HEAD>
		<TITLE>Upload</TITLE>
	</HEAD>
<BODY>
<?PHP

	if ( isset( $image ) ) {
	
	require ("uploader.php");


	}


?>

<FORM ACTION="" METHOD="POST" ENCTYPE="multipart/form-data" name='form'>
	<B>Use this form to upload a JPEG as a SWF:</B>
	<TABLE>
		<TR>
			<TD>JPEG to upload:</TD>
			<TD><INPUT TYPE=TEXT NAME="target"></TD>
			<TD><INPUT TYPE=FILE NAME="image" ACCEPT="image/jpeg"></TD>
		</TR>
		<TR>
			<TD>&nbsp</TD>
			<TD><INPUT TYPE="SUBMIT" VALUE="Upload"></TD>
		</TR>
	</TABLE>		
</FORM>
</BODY>
</HTML>
