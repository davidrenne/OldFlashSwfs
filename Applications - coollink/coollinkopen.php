<?
//The script is written by Seungho Choo at http://tangible.new21.org
/*
 install
 1. create table named "shcoollink" or whaterever 

 table schema 
CREATE TABLE shcoollink (
   no int(11) NOT NULL auto_increment,
   url tinytext NOT NULL,
   date date,
   description text,
   count smallint(6) NOT NULL,
   title tinytext NOT NULL,
   category tinytext NOT NULL,
   PRIMARY KEY (no)
);
if you change the table name, variable $table_name must be altered.

2. open flash file and change variable php.
3. name categories in flash movie. It'll be shown up in the menu buttons.
4. if you want to have more category, add a menu button and name it "subcategory5" etc..
  and add the category  in the script at the 1st frame.
5. make a title movie or just remove title instance in flash movie if you don't want to have.
6. any question? choo_sh@yahoo.com
7. A new version(flash5) will be released soon. it's absolutely open source(GNU public lincense).
*/

$table_name = "shcoollink";
//set the following according to your db connection. 
$db = mysql_connect("localhost","root",""); mysql_select_db("user_tangible",$db);

if($mode == 'update') 
        updatelink();
else if($mode == 'delete')
	deletelink();
else if($mode == 'count')
	addcount();
else if($mode == 'get')
	getdata();
else if ($mode == 'add')
	addlink();
else
	echo "&alert=no mode specified&";

function updatelink(){
	global $table_name,$no,$title,$description,$url;
		$que="UPDATE $table_name
		   SET title = '$title', url = '$url', description = '$description'
			 WHERE no='$no';";   
		$result = mysql_query($que); 
		echo "&alert=updated successfully";
	echo "&eof=true&";

}

function deletelink(){
	global $table_name,$no;
		$que="DELETE FROM $table_name WHERE	no = '$no';"; 
		$result = mysql_query($que) or die("&alert = failed"); 
		echo "&eof=true&";
		}

function addcount(){
	global $table_name,$no;
	$que1="UPDATE $table_name
	   SET count = count + 1
	 WHERE no ='$no';";   
	$result = mysql_query($que1); 
	echo "&eof=true&";
}

function addlink(){
	global $table_name,$category,$title,$url,$description;
	$sql = "INSERT INTO $table_name(category,title,url,date,description) VALUES('$category','$title','$url',now(),'$description')";
	$result = mysql_query($sql) or die("&eof=true&error=db&em=".mysql_error());
	echo "&eof=true";
}

function getdata(){
	global $table_name,$no;
	global $tablename,$page,$selfpath,$category,$row;
    
	$sql =  "select * from $table_name where category = '$category'";
	$result = mysql_query($sql);
	$total = mysql_affected_rows();  
	echo "&$category"."_linknum=$total"; 
	for($i=0 ; $i< $total ; $i++) 
	{ 
	  
	if ($total > 1){mysql_data_seek($result,$i);}
	     $row=mysql_fetch_array($result);    
	       
	      $num = $i + 1;
		 $prefix = $category."_".$num."_";
		 $date = $row[date];
		 echo "&$prefix"."date=$date";
		 $url = urlencode($row[url]);
		 echo "&$prefix"."url=$url";
		 $title = urlencode($row[title]);
		 echo "&$prefix"."title=$title";
		 $description = urlencode($row[description]);
		 echo "&$prefix"."description=$description";
		 $count = $row[count];
		 echo "&$prefix"."count=$count";
		 $no = $row[no];
		 echo "&$prefix"."no=$no";
	} 
	echo "&eof=true&";
}

?>