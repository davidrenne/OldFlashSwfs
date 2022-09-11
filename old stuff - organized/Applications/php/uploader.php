<?
	
require ("./lib/clsUpload.php");
require ("./lib/flashutils.php");


$upload_path = "../upload/";
$data_path = "../data/";
$uniq=uniqid("");
$data_name = $uniq.".swf";
$target .= ".preview_photo.new_data";


$upload = new Upload($HTTP_POST_FILES);
$upload->maxupload_size = 2000000; // 2,000,000 bytes, or 2mb

$upload_filename = $upload->getFileName("image");

$mime_type = $upload->getFileMimeType("image");


switch ($mime_type) {

	
	case "image/pjpeg":

			$upload_name = $uniq.".jpg";
			move_uploaded_file($image, $upload_path.$upload_name);
			$flashimg = new FlashImage;

			// try to read image-data
			if ( !$flashimg->setImage( $upload_path.$upload_name ) ) {
				echo "Error - couldn't read JPEG.<br>";
			}
			// check for progressive JPEGs
			else if ( !$flashimg->checkImage() ) {
				echo "Error - progressive JPEG are not supported by Flash.<br>";
			}
			else {
				// convert the image to a swf and save it
				if ( !$flashimg->saveToFile( $data_path.$data_name) ) {
					echo "Error - SWF couldn't be saved.<br>";
				}
				else {
					echo "SWF has been created and saved.<br>";
				}
			}





	break;



    case "image/gif":


	break;


	case "image/x-png":

	break;


    case "application/x-shockwave-flash":

			$upload_name = $uniq.".swf";

				if ( !move_uploaded_file($image, $upload_path.$upload_name) ) {
					echo "Error - SWF couldn't be saved.<br>";
				}
				else {
					echo "SWF has been saved.<br>";
				}

				if ( !@copy( $upload_path.$upload_name, $data_path.$upload_name) ) {
					echo "Error - SWF couldn't be saved.<br>";
				}
				else {
					echo "SWF has been saved.<br>";
				}


        break;



    case "image/bmp":
        save_file(".bmp");
        break;

}

?>
  
  
 <SCRIPT LANGUAGE="JavaScript"> 

parent.flash_frame.movie.SetVariable("<? echo $target; ?>","<? echo $data_name; ?>");
	
</SCRIPT>
