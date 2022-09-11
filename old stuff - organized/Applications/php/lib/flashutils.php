<?php

/*****************************************************************************
 *
 *  FlashWriter Utilities v1.01
 *
 *  Copyright (c) 2002 Stefan Schüßler
 *
 *  This software comes with ABSOLUTELY NO WARRANTY. It is free, and
 *  you are welcome to redistribute it.
 *
 *  The name "Stefan Schüßler" may not be used to endorse or promote
 *  products derived from this software without specific prior
 *  written permission.
 *
 *  For written permission, please contact info@stefanschuessler.de
 *
 *  Redistributions of source code must retain the above notices.
 *
 *  File Name:
 *
 *     flashutils.php
 *
 *  Abstract:
 *
 *     PHP utility function for generating Shockwave Flash files
 *     with the FlashWriter Toolkit
 *
 *  Environment:
 *
 *     Shockwave Flash / PHP
 *
 *****************************************************************************/

require( "./lib/flashwriter.php" ); // include flashwriter-functions

/*****************************************************************************
 *
 *  Prepare output
 *
 *****************************************************************************/

define( "maxJPEGSize", 100000 );

class FlashImage {
	var $image;
	var $width;
	var $height;
	var $filesize;
	var $imageData;
	var $footer1;
	var $footer2;
	var $footer3;
	
	function setImage( $filename ) {
		$this->image     = "";
		$this->imageData = "";
		$this->width     = 0;
		$this->height    = 0;
		$this->filesize  = 0;

		$fp = null;
		$fp = @fopen( $filename, "rb" );
		if ( !$fp ) {
			error_log2( "FlashImage::setImage() - error opening '$filename' for reading" );
			return false;
		}

		$this->imageData = fread( $fp, maxJPEGSize );
		if ( !$this->imageData ) {
			error_log2( "FlashImage::setImage() - error reading from '$filename'" );
			return false;
		}
		@fclose( $fp );
		
		if ( strlen( $this->imageData ) == maxJPEGSize ) {
			error_log2( "FlashImage::setImage() - error reading '$filename': file too large (increase maxJPEGSize)" );
			$this->imageData = "";
			return false;
		}
		
		$imageInfo = GetImageSize( $filename );
		if ( $imageInfo[2] != 2 ) {
			error_log2( "FlashImage::setImage() - error parsing '$filename': file is not a JPEG" );
			return false;
		}
		
		$this->filesize = strlen( $this->imageData );
		if ( !$this->filesize ) {
			error_log2( "FlashImage::setImage() - error parsing '$filename': can't determine filesize or filesize = 0" );
			return false;
		}

		$this->image  = $filename;
		$this->width  = $imageInfo[0];
		$this->height = $imageInfo[1];
		unset( $imageInfo );
		return true;
	}
	
	function createFooters() {
		$this->footer1 = "";
		$this->footer2 = "";
		$this->footer3 = "";
		
		$this->footer2 .= WriteWord( 0x02 );

		$this->footer2 .= WriteRect( getMinBits() + 1,
		                             0, ( $this->width ) * SCoord1,
		                             0, ( $this->height ) * SCoord1 );	// rect
		
		$this->footer2 .= WriteByte( 0x01 ); // FillStyleCount (1 style)
		$this->footer2 .= WriteByte( 0x41 ); // clipped bitmap fill
		$this->footer2 .= WriteWord( 1 );    // bitmap-id
		
		$this->footer2 .= WriteMatrix( true, 20 * Fixed1, 20 * Fixed1, false, 0, 0, 0, 0 );
		
		$this->footer2 .= WriteByte( 0x00 ); // LineStyleCount (no line)
		
		$this->footer2 .= WriteByte( 0x10 ); // number of fill/line index bits
		
		$this->footer2 .= WriteBits( 0, 1 ); // Non-edge record flag
		$this->footer2 .= WriteBits( 0, 1 ); // New styles flag
		$this->footer2 .= WriteBits( 0, 1 ); // Line style change flag
		$this->footer2 .= WriteBits( 1, 1 ); // Fill style 1 change flag
		$this->footer2 .= WriteBits( 0, 1 ); // Fill style 0 change flag
		$this->footer2 .= WriteBits( 1, 1 ); // Move to flag
		
		$this->footer2 .= WriteBits( getMinBits() + 1, 5 );
		$this->footer2 .= WriteBits( ( $this->width ) * SCoord1, getMinBits() + 1 );
		$this->footer2 .= WriteBits( ( $this->height ) * SCoord1, getMinBits() + 1 );
		
		$this->footer2 .= WriteBits( 1, 1 ); // Fill 1 Style = 1 (this is our bitmap-style)
		
		$this->footer2 .= WriteLine( 0, -( $this->width )  * SCoord1 );
		$this->footer2 .= WriteLine( 1, -( $this->height ) * SCoord1 );
		$this->footer2 .= WriteLine( 0,  ( $this->width )  * SCoord1 );
		$this->footer2 .= WriteLine( 1,  ( $this->height ) * SCoord1 );
		
		$this->footer2 .= WriteBits( 0, 1 ); // Non-edge record flag
		$this->footer2 .= WriteBits( 0, 5 ); // End of shape flag
		
		$this->footer2 .= FlushBits(); // flush bits to keep byte aligned
		
		// 1st footer
		
		$this->footer1 .= WriteWord( 0xbf );
		$this->footer1 .= WriteDWord( strlen( $this->footer2 ) );
		
		// 3rd footer
		
		$this->footer3 .= WriteWord( 0x0686 ); // placeObject2
		$this->footer3 .= WriteByte( 0x06 );   // body has a transform matrix and object has a character ID
		$this->footer3 .= WriteWord( 0x01 );   // depth = 1
		$this->footer3 .= WriteWord( 0x02 );   // character-id
		$this->footer3 .= WriteByte( 0x00 );   // no transformation
		
		$this->footer3 .= WriteWord( 0x40 );
		$this->footer3 .= WriteWord( 0x00 );
	}
	
	function checkImage() {
		if ( strstr( $this->imageData, pack( "n", 0xFFC2 ) ) ) {
			error_log2( "FlashImage::checkImage() - error parsing '$filename': progessive JPEGs not supported" );
			return false;
		}
		if ( strstr( $this->imageData, pack( "n", 0xFFC6 ) ) ) {
			error_log2( "FlashImage::checkImage() - error parsing '$filename': progessive JPEGs not supported" );
			return false;
		}
		if ( strstr( $this->imageData, pack( "n", 0xFFCA ) ) ) {
			error_log2( "FlashImage::checkImage() - error parsing '$filename': progessive JPEGs not supported" );
			return false;
		}
		return true;
	}
	
	function toString() {
		if ( !$this->image ) {
			error_log2( "FlashImage::toString() - error writing SWF: no image-data available" );
			return;
		}
		
		initMinBits( $this->width, $this->height );
		$this->createFooters();
		
		$swfsize  = 29;
		$swfsize += $this->filesize;
		$swfsize += strlen( $this->footer1 );
		$swfsize += strlen( $this->footer2 );
		$swfsize += strlen( $this->footer3 );
		$swfsize += strlen( WriteRect( getMinBits() + 1,
		                    0, SCoord1 * ( $this->width ),
		                    0, SCoord1 * ( $this->height ) ) );

		$swf = "FWS";                   // reversed SWF signature (little endian/big endian issue)
		$swf.= WriteByte( 5 );          // file version, flash 5 is less complicated
		$swf.= WriteDWord( $swfsize );  // length of entire file in bytes
		
		$swf.= WriteRect( getMinBits() + 1,
		                  0, SCoord1 * ( $this->width ),
		                  0, SCoord1 * ( $this->height ) ); // frame size in TWIPS
		$swf.= WriteByte( 0 );          // this one is ignored!
		$swf.= WriteByte( 12 );         // frame delay in 8.8 fixed number of frames per second
		$swf.= WriteWord( 1 );          // total number of frames in movie
		$swf.= WriteWord( 0x0243 );     // setBackgroundColor
		$swf.= WriteByte( 0xff );       // red
		$swf.= WriteByte( 0xff );       // green
		$swf.= WriteByte( 0xff );       // blue
		
		$swf.= WriteWord( 0x057f );     // DefineBitsJPEG2
		$swf.= WriteDWord( ( $this->filesize ) + 6 ); // +6, for 0xff 0xd9 0xff 0xd8 [imagedata] 0xff 0xd8
		$swf.= WriteWord( 1 );          // character-id
		
		$swf.= WriteByte( 0xff );       // SOI
		$swf.= WriteByte( 0xd9 );
		
		$swf.= WriteByte( 0xff );       // EOI
		$swf.= WriteByte( 0xd8 );
		
		$swf.= $this->imageData;        // raw image data including startImage and endImage
		
		$swf.= $this->footer1;
		$swf.= $this->footer2;
		$swf.= $this->footer3;
		
		return $swf;
	}
	
	function outputSWF() {
		header( "Content-type: application/x-shockwave-flash" );
		echo $this->toString();
	}
	
	function outputSWFDownload( $filename ) {
		$swf = $this->toString();
		header( "Content-Type: application/force-download" );
		header( "Content-disposition: attachment; filename=$filename" );
		header( "Content-Transfer-Encoding: binary" );
		header( "Content-Length: ".strlen( $swf ) );
		header( "Pragma: no-cache" );
		header( "Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0" );
		header( "Expires: 0" );
		echo $swf;
	}
	
	function saveToFile( $filename ) {
		$fp = @fopen( $filename, "wb" );
		if ( !$fp ) {
			error_log2( "FlashImage::saveToFile() - error opening '$filename' for writing" );
			return false;
		}
		
		fwrite( $fp, $this->toString() );
		@fclose( $fp );
		return true;
	}
}

/************************************ EOF ************************************/
?>
