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
' ����������һ��������������������������   '
'       �����������GNUͨ�ù������֤��   '
'       ��(��GPL)���޸ĺ����·�����һ���� '
'                                         '
'''''''''''''''''''''''''''''''''''''''''''

 ! after_send.asp���ڽ������е����ݴ������ݿ�.
-->

<%@Language="VBScript"%>

<%
  Dim addname	'����������
  Dim addemail	'������Email
  Dim addsubject	'��������
  Dim addcontent	'��������
  Dim current_time	'����ʱ��	  

  dealwith=Request.QueryString("dealwith")
  currentid=Request.QueryString("whichid") 

  addsubject=Request.Form("subject")
  addname=Request.Form("name")
  addemail=Request.Form("email")
  addcontent=Request.Form("content")
  

  current_time=NOW()
  
  Set conn=Server.CreateObject("ADODB.RecordSet")
  connectdb="DBQ="&server.Mappath("../db/bbs/bbs_data.mdb")&";DRIVER={MicroSoft Access Driver (*.mdb)};"
  
  '��Ϊ�鿴����ʱ������ظ���.
 if dealwith="reply" then		'�����ǲ鿴����
       ON ERROR RESUME NEXT
    '�ظ������ۼ�һ 
    sql="UPDATE bbs_table SET bbs_reply_num=bbs_reply_num+1, "
    sql=sql&"  bbs_lastreply_time='"&current_time&"',  bbs_lastreply_name='"&addname&"'  WHERE bbs_id="&currentid
       conn.Open sql,connectdb
    '-----------------------------------------------------------------------
    '���ô�������
 
    '���ϲ�������д���,�����������ʾ��Ϣ.
 
    if Err.Number<>0 then
    
        '���ڴ��ݸ�Flash�Ĳ����Ǳ�׼MIME����,���������URLEncode������������URL�ı������.
    
       Response.Write "&error_msg="&Server.URLEncode(Err.Description)
       Response.Write "&send_is=error"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
     
     end if
  end if

  
'���������/�鿴�����д����������ϲ���
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