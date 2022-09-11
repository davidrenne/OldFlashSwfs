<?php

/*****************************************************************************
 *
 *  FlashWriter Toolkit v1.02
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
 *     flashwriter.php
 *
 *  Abstract:
 *
 *     PHP function library for generating Shockwave Flash files
 *
 *  Environment:
 *
 *     Shockwave Flash / PHP
 *
 *****************************************************************************/

/*****************************************************************************
 *
 *  Constants and global variables
 *
 *****************************************************************************/

$currentByte    =  0; // the value of the current byte being created
$bytePos        =  8; // the number of bits left to fill in the current byte
$minBits        =  0; // mininum bits required to store the movies dimensions
$error_log_type = -1; // disable error-logging by default

define( "Fixed1", 0x00010000 );
define( "SCoord1", 20 );

/*****************************************************************************
*
*  @func   DWORD | error_log2 |
*
*          Send an error message somewhere. The destination is set with
*          the global variable $error_log_type. See error_log() in the
*          PHP-manual for description. Additional if this is set to -1
*          no error logging is performed.
*
*  @parm   DWORD | message |
*
*          Message to be sent.
*
*****************************************************************************/
function error_log2( $message ) {
	global $error_log_type;
	global $error_log_destination;
	
	if ( $error_log_type != -1 ) {
		return error_log( date( "[m-M-Y h:i:s] " ).$message."\n", $error_log_type, $error_log_destination );
	}
}

/*****************************************************************************
 *
 *  @func   DWORD | WriteDWord |
 *
 *          Converts a given DWORD into its binary representation.
 *
 *  @parm   DWORD | o |
 *
 *          Value to be converted
 *
 *  @rvalue binary representation
 *
 *****************************************************************************/
function WriteDWord( $o ) {
	return pack( "V", $o );
}

/*****************************************************************************
 *
 *  @func   DWORD | WriteWord |
 *
 *          Converts a given WORD into its binary representation.
 *
 *  @parm   WORD | o |
 *
 *          Value to be converted
 *
 *  @rvalue binary representation
 *
 *****************************************************************************/
function WriteWord( $o ) {
	return pack( "v", $o );
}

/*****************************************************************************
 *
 *  @func   BYTE | WriteByte |
 *
 *          Converts a given BYTE into its binary representation.
 *
 *  @parm   BYTE | o |
 *
 *          Value to be converted
 *
 *  @rvalue binary representation
 *
 *****************************************************************************/
function WriteByte( $o ) {
	return pack( "C", $o );
}

/*****************************************************************************
 *
 *  @func   BYTE | WriteBits |
 *
 *          Adds 'size' bits from 'data' to the stream until all 'size' bits
 *          have been output.
 *          Currently a maximum of 31 bits is supported only. For adding
 *          32 bits split it up into two 16-bit shunks of data.
 *
 *  @parm   U32 | data |
 *
 *          Data to be appended to the stream
 *
 *  @parm   INT | size |
 *
 *          indicates how many of the 32 bits are significant and
 *          should be output
 *
 *  @rvalue returns the actual byte
 *
 *****************************************************************************/
function WriteBits( $data, $size ) {
	global $bytePos;
	global $currentByte;
	$ret = "";

	if ( $data < 0 ) {
		$data *= -1;
		$data = ( 0x7FFFFFFF >> ( 31 - $size ) ) - $data;
		$data += 1;
	}

	while ( $size != 0 ) {
		if ( $size > $bytePos ) {
			$currentByte |= $data << (30 - $size) >> (30 - $bytePos);
			$ret .= WriteByte( $currentByte );
			$size -= $bytePos;
			$currentByte = 0;
			$bytePos = 8;
		}
		else if ( $size <= $bytePos ) {
			$currentByte |= $data << (30 - $size) >> (30 - $bytePos);
			$bytePos -= $size;
			$size = 0;
			if ( !$bytePos ) {
				$ret .= WriteByte( $currentByte );
				$currentByte = 0;
				$bytePos = 8;
			}
		}
	}
	return $ret;
}

/*****************************************************************************
 *
 *  @func   BYTE | FlushBits |
 *
 *          Kick out the current partially filled byte to the stream.
 *          If there is a byte currently being built for addition to
 *          the stream, then the end of that byte is filled with zeroes
 *          and the byte is added to the stream.
 *
 *  @rvalue returns the actual byte
 *
 *****************************************************************************/
function FlushBits() {
	global $bytePos;
	global $currentByte;
	$ret = "";

	if ( $bytePos != 8 ) {
		$ret = WriteByte( $currentByte );
		$currentByte = 0;
		$bytePos = 8;
	}
	return $ret;
}

/*****************************************************************************
 *
 *  @func   BYTE | WriteRect |
 *
 *          Writes a rectangle to the stream.
 *
 *  @parm   int | nBits |
 *
 *          Number of Bits needed to store the rect
 *
 *  @parm   int | xmin |
 *
 *          X-value for the upper left corner of rectangle
 *
 *  @parm   int | xmax |
 *
 *          X-value for the lower right corner of rectangle
 *
 *  @parm   int | ymin |
 *
 *          Y-value for the upper left corner of rectangle
 *
 *  @parm   int | ymax |
 *
 *          Y-value for the lower right corner of rectangle
 *
 *  @rvalue returns the actual byte
 *
 *****************************************************************************/
function WriteRect( $nBits, $xmin, $xmax, $ymin, $ymax ) {
	$ret = "";
	$ret .= WriteBits( $nBits, 5 );
	$ret .= WriteBits( $xmin, $nBits );
	$ret .= WriteBits( $xmax, $nBits );
	$ret .= WriteBits( $ymin, $nBits );
	$ret .= WriteBits( $ymax, $nBits );
	$ret .= FlushBits();
	return $ret;
}

/*****************************************************************************
 *
 *  @func   BYTE | WriteMatrix |
 *
 *          Writes a matrix to the stream.
 *
 *  @parm   boolean | hasScale |
 *
 *          Flag determining whether this matrix has scale values
 *
 *  @parm   int | scaleX |
 *
 *          X-scale for the matrix
 *
 *  @parm   int | scaleY |
 *
 *          Y-scale for the matrix
 *
 *  @parm   boolean | hasRotate |
 *
 *          Flag determining whether this matrix has rotation values
 *
 *  @parm   int | rotateSkew0 |
 *
 *          Horizontal skew for the matrix or degree of rotation if
 *          equal to rotateSkew1
 *
 *  @parm   int | rotateSkew1 |
 *
 *          Vertical skew for the matrix or degree of rotation if
 *          equal to rotateSkew0
 *
 *  @parm   int | translateX |
 *
 *          Horizontal translation for the matrix
 *
 *  @parm   int | translateY |
 *
 *          Vertical translation for the matrix
 *
 *  @rvalue returns the actual byte
 *
 *****************************************************************************/
function WriteMatrix( $hasScale, $scaleX, $scaleY,
                      $hasRotate, $rotateSkew0, $rotateSkew1,
                      $translateX, $translateY ) {
		$nScaleBits = 22;
		$nRotateBits = 0;
		$nTranslateBits = 0;
		$ret = "";

		$ret .= WriteBits( $hasScale, 1 );
		if ( $hasScale ) {
			$ret .= WriteBits( $nScaleBits, 5);
			$ret .= WriteBits( $scaleX, $nScaleBits );
			$ret .= WriteBits( $scaleY, $nScaleBits );
		}
		$ret .= WriteBits( $hasRotate, 1 );
		if ( $hasRotate ) {
			$ret .= WriteBits( $nRotateBits, 5 );
			$ret .= WriteBits( $rotateSkew0, $nRotateBits );
			$ret .= WriteBits( $rotateSkew1, $nRotateBits );
		}
		$ret .= WriteBits( $nTranslateBits, 5 );
		$ret .= WriteBits( $translateX, $nTranslateBits);
		$ret .= WriteBits( $translateY, $nTranslateBits);
		$ret .= FlushBits();
		return $ret;
}

/*****************************************************************************
 *
 *  @func   BYTE | WriteLine |
 *
 *          Writes a line to the stream.
 *
 *  @parm   boolean | hv|
 *
 *          Flag determining whether this line is
 *          0 = horizontal or 1 = vertical
 *
 *  @parm   int | delta |
 *
 *          Length of line
 *
 *  @rvalue returns the actual byte
 *
 *****************************************************************************/
function WriteLine( $hv, $delta ) {
	$ret = "";
	$ret .= WriteBits( 1, 1 );                // edge-record
	$ret .= WriteBits( 1, 1 );                // straight
	$ret .= WriteBits( getMinBits() - 1, 4 );    // nBits
	$ret .= WriteBits( 0, 1 );                // Vert/Horz
	$ret .= WriteBits( $hv, 1 );              // vertical
	$ret .= WriteBits( $delta, getMinBits() + 1 ); // DeltaX
	return $ret;
}

/*****************************************************************************
 *
 *  @func   BYTE | initMinBits |
 *
 *          Calculates the mininum of bits required to store the
 *          variables width and height and stores result in globa
 *          variable minBits.
 *
 *  @rvalue returns the mininum of bits required
 *
 *****************************************************************************/
function initMinBits( $width, $height ) {
	global $minBits;
	$max = max( $width * SCoord1, $height * SCoord1 );
	if ( !$max )
		return 0;
	$x = 1;
	for( $i = 1; $i < 32; $i++ ) {
		$x <<= 1;
		if ( $x > $max )
			break;
	}
	$minBits = $i;
}

/*****************************************************************************
*
*  @func   BYTE | getMinBits |
*
*          Returns the global variable minBits.
*
*  @rvalue returns minBits
*
*****************************************************************************/
function getMinBits() {
	global $minBits;
	return $minBits;
}

/************************************ EOF ************************************/
?>
