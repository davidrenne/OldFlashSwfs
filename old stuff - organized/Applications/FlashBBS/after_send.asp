<!--
'''''''''''''''''''''''''''''''''''''''''''
'         FlashBBS4os 1.0                 '
'                                         '
'      version : 1.0                          '
'       Author : huwell                   '
'       E-Mail : huwell@4os.org           '
'                                         '
'          www.4OS.org                    '
'                                         '
' 声明：这是一个自由软件，你可以遵照自由软   '
'       件基金会出版的GNU通用公共许可证条   '
'       款(即GPL)来修改和重新发布这一程序。 '
'                                         '
'''''''''''''''''''''''''''''''''''''''''''

 ! after_send.asp用于将新帖中的内容存入数据库.
-->

<%@Language="VBScript"%>

<%
  Dim addname	'发帖者姓名
  Dim addemail	'发帖者Email
  Dim addsubject	'发起主题
  Dim addcontent	'帖子内容
  Dim current_time	'发帖时间	  

  dealwith=Request.QueryString("dealwith")
  currentid=Request.QueryString("whichid") 

  addsubject=Request.Form("subject")
  addname=Request.Form("name")
  addemail=Request.Form("email")
  addcontent=Request.Form("content")
  

  current_time=NOW()
  
  Set conn=Server.CreateObject("ADODB.RecordSet")
  connectdb="DBQ="&server.Mappath("../db/bbs/bbs_data.mdb")&";DRIVER={MicroSoft Access Driver (*.mdb)};"
  
  '当为查看操作时，处理回复数.
 if dealwith="reply" then		'表明是查看帖子
       ON ERROR RESUME NEXT
    '回复次数累加一 
    sql="UPDATE bbs_table SET bbs_reply_num=bbs_reply_num+1, "
    sql=sql&"  bbs_lastreply_time='"&current_time&"',  bbs_lastreply_name='"&addname&"'  WHERE bbs_id="&currentid
       conn.Open sql,connectdb
    '-----------------------------------------------------------------------
    '设置错误陷阱
 
    '以上操作如果有错误,则给出错误提示信息.
 
    if Err.Number<>0 then
    
        '由于传递给Flash的参数是标准MIME类型,所以最好用URLEncode方法将参数按URL的编码输出.
    
       Response.Write "&error_msg="&Server.URLEncode(Err.Description)
       Response.Write "&send_is=error"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
     
     end if
  end if

  
'下面是浏览/查看操作中处理语句的整合部分
   ON ERROR RESUME NEXT

   if dealwith="reply" then
     sql="INSERT INTO bbs_table(bbs_time,bbs_name,bbs_email,bbs_content,bbs_is_reply,bbs_reply_id)"
     sql=sql&" values('"&current_time&"','"&addname&"','"&addemail&"','"&addcontent&"',True,"
     sql=sql&currentid&")"      
  else

  sql="INSERT INTO bbs_table(bbs_subject,bbs_time,bbs_name,bbs_email,bbs_content,bbs_is_reply,bbs_view_num"
  sql=sql&",bbs_lastreply_time,bbs_lastreply_name)"
  sql=sql&" values('"&addsubject&"','"&current_time&"','"&addname&"','"&addemail&"','"&addcontent&"',False,1,"
  sql=sql&"'"&current_time&"','"&addname&"')"
 
 end if

  Conn.Open sql,connectdb
  if Err.Number<>0 then
    Response.Write "&error_msg="&Server.URLEncode(Err.Description)
    Response.Write "&send_is=error"
 else
    Response.Write "&send_is=yes"
 end if
 conn.Close
 Set conn=Nothing
%>