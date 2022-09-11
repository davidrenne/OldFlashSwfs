<?php
require_once('/vol/www/mensec/web-docs/Connections/mySQL.php');
require_once("/vol/www/mensec/web-docs/cms/flash/xmlclass.php");
require_once("/vol/www/mensec/web-docs/cms/flash/gif.php");
$WEBMASTER_MAIL='info@2question.com';
$VERSION=1.3; // see clip.as for version in flash actionscript. must match
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");              
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");   
header("Cache-Control: no-cache, must-revalidate");           // HTTP/1.1  
header("Pragma: no-cache");                                   // HTTP/1.0
// ------------------------------------------------------------------
function sendmail ($from, $to, $cc, $bcc, $subject, $message) {
        $header="From: $from\n";
        if ($cc !='') $header.="Cc: $cc\n";
        if ($bcc !='') $header.="Bcc: $bcc\n";
        $header.="X-Mailer: http://www.2question.com\n";
        $header.="MIME-Version: 1.0\n";
        $header.="Content-type: text/html; charset=iso-8859-1\n";
        mail($to,$subject,$message,$header);
}
// ------------------------------------------------------------------
function report_sql_error($filename, $id, $sql_string, $err_message) {
	global $WEBMASTER_MAIL;
	
	$subject='ALERT: error execution of PHP script';
	$message="<h3>Error in SQL Statement</h3>
<table>
<tr><td valign=\"top\"><b>filename</b></td><td>$filename</td></tr>	
<tr><td valign=\"top\"><b>id</b></td><td>$id</td></tr>	
<tr><td valign=\"top\"><b>sql string / function</b></td><td><pre>$sql_string</pre></td></tr>	
<tr><td valign=\"top\"><b>error message</b></td><td>$err_message</td></tr>
</table>
<hr>
<hr>
<table>";
	foreach ($_SERVER as $k=>$v) {$message.="<tr><td>$k</td><td>$v</td></tr>\n";}
	foreach ($_REQUEST as $k=>$v) {$message.="<tr><td>$k</td><td>$v</td></tr>\n";}
	foreach ($_COOKIE as $k=>$v) {$message.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$message.='</table>';
	
	sendmail('flash@2question.com', $WEBMASTER_MAIL, '','',$subject, $message);
	
//	echo "<hr>$message<hr>";
	exit;

}
// ------------------------------------------------------------------
function loggingMail() {
	$FROM='theo@oracle.2question.com';
	$return_string="<table>\n";
	$return_string.="<tr><td colspan=\"2\"><b>REQUEST</b></td></tr>\n";
	if ($_REQUEST !='') foreach($_REQUEST as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="<tr><td colspan=\"2\"><br><b>SERVER</b></td></tr>\n";
	if ($_SERVER !='')  foreach($_SERVER as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="<tr><td colspan=\"2\"><br><b>COOKIES</b></td></tr>\n";
	if ($_COOKIE !='') foreach($_COOKIE as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="</table>\n";
	sendmail($FROM, $FROM, '', '', 'RSS feed requested from '.$_SERVER['REMOTE_ADDR'].' / '.gethostbyaddr($_SERVER['REMOTE_ADDR']), $return_string);
}
// ------------------------------------------------------------------
function getmicrotime() 
{ 
   list($usec, $sec) = explode(" ", microtime()); 
   return ((float)$usec + (float)$sec); 
}
// ------------------------------------------------------------------
function log_flash_page_visit () {
	$page=$_REQUEST['page'];
	$frame=$_REQUEST['frame'];
	$movie=$_REQUEST['application'];
	$version=$_REQUEST['version'];
	$remote_addr=$_SERVER['REMOTE_ADDR'];
	$thisMovie=$movie.' ('.$version.')';
	$thisPage=$page.' ('.$frame.')';
	$remote_addr=$_SERVER['REMOTE_ADDR'];
	$remote_host=gethostbyaddr($remote_addr);
	$sql_string="select id_pk, times_visited from q_logins where remote_addr='$remote_addr' and movie='$thisMovie' and page='$thisPage'";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '200406701:36', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$id_pk=0+$row_recset['id_pk'];
	$times_visited=0+$row_recset['times_visited'];
	if($id_pk==0) {
		$sql_string="insert into q_logins (remote_addr, remote_host, movie, page, insert_date, last_visit, times_visited) values 
		('$remote_addr', '$remote_host', '$thisMovie', '$thisPage', now(), now(), 1)";
	} else {
		$times_visited+=1;
		$sql_string="update q_logins set last_visit=now(), times_visited=$times_visited where id_pk=$id_pk";
	}
	if ($remote_host != '212-214.mxp.dsl.internl.net') 
		$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004053012:29', $sql_string, mysql_error()).'');	
	
}
// ------------------------------------------------------------------
function logUsage() {
	global $WEBMASTER_MAIL;
	$application=$_REQUEST['application'];
	$version=$_REQUEST['version'];
	$ipnrs=$_REQUEST['ipnrs'];
	$FROM="$application.$version.flash@oracle.2question.com";
	$ip=$_SERVER['REMOTE_ADDR'];
	
	log_flash_page_visit();	
	
	$return_string="IP numbers: $ipnrs<br>
application: $application / $version<br><br>";
	$return_string.="<table>\n";
	$return_string.="<tr><td colspan=\"2\"><b>REQUEST</b></td></tr>\n";
	if ($_REQUEST !='') foreach($_REQUEST as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="<tr><td colspan=\"2\"><br><b>SERVER</b></td></tr>\n";
	if ($_SERVER !='')  foreach($_SERVER as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="<tr><td colspan=\"2\"><br><b>COOKIES</b></td></tr>\n";
	if ($_COOKIE !='') foreach($_COOKIE as $k=>$v) {$return_string.="<tr><td>$k</td><td>$v</td></tr>\n";}
	$return_string.="</table>\n";
	sendmail($FROM, $WEBMASTER_MAIL, '', '', 'RSS usage log from '.$_SERVER['REMOTE_ADDR'].' / '.gethostbyaddr($_SERVER['REMOTE_ADDR']), $return_string);
	return "&trace=mail send to $WEBMASTER_MAIL";
}
// ------------------------------------------------------------------
function getChannels() {
	global $version;
	$n=0;
	$version=0+$_REQUEST['version'];
// RSS feed for this user
	$user_fk=0+$_COOKIE['RSSID'];
	$sql_string="select id_pk, channel_fk from rss_users_and_channels where user_fk=$user_fk and user_fk<>0";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '200406202:20', $sql_string, mysql_error()).'');
	do {
		$id_pk=0+$row_recset['id_pk'];
		if ($id_pk>0) {
			$channel_fk=$row_recset['channel_fk'];
			$in_string.=",$channel_fk";
		}
	} while ($row_recset = mysql_fetch_assoc($recset)); 
	$in_string=preg_replace("/^,/","", $in_string);
	if ($in_string!='') $where_string=" where id_pk in ($in_string)  and is_active='checked' "; 
	else $where_string=" where is_default='Y' and is_active='checked' ";
//	GET ABOUT --- id_pk=14
	$sql_string="select id_pk, title from rss_channels where id_pk=14";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004060112:46', $sql_string, mysql_error()).'');
	do {
		$id_pk=0+$row_recset['id_pk'];
		if($id_pk>0) {
			$n++;
			$title=$row_recset['title'];
			if ($version==0) {
				$retVal.="&channel$n=$title";
			} else if ($version==2) {
				$retVal.="&channel$n=<a href=\"asfunction:getFeed,$title\">$title</a>";
				$stringLength+=strlen($title);
				$plainStr.="&plain$n=$title";
			}
		}
	} while ($row_recset = mysql_fetch_assoc($recset)); 


	
//	Get other channels
	$sql_string="select id_pk, title from rss_channels $where_string order by title";

	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004060112:46', $sql_string, mysql_error()).'');
	do {
		$id_pk=0+$row_recset['id_pk'];
		if($id_pk>0) {
			$n++;
			$title=$row_recset['title'];
			if ($version==0) {
				$retVal.="&channel$n=$title";
			} else if ($version==2) {
				$retVal.="&channel$n=<a href=\"asfunction:getFeed,$title\">$title</a>";
				$stringLength+=strlen($title);
				$plainStr.="&plain$n=$title";
			}
		}
	} while ($row_recset = mysql_fetch_assoc($recset)); 
	$retVal.='&channels='.$n;
	$retVal.='&strLength='.$stringLength;
	$retVal.='&plainStr='.$plainStr;
	$retVal.='&version=$VERSION&updateVersionText='.urlencode("<b>A new version is available.</b><br>Please go to <a href=\"asfunction:getURL,http://oracle.2question.com/rss?ref=flash\">oracle.2question.com/rss</a><br>");
	return $retVal;
}
// -------------------------------------------------------------
function http_build_query1($array) {
	foreach($array as $k=>$v) {
		$string.="&$k=$v";
	}
	return $string;
}
// -------------------------------------------------------------
function GetURL($url, $send_header, &$ret_header, $query = array(), $method = "GET")
{
   $header = ''; // guarda os cabecalhos da resposta
   $body  = '';  // guarda o corpo da resposta
   $buffer = ''; // buffer de leitura do socket

   $ret_header = array();

   $url_stuff = parse_url($url);

   if (!isset($url_stuff["path"]))
       $url_stuff["path"] = "/";

   if (isset($url_stuff["query"]))
       $_query = http_build_query1($url_stuff["query"]);

   if (sizeof($query))
       $_query = http_build_query1($query);

   $fp = fsockopen ($url_stuff['host'], 80, $errno, $errstr, 30);

   if ($fp) {
       if ($method == "POST") {
           $header  = "$method $url_stuff[path] HTTP/1.1\r\n";
           $header .= "Content-length: " . strlen($_query) . "\r\n";
           $header .= "Content-type: application/x-www-form-urlencoded\r\n";
       } else {
           // montar os cabeçalhos de envio
           if (isset($url_stuff['query']))
               $header  = "$method $url_stuff[path]?$url_stuff[query] HTTP/1.1\r\n";
           else
               $header  = "$method $url_stuff[path] HTTP/1.1\r\n";
       }

       $header .= "Host: $url_stuff[host]\r\n";
//       echo "<hr>$send_header<hr>";
       foreach ($send_header as $hname => $hvalue)
           $header .= "$hname: $hvalue\r\n";
       $header .= "\r\n";

       // enviar os cabecalhos
       fputs($fp, $header);
       if ($method == "POST")
           fputs($fp, $_query);

       // ler a resposta (cabecalhos + corpo)
       while (!feof($fp))
           $buffer .= fgets($fp, 4096);

       // separar cabecalhos do corpo ( [cabechalho]\r\n\r\n[corpo] )
       $ret = strpos($buffer, "\r\n\r\n", 0);
       if ($ret == false) {
           fclose($fp);
           return -1;
       }

       $header = substr($buffer, 0, $ret); // cabecalho da respota
       $body  = substr($buffer, $ret + 4); // corpo da resposta

       $header = str_replace("\r\n" , "\n", $header);
       $array_h = explode("\n", $header);

       foreach ($array_h as $line => $val) {
           if (strpos($val, "HTTP/1") !== 0) {
               $h = explode(":", $val);
               $v = $h;
               $h = $h[0];
               array_shift($v); // shift left
               $v = implode(":", $v); // reconstruct value
               $ret_header[$h] = $v;

               // save cookies
               if (strtolower($h) === "set-cookie")
                   $send_header['Cookie'] = $v;

           } else {
               $ret_header['HTTP'] = $val;
               $ret_header['HTTP_VERSION'] = substr($val, 5, 3);
               $ret_header['HTTP_RETURN'] = substr($val, 9, 3);
               $ret_header['HTTP_MESSAGE'] = substr($val, 12);
           }
       }

       // Se o cabecalho possuir um campo "Location", segui-lo...
       if (isset($ret_header['Location'])) {
           $body = GetURL($ret_header['Location'], $send_header, $ret_header);
       }
       fclose ($fp);
   }

   return $body;
}
// ------------------------------------------------------------------
function test() {
//echo "TEST REDIRECT\n\n";
$url = "http://google.com"; // redirect to www.google.com
$body = GetURL($url, $send_header, $ret_header);

//echo '$ret_reader: ';
print_r($ret_header);

//echo "\nBody\n=================\n";
//echo $body;
}
// ------------------------------------------------------------------
function retrieveBBCWeatherProperty($sql_property, $line, $n_start, $n_stop) {
	$day=1;
	$n=0;
//	if ($sql_property=='sunrise') {
		preg_match_all("|<td[^>]*>(.*?)<\/td>|", $line,  $cell1);
		foreach($cell1[1] as $k=>$v) {
			preg_match_all("|<strong[^>]*>(.*?)<\/strong>|", $v, $val);
			list($k1, $v1)=each($val[1]);
			if ($n>=$n_start && $n<=$n_stop) {
				if ($v1=='Northerly Wind') {
					$v1='N';
				} else if ($v1=='North Westerly Wind') {
					$v1='NW';
				} else if ($v1=='Westerly Wind') {
					$v1='W';
				} else if ($v1=='South Westerly Wind') {
					$v1='SW';
				} else if ($v1=='Southerly Wind') {
					$v1='S';
				} else if ($v1=='South Easterly Wind') {
					$v1='SE';
				} else if ($v1=='Easterly Wind') {
					$v1='E';
				} else if ($v1=='North Easterly Wind') {
					$v1='NE';
				}
				$update_string.=', '.$sql_property."_$day='$v1' ";
				$day+=1;
			}
			$n++;
		}
//	}
	return $update_string;

	
}
// ------------------------------------------------------------------
function retrieveWeatherFromBBC($id_pk) {
	$id_pk+=0;
	$sql_string="select url from rss_weather_locations where id_pk=$id_pk";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040712:46', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$url=$row_recset['url'];
	if ($url=='') {
		$url='http://www.bbc.co.uk/weather/5day.shtml?world='.$id_pk;
	}

	$parsedURL=parse_url($url);
	$scheme=$parsedURL['scheme'];
	$host=$parsedURL['host'];
	$user=$parsedURL['user'];
	$pass=$parsedURL['pass'];
	$path=$parsedURL['path'];
	$query=$parsedURL['query'];
	$fragment=$parsedURL['fragment'];

	// retrieve url
	$agent=$_SERVER['HTTP_USER_AGENT'].';';
	ini_set('user_agent','MSIE 4\.0b2;'); 
	ini_set('user_agent',$agent); 
	ini_set("safe_mode","0");
	$dh = fopen($url,'r'); 
	$result = fread($dh,99999);           
	$result=preg_replace("/\r|\n/", "", $result);
	// based on specific layout. if changes, stop parsing
	if (!preg_match("/<!-- page layout templates v2.6 -->/", $result)) {
		sendmail('rss_and_flash.php@oracle.2question.com', 'info@2question.com', '', '',  'Weather layout of BBC changed for '.$url, $result);
		exit;
	}

	 
	list($void1,$target1)=explode("<!-- using world weather id -->", $result);
	list($void2,$target2)=explode("<!--end start spacing for netscape-->", $target1);
	list($target3,$void3)=explode("Current Nearest",$target2);
	$rows=explode("<tr",$target3);

	$n=1;
	// row 1: city, country
	preg_match_all("|<td[^>]*>(.*?)<\/td>|", $rows[1],  $cell1);
	foreach($cell1[1] as $k=>$v) {
		if ($n==2) {
			list($city, $country)=explode(",", $v);
			$country=trim(strip_tags($country));
			$city=trim(strip_tags($city));
			$sql_string="select id_pk from rss_weather_locations where country='$country' and city='$city'";
			$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040714:29', $sql_string, mysql_error()).'');
			$row_recset=mysql_fetch_assoc($recset);
			$location_fk=0+$row_recset['id_pk'];
			if ($location_fk==0) {
				$sql_string="insert into rss_weather_locations (city, country, url) values ('$city', '$country', 'http://www.bbc.co.uk/weather/5day.shtml?world=$id_pk')";				
				$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040713:31', $sql_string, mysql_error()).'');
				$location_fk=mysql_insert_id();
echo "Creating 	location $location_fk: $city, $country<br>\n";


			}
		}
		$n+=1;
	}
	
	$day=1;
	// row 2: weather icons
	preg_match_all("|<td[^>]*>(.*?)<\/td>|", $rows[2],  $cell1);
	foreach($cell1[1] as $k=>$v) {
		preg_match_all("|alt=\"([^\"]*)\"|", $v, $alt);
		list($k1, $v1)=each($alt[1]);
		$update_string.=", impression_$day='$v1' ";
		$day+=1;
	}
	// row 3: max temp
	$day=1;
	$n=0;
	preg_match_all("|<td[^>]*>(.*?)<\/td>|", $rows[3],  $cell1);
	foreach($cell1[1] as $k=>$v) {
		preg_match_all("|alt=\"([^\"]*)\"|", $v, $alt);
		list($k1, $v1)=each($alt[1]);
		if ($n>=2) {
			$update_string.=", max_temp_$day='$v1' ";
			$day+=1;
		}
		$n++;
	}
	// row 4: min temp
	$day=1;
	$n=0;
	preg_match_all("|<td[^>]*>(.*?)<\/td>|", $rows[4],  $cell1);
	foreach($cell1[1] as $k=>$v) {
		preg_match_all("|alt=\"([^\"]*)\"|", $v, $alt);
		list($k1, $v1)=each($alt[1]);
		if ($n>=2) {
			$update_string.=", min_temp_$day='$v1' ";
			$day+=1;
		}
		$n++;
	}
	// row 5: wind direction
	$day=1;
	$n=0;
	preg_match_all("|<td[^>]*>(.*?)<\/td>|", $rows[5],  $cell1);
	foreach($cell1[1] as $k=>$v) {
		preg_match_all("|alt=\"([^\"]*)\"|", $v, $alt);
		list($k1, $v10)=each($alt[1]);
		preg_match_all("|<strong[^>]*>(.*?)<\/strong>|", $v, $speed);
		list($k1, $v12)=each($speed[1]);
		if ($n>=2) {
			$update_string.=", wind_direction_$day='$v10', wind_speed_$day='$v12' ";
			$day+=1;
		}
		$n++;
	}
	
	for($rownum=6; $rownum<count($rows); $rownum++) {
		if (preg_match("/Sunrise/", $rows[$rownum])) {
			$update_string.=retrieveBBCWeatherProperty('sunrise',$rows[$rownum], 2, 5);
		} else if (preg_match("/Sunset/", $rows[$rownum])) {
			$update_string.=retrieveBBCWeatherProperty('sunset',$rows[$rownum], 2, 5);
		} else if (preg_match("/Pressure/", $rows[$rownum])) {
			$update_string.=retrieveBBCWeatherProperty('pressure',$rows[$rownum], 2, 5);
		} else if (preg_match("/Humidity/", $rows[$rownum])) {
			$update_string.=retrieveBBCWeatherProperty('humidity',$rows[$rownum], 2, 5);
		} else if (preg_match("/Visibility/", $rows[$rownum])) {
			$update_string.=retrieveBBCWeatherProperty('visibility',$rows[$rownum], 2, 5);
		}
	}
	
	$update_string=preg_replace("/^, /", "", $update_string);
	$update_string.=", creation_date=now()";

	//			$location_fk
	$sql_string="select id_pk from rss_weather_reports where location_fk=$location_fk and location_fk<>0";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040712:46', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$id_pk=0+$row_recset['id_pk'];
	//			$location_fk
	$sql_string="select id_pk from rss_weather_reports where location_fk=$location_fk and location_fk<>0";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040712:46', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$id_pk=0+$row_recset['id_pk'];
	
	if ($id_pk==0) {
		$sql_string="insert into rss_weather_reports (location_fk) values ($location_fk)";
		$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040715:30', $sql_string, mysql_error()).'');
		$id_pk=mysql_insert_id();
echo "Creating weather report: $id_pk, $sql_string<br>\n";		
	}
		
	$sql_string="update rss_weather_reports set $update_string where id_pk=$id_pk";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '20040712:44', $sql_string, mysql_error()).'');
		
}
// ------------------------------------------------------------------
function updateWeather() {
	$n=7309;
	do {
		$url="http://www.bbc.co.uk/weather/5day.shtml?id=$n";
		echo "<hr><b>$url</b><br>\n";
		retrieveWeatherFromBBC($n);
		$n++;
	} while ($n<10000);
	
	
	
}
// ------------------------------------------------------------------
function getWeather() {
	$city='Amsterdam';
	$country='Netherlands';
	
	$sql_string="select id_pk, url from rss_weather_locations where city='$city' and country='$country'";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004071120:05', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$location_fk=0+$row_recset['id_pk'];
	retrieveWeatherFromBBC($location_fk);
	$url=$row_recset['url'];
	$sql_string="select impression_1, max_temp_1, min_temp_1, wind_direction_1, wind_speed_1, sunrise_1, sunset_1, pressure_1, visibility_1, humidity_1, impression_2, max_temp_2, min_temp_2, wind_direction_2, wind_speed_2, sunrise_2, sunset_2, pressure_2, visibility_2, humidity_2, impression_3, max_temp_3, min_temp_3, wind_direction_3, wind_speed_3, sunrise_3, sunset_3, pressure_3, visibility_3, humidity_3, impression_4, max_temp_4, min_temp_4, wind_direction_4, wind_speed_4, sunrise_4, sunset_4, pressure_4, visibility_4, humidity_4, impression_5, max_temp_5, min_temp_5, wind_direction_5, wind_speed_5, sunrise_5, sunset_5, pressure_5, visibility_5, humidity_5, creation_date
	from rss_weather_reports where location_fk=$location_fk";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004071120:05', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$humidity_1 = $row_recset['humidity_1'];
	$humidity_2 = $row_recset['humidity_2'];
	$humidity_3 = $row_recset['humidity_3'];
	$humidity_4 = $row_recset['humidity_4'];
	$humidity_5 = $row_recset['humidity_5'];	
	$impression_1 = urlencode("http://www.keizerkarelpodia.nl/test/weather_icons/".str_replace(" ", "_", $row_recset['impression_1']).'.swf');
	$impression_2 = urlencode("http://www.keizerkarelpodia.nl/test/weather_icons/".str_replace(" ", "_", $row_recset['impression_2']).'.swf');
	$impression_3 = urlencode("http://www.keizerkarelpodia.nl/test/weather_icons/".str_replace(" ", "_", $row_recset['impression_3']).'.swf');
	$impression_4 = urlencode("http://www.keizerkarelpodia.nl/test/weather_icons/".str_replace(" ", "_", $row_recset['impression_4']).'.swf');
	$impression_5 = urlencode("http://www.keizerkarelpodia.nl/test/weather_icons/".str_replace(" ", "_", $row_recset['impression_5']).'.swf');
	$max_temp_1 = $row_recset['max_temp_1'];
	$max_temp_2 = $row_recset['max_temp_2'];
	$max_temp_3 = $row_recset['max_temp_3'];
	$max_temp_4 = $row_recset['max_temp_4'];
	$max_temp_5 = $row_recset['max_temp_5'];
	$min_temp_1 = $row_recset['min_temp_1'];
	$min_temp_2 = $row_recset['min_temp_2'];
	$min_temp_3 = $row_recset['min_temp_3'];
	$min_temp_4 = $row_recset['min_temp_4'];
	$min_temp_5 = $row_recset['min_temp_5'];
	$pressure_1 = $row_recset['pressure_1'];
	$pressure_2 = $row_recset['pressure_2'];
	$pressure_3 = $row_recset['pressure_3'];
	$pressure_4 = $row_recset['pressure_4'];
	$pressure_5 = $row_recset['pressure_5'];
	$sunrise_1 = $row_recset['sunrise_1'];
	$sunrise_2 = $row_recset['sunrise_2'];
	$sunrise_3 = $row_recset['sunrise_3'];
	$sunrise_4 = $row_recset['sunrise_4'];
	$sunrise_5 = $row_recset['sunrise_5'];
	$sunset_1 = $row_recset['sunset_1'];
	$sunset_2 = $row_recset['sunset_2'];
	$sunset_3 = $row_recset['sunset_3'];
	$sunset_4 = $row_recset['sunset_4'];
	$sunset_5 = $row_recset['sunset_5'];
	$visibility_1 = $row_recset['visibility_1'];
	$visibility_2 = $row_recset['visibility_2'];
	$visibility_3 = $row_recset['visibility_3'];
	$visibility_4 = $row_recset['visibility_4'];
	$visibility_5 = $row_recset['visibility_5'];
	$wind_direction_1 = $row_recset['wind_direction_1'];
	$wind_direction_2 = $row_recset['wind_direction_2'];
	$wind_direction_3 = $row_recset['wind_direction_3'];
	$wind_direction_4 = $row_recset['wind_direction_4'];
	$wind_direction_5 = $row_recset['wind_direction_5'];
	$wind_speed_1 = $row_recset['wind_speed_1'];
	$wind_speed_2 = $row_recset['wind_speed_2'];
	$wind_speed_3 = $row_recset['wind_speed_3'];
	$wind_speed_4 = $row_recset['wind_speed_4'];
	$wind_speed_5 = $row_recset['wind_speed_5'];
	$creation_date = $row_recset['creation_date'];
	
	$retVal="&impression_1=$impression_1&max_temp_1=$max_temp_1&min_temp_1=$min_temp_1&wind_direction_1=$wind_direction_1&wind_speed_1=$wind_speed_1&sunrise_1=$sunrise_1&sunset_1=$sunset_1&pressure_1=$pressure_1&visibility_1=$visibility_1&humidity_1=$humidity_1&impression_2=$impression_2&max_temp_2=$max_temp_2&min_temp_2=$min_temp_2&wind_direction_2=$wind_direction_2&wind_speed_2=$wind_speed_2&sunrise_2=$sunrise_2&sunset_2=$sunset_2&pressure_2=$pressure_2&visibility_2=$visibility_2&humidity_2=$humidity_2&impression_3=$impression_3&max_temp_3=$max_temp_3&min_temp_3=$min_temp_3&wind_direction_3=$wind_direction_3&wind_speed_3=$wind_speed_3&sunrise_3=$sunrise_3&sunset_3=$sunset_3&pressure_3=$pressure_3&visibility_3=$visibility_3&humidity_3=$humidity_3&impression_4=$impression_4&max_temp_4=$max_temp_4&min_temp_4=$min_temp_4&wind_direction_4=$wind_direction_4&wind_speed_4=$wind_speed_4&sunrise_4=$sunrise_4&sunset_4=$sunset_4&pressure_4=$pressure_4&visibility_4=$visibility_4&humidity_4=$humidity_4&impression_5=$impression_5&max_temp_5=$max_temp_5&min_temp_5=$min_temp_5&wind_direction_5=$wind_direction_5&wind_speed_5=$wind_speed_5&sunrise_5=$sunrise_5&sunset_5=$sunset_5&pressure_5=$pressure_5&visibility_5=$visibility_5&humidity_5=$humidity_5";
	$retVal.="&weatherURL=".urlencode("<a href=\"$url\" target=\"_blank\">BBC World Weather&nbsp;&nbsp;&nbsp;&nbsp;updated: $creation_date</a>");

	return $retVal;	
	 
}
// ------------------------------------------------------------------
function getPicture($url) 
{ 
	// think about http://www.picsearch.com for getting images
//echo "URL for images: $url<br>";	
	$parsedURL=parse_url($url);
	$scheme=$parsedURL['scheme'];
	$host=$parsedURL['host'];
	$user=$parsedURL['user'];
	$pass=$parsedURL['pass'];
	$path=$parsedURL['path'];
	$query=$parsedURL['query'];
	$fragment=$parsedURL['fragment'];

	// Fake the browser type 
	$agent=$_SERVER['HTTP_USER_AGENT'].';';
	ini_set('user_agent','MSIE 4\.0b2;'); 
//	ini_set('user_agent',$agent); 
	ini_set("safe_mode","0");
	$dh = fopen($url,'r'); 
	$result = fread($dh,99999);           
	$result=preg_replace("/\r|\n/", "", $result);
//	echo "<hr>".htmlentities($result)."<hr>"; exit;
	unset($images_found);
	unset($caption_found);
	$images_found=array();
	$caption_found=array();
	preg_match_all("|<img [^>]*[^>]*>|i", $result, $matches);	
	foreach($matches[0] as $m=>$m1) { 
//		echo htmlentities($m1)."<br>\n";
		if (!preg_match("/\.gif/", $m1) && !preg_match("/\Dad/", $m1) && !preg_match("/stat/", $m1)) {
			preg_match("/src=\"([^\"]*?)\"/i", $m1, $urls1);
			preg_match("/src='([^']*)'/i", $m1, $urls2);
//			echo '1 ::: '.htmlentities($m1).", <b>".$urls1[1]."</b><br>2 ::: ".htmlentities($m1).", <b>".$urls2[1]."</b><br>\n";
			if ($urls1[1]!='' && !preg_match("/'/", $urls1[1])) {
				array_push($images_found, $urls1[1]);
			} else if ($urls2[1]!='' && !preg_match("/\"/", $urls2[1])) {
				array_push($images_found, $urls2[1]);
			}
			// retrieve caption. supposed it is either ALT or TITLE
			unset ($urls1);
			unset ($urls2);
			$m1=preg_replace("/'/", "\"", $m1);
			preg_match("/alt=\"([^\"]*?)\"/i", $m1, $urls1);
			preg_match("/title=\"([^\"]*?)\"/i", $m1, $urls2);
			if (strlen($urls1[1]) > strlen($url2[1])) {
				$caption=$urls1[1];
			} else if (strlen($urls1[1]) < strlen($url2[1])) {
				$caption=$urls2[1];
			}
			if ($caption!='') $caption.="\n";
			$caption.="$host";
			array_push($caption_found, $caption);
//			echo "caption: $caption <br>\n";
		}
	}
	$img_url=$images_found[0];
	$caption=$caption_found[0];

	if (preg_match("/^\//",$img_url)){ // starts with /path/image
		$img_url='http://'.$host.$img_url;
	} else if (preg_match("/^\d/", $img_url)) { // starts with path/image
		$img_url='http://'.$host.$path.$img_url;
	}
//	echo "<h3>$img_url, $caption</h3>";
	
	return array($img_url, $caption); 
}
// ------------------------------------------------------------------
function getFeedTitles($title) {
	// get url belonging to title
	$sql_string="select feed_url, link, image_url from rss_channels where title='$title'";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004060115:21', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$url=$row_recset['feed_url'];
	$link=$row_recset['link'];
	$image_url=$row_recset['link'];
	// retrieve image	
	list($image, $caption)=getPicture($link);
	// retrieve url
	$lines=@file($url);
//	if (preg_match("/2question/", $url)) {
		loggingMail();
//	}
	foreach($lines as $k=>$v) {$data.=$v;}
	$initPos = strpos($data, "<channel>"); //avoid the DTD declaration, non validating parse. Begin directly with channel
	
	$data = stripslashes(substr($data, $initPos));
	if ($data=='') return "content=Feed could not be retrieved from url $url";
	
	$xml_parser = new xml();
	$root_node = $xml_parser->parse($data);
	$channel    = array_shift($root_node["_ELEMENTS"]);
	//Now we select some elements we want, discarding others (See rss specs 0.91, 0.92 and 2.0)
	////// WHO title, description and link /////////////////////////////////////////////////////////
	foreach ($channel["_ELEMENTS"] as $item){
		// channel logo
		if($item[_NAME]=="image") {
			foreach($item["_ELEMENTS"] as $tag) {
				if ($_REQUEST['_debug']==1) {
					echo "$tag[_NAME], $tag[_DATA] <br>\n"; 
				}
				if ($tag["_NAME"]=="url") {
					$base_image="<img src=\"".$tag[_DATA]."\">";
//					$base_image="<img src=\"http://images.slashdot.org/topics/topicslashdot.gif\">";
					
				}
			}
		}
		if($item[_NAME]=="title") $base_name=urlencode($item[_DATA]);
		if($item[_NAME]=="link") $base_uri=urlencode($item[_DATA]);
		if($item[_NAME]=="description") $base_desc=urlencode($item[_DATA]);
	}

//	$base = "<rss_intro><b>Web:%20</b><a href=\"$base_uri\"><font color=\"#0000ff\"><u>$base_name</u></font></a><br>$base_desc</rss_intro><br><br><br>";

//	$string.="&content=$base";
	////////// ITEMS --> items, description and link ////////////////////////////////////////////////////////
	foreach ($channel["_ELEMENTS"] as $item){ 
		if($item[_NAME]=="item") {
			//stripslashes is needed since providers give links inside texts or titles		
			foreach ($item["_ELEMENTS"] as $tag){
				 if($tag["_NAME"]=="title") $news_title=urlencode($tag[_DATA]);
				 if($tag["_NAME"]=="link") {
				 	$news_uri=urlencode($tag[_DATA]);
				 	$read_more="<a href=\"$news_uri\" target=\"_new\"><font color=\"#999999\"><u>read more...</u></font></a><br>";
				}
	 			 if($tag["_NAME"]=="description") $news_desc=urlencode($tag[_DATA]);
			}
			$news .= "<RSS_TITLE>$news_title";
		}
	}
	$string.='&content='.$news;
	$string.='&image='.$image;
	$string.='&caption='.urlencode($caption);
	$string = stripslashes($string);
	return $string;
}
// ------------------------------------------------------------------
function allFeedTitles() {
	$version=0+$_REQUEST['version'];
	$sql_string="select id_pk, title from rss_channels order by title";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004060112:46', $sql_string, mysql_error()).'');
	do {
		$id_pk=0+$row_recset['id_pk'];
		if($id_pk>0) {
			$n++;
			$title=$row_recset['title'];
			$retVal.="&channel$n=<a href=\"asfunction:getFeed,$title\">$title</a>";
			$feedTitles=getFeedTitles($title);
			$feedTitlesArray=explode("<RSS_TITLE>", $feedTitles);
			$i=0;
			foreach($feedTitlesArray as $rss_title) {
				$content[$n][$i]=$rss_title;
				$i++;
			}
		}
	} while ($row_recset = mysql_fetch_assoc($recset)); 
	foreach($content as $k=>$v) {
		foreach($v as $k1=>$v1) {
			if ($i>0) {
				$content_titles.='&t['.$k.']['.$k1.']='.$v1;
			}
		}
			$ttf.="&ttf$k=$k1"; // titles per feed
	}
//echo $ttf."<hr>";
	
	$retVal.=$content_titles;
	$retVal.='t[1][1]=12';
	$retVal.='&channels='.$n;
	$retVal.='&strLength='.$stringLength;
	$retVal.='&plainStr='.$plainStr;
	return $retVal;
	
}
// ------------------------------------------------------------------
function png2jpg($filename_png) {
	$filename_jpg=preg_replace("/png$/","jpg",$filename_png);
	list($width, $height, $type, $attr) = getimagesize("$filename_png");
	$im=imagecreatefrompng($filename_png);
	imageJPEG($im, $filename_jpg);
	$res = system("chmod 666 $filename_jpg", $retval);
	return array($width, $height);
}
// ------------------------------------------------------------------
function saveURL2Disk($url, $dirAndFilename) {
	// read URL	
	$img_handle = fopen($url, "r");
	$data = fread($img_handle, 99999999);
	fclose($img_handle);	
	// write URL to disk
	$handle=fopen("$dirAndFilename","w+");
		if (fwrite($handle, $data) === FALSE) {
		die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004062702:27', '', "Could not read/write to $file with handle $handle".''));
		exit;
	}
	fclose($handle);
	// change file permissions
	$res = system("chmod 666 $dirAndFilename", $retval);
}
// ------------------------------------------------------------------
function gif2png($img) {
	// first save file to disk
	$filename=preg_replace("/^http:\/\//","",$img);
	$filename=preg_replace("/\//","|",$filename);
	$filename=preg_replace("/gif$/","",$filename);
	$dir="/vol/www/mensec/web-docs/documents/";
	
	$filename_gif='Mercury'.$filename.'gif';
	$filename_png='Mercury'.$filename.'png';
	saveURL2Disk($img, "$dir$filename_gif");
/*	
	// get image	
	$img_handle = fopen($img, "r");
	$data = fread($img_handle, 99999999);
	fclose($img_handle);	
	// write image to disk
	$handle=fopen("$dir$filename_gif","w+");
		if (fwrite($handle, $data) === FALSE) {
		die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004062702:27', '', "Could not read/write to $file with handle $handle".''));
		exit;
	}
	fclose($handle);
	// change file permissions
	$res = system("chmod 666 $dir$filename_gif", $retval);
	
	*/
	// borrowed code...
	if($gif=gif_loadFile("$dir$filename_gif")) {
		// OK
		$png = "$dir$filename_png";
		if(gif_outputAsPng($gif, $png)) {
			// OK
/*			if($img = ImageCreateFromPng($png)) {
				header("Content-Type: image/jpeg");
				imageJpeg($img);
				imageDestroy($img);
			}
			else {
				print "Error reading PNG";
			}
*/		}
		else {
			print "Error output as PNG";
		}
	}
	else {
		print "Error reading GIF!";
	}
	unlink("$dir$filename_gif");

	// png2jpg
	list($width, $height)=png2jpg("$dir$filename_png");

	return array("http://www.keizerkarelpodia.nl/documents/Mercury$filename".'jpg', $width, $height);
}
// ------------------------------------------------------------------
function logoff() {
	setcookie('RSSID',0,0,'/');
	$retVal="&message=<b>Logged off</b><br>You have logged of. The default channels will be displayed";
	return $retVal;
}
// ------------------------------------------------------------------
function getFeed() {
	// get url belonging to title
	$title=$_REQUEST['title'];
	$sql_string="select feed_url, link, image_url from rss_channels where title='$title'";
	$recset=mysql_query($sql_string) or die(report_sql_error($_SERVER['SCRIPT_NAME'], '2004060115:21', $sql_string, mysql_error()).'');
	$row_recset=mysql_fetch_assoc($recset);
	$url=$row_recset['feed_url'];
	$link=$row_recset['link'];
	$image_url=$row_recset['image_url'];
	
	// retrieve image
	list($image, $caption)=getPicture($link);
	$t=getmicrotime();
	$f="/vol/www/mensec/web-docs/documents/Mercury.$t.tmp";
	saveURL2Disk($image, $f);
	list($width, $height, $type, $attr) = getimagesize($f);
	unlink($f);
	$feedImg_url="&feedImg_url=".urlencode($image);
	$feedImg_w="&feedImg_w=$width";
	$feedImg_h="&feedImg_h=$height";
	// retrieve url
	$lines=file($url);// || die(report_sql_error($_SERVER['SCRIPT_URI'], '2004062711:36', 'getFeed()', "could not do \$lines=file($url)"));

	foreach($lines as $k=>$v) {$data.=$v;}
	$initPos = strpos($data, "<channel>"); //avoid the DTD declaration, non validating parse. Begin directly with channel
	
	$data = stripslashes(substr($data, $initPos));
	if ($data=='') return "content=Feed could not be retrieved from url $url";
	
	$xml_parser = new xml();
	$root_node = $xml_parser->parse($data);
	
	$channel    = array_shift($root_node["_ELEMENTS"]);
	//Now we select some elements we want, discarding others (See rss specs 0.91, 0.92 and 2.0)
	////// WHO title, description and link /////////////////////////////////////////////////////////
	foreach ($channel["_ELEMENTS"] as $item){
		// channel logo
		if($item[_NAME]=="image") {
			foreach($item["_ELEMENTS"] as $tag) {
				if ($_REQUEST['_debug']==1) {
					echo "$tag[_NAME], $tag[_DATA] <br>\n"; 
				}
				if ($tag["_NAME"]=="url") {
					$base_image=$tag[_DATA];
//					$base_image="<img src=\"http://images.slashdot.org/topics/topicslashdot.gif\">";
					
				}
			}
		} // end image
		if($item[_NAME]=="title") $base_name=urlencode($item[_DATA]);
		if($item[_NAME]=="link") $base_uri=urlencode($item[_DATA]);
		if($item[_NAME]=="description") $base_desc=urlencode($item[_DATA]);
	}

	$base = "<rss_intro><b>Web:%20</b><a href=\"$base_uri\"><font color=\"#0000ff\"><u>$base_name</u></font></a><br>$base_desc</rss_intro><br><br><br>";

	$string.="&content=$base";
	////////// ITEMS --> items, description and link ////////////////////////////////////////////////////////
	foreach ($channel["_ELEMENTS"] as $item){ 
		if($item[_NAME]=="item") {
			//stripslashes is needed since providers give links inside texts or titles		
			foreach ($item["_ELEMENTS"] as $tag){
				 if($tag["_NAME"]=="title") $news_title=urlencode($tag[_DATA]);
				 if($tag["_NAME"]=="link") {
				 	$news_uri=urlencode($tag[_DATA]);
				 	$read_more="<a href=\"$news_uri\" target=\"_new\"><font color=\"#999999\"><u>read more...</u></font></a><br>";
				}
	 			 if($tag["_NAME"]=="description") $news_desc=urlencode($tag[_DATA]);
			}
			if ($news_title!='') {
				$n++;
				$titles_only.="&title$n=$news_title";
				$news .= "<rss_title>$news_title</rss_title><br><rss_body>$news_desc<br>$read_more</rss_body><br>";
			}
		}
	}
	$titles_only.="&titles=$n";
	$string.=$news;
	if (preg_match("/\.gif$/", $base_image)) {
		list($base_image, $width, $height)=gif2png($base_image);
	} else if ($base_image!='') {
		$t=getmicrotime();
		$f="/vol/www/mensec/web-docs/documents/Mercury.$t.tmp";
		saveURL2Disk($base_image, $f);
		list($width, $height, $type, $attr) = getimagesize($f);
	}
	$logo_img_h="&logo_img_h=$height";
	$logo_img_w="&logo_img_w=$width";
	
	$i=$base_image;
	//$i='http://i.i.com.com/cnwk.1d/i/ne/sr/ibm/day2/mugs1a_day2.jpg';
	//$i='http://www.keizerkarelpodia.nl/images/zoek.jpg';
	$string.='&img_url='.$i;
	$string.='&caption='.urlencode($caption);
	$string.=$logo_img_h.$logo_img_w;
	$string.=$feedImg_url.$feedImg_h.$feedImg_w;
	$string = stripslashes($string);
	$titles_only= stripslashes($titles_only);
	if ($_REQUEST['version']=='sc1') {
		return $titles_only.$string;
	}

	return $string;
}

// ==================================================================

$a=$_REQUEST['a'];

if ($a=='getChannels') {
	$retVal.=getChannels();
} else if ($a=='getFeed') {
	$retVal.=getFeed();
} else if ($a=='all') {
	$retVal=allFeedTitles(); 
} else if ($a=='logoff') {
	$retVal=logoff(); 
} else if ($a=='logUsage') {
	$retVal=logUsage(); 
} else if ($a=='getWeather') {
	$retVal=getWeather(); 
}
if ($_REQUEST['updateWeather']==1) {
	updateWeather();
}


// return value to flash
echo $retVal;

?>