<?
	// Example script using jm_sms class
	$debug = FALSE;			// Debugging messages not displayed
	$smsAc = FALSE;			// Set to true if using SMS.AC

	include( "class.jm_sms.php" );
	$jm_sms = new jm_sms( $email, $password, $debug, $smsAc );
	$jm_sms->sendSMS( $number, $signature, $message );
?>
