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

 ! bbs_view.asp��Լ��:����ʾbbs�����ӵ�����,������,���(��),�ظ�(��),���ظ�ʱ��/����Щ���ݵĴ���
   ��Ϊ��������Բ鿴�����������ݼ���ظ��Ĵ����Ϊ�鿴����.
-->

<%@Language="VBScript"%>

<%

 '˵������
 Dim currentpage            '��ǰҳҳ�� 
 Dim currentid                 'ԭʼ���� 
 Dim rstemp                 'RecordSet����ʵ��
 Dim connectdb              '��ʾActiveConnection���Ե��ַ���
 Dim sql                    'SQL�ַ��� 
 Dim maxcount               '���м�ҳ(���ݼ���PageSize��ҳʱ)
 Dim howmanyrecs            'ͳ�Ƶ�ǰҳ��ȷ�м�¼�� 
 Dim recsperpage            'ÿҳ��ʾ��������¼

 

'------------------------------------------------------------------------'����Flash���ݵ�GET����
'ָ����ǰ��ʾ��һҳ.������û��ָ��(whichpage),���ʼ��ʾ��һҳ������.
 currentpage=Request.QueryString("whichpage")
 if currentpage="" then
    currentpage=1
 end if
 
 currentid=Request.QueryString("whichid")
'-----------------------------------------------------------------------

'----------------------------------------------------------------------��������
'�������ݿ�,ʾ�����õ���Access���ݿ⣬ʹ���߿����滻ΪSQLServer�����ݿ⡣
 
SET rstemp=Server.CreateObject("ADODB.RecordSet")
 
'ʹ���߿������¾����滻�ʵ������ݿ��·����               
 
connectdb="DBQ="+Server.MapPath("../db/bbs/bbs_data.mdb")+";DRIVER={Microsoft Access Driver (*.mdb)};"    
 
'---------------------------------------------------------------------------------

'��Ϊ�鿴����ʱ������������ԭʼ�����ݵ���ʾ.
 if currentid<>"" then		'�����ǲ鿴����
       ON ERROR RESUME NEXT
    '��������ۼ�һ 
    sql="UPDATE bbs_table SET bbs_view_num=bbs_view_num+1 WHERE bbs_id="&currentid
      rstemp.Open sql,connectdb,3
    '-----------------------------------------------------------------------
    '���ô�������
 
    '���ϲ�������д���,�����������ʾ��Ϣ.
 
    if Err.Number<>0 then
    
        '���ڴ��ݸ�Flash�Ĳ����Ǳ�׼MIME����,���������URLEncode������������URL�ı������.
    
       Response.Write "&error_msg="&Server.URLEncode(Err.Description)
       Response.Write "&data_load=error"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
        
    else
  
       ON ERROR RESUME NEXT 

       sql="SELECT bbs_content  FROM bbs_table WHERE bbs_id="&currentid
       rstemp.Open sql,connectdb,3
       if Err.Number<>0 then
    
       		'���ڴ��ݸ�Flash�Ĳ����Ǳ�׼MIME����,���������URLEncode������������URL�ı������.
    
       		Response.Write "&error_msg="&Server.URLEncode(Err.Description)
       		Response.Write "&data_load=error"
       		rstemp.Close
       		Set rstemp=Nothing
       		Response.End
       else
             '���ú�ԭʼ�����ݱ�����
           Response.Write  "&bbs_content="&Server.URLEncode(rstemp("bbs_content"))
       end if
     end if
  end if

'���������/�鿴�����д����������ϲ��֡�

 ON ERROR RESUME NEXT
 
 if currentid="" then		'�������������

                        
     sql="SELECT bbs_id,bbs_time,bbs_subject,bbs_name,bbs_email,bbs_view_num,bbs_reply_num,"
     sql=sql&"bbs_lastreply_time,bbs_lastreply_name FROM bbs_table where "
     sql=sql&"bbs_is_reply=False ORDER BY bbs_lastreply_time DESC" 
 else
      rstemp.Close
     sql="SELECT bbs_subject,bbs_time,bbs_name,bbs_email,bbs_content FROM bbs_table where "
     sql=sql&"bbs_reply_id="&currentid&" or  bbs_id="&currentid&"  ORDER BY bbs_time"  
 end if 
          
 rstemp.Open sql,connectdb,3

 '���ô�������
 
 '���ϲ�������д���,�����������ʾ��Ϣ.
 
 if Err.Number<>0 then
    
    '���ڴ��ݸ�Flash�Ĳ����Ǳ�׼MIME����,���������URLEncode������������URL�ı������.
    
    Response.Write "&error_msg="&Server.URLEncode(Err.Description)
    Response.Write "&data_load=error"
    rstemp.Close
    Set rstemp=Nothing
    Response.End
  
    '��������޴�,����Flash������ȷ�ļ�¼��Ϣ.
 
 else

    '�����������˵������ָû������;�Բ鿴������˵����ָû�лظ�                 

    if rstemp.EOF and rstemp.BOF then    
      Response.Write "&have_record=false"
      Response.Write "&data_load=yes"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
    else
       if currentid="" then		
          rstemp.PageSize=15  'ȷ��ÿҳ��ʾ15����¼,�û���������ı���Ŀ
        else
          rstemp.PageSize=3  'ȷ��ÿҳ��ʾ3����¼,�û���������ı���Ŀ
       end if
        recsperpage=rstemp.PageSize
        maxcount=cint(rstemp.PageCount)
            rstemp.AbsolutePage=currentpage
           howmanyrecs=0       
       Do while (NOT rstemp.EOF) and (howmanyrecs<rstemp.PageSize)
            Response.Write "&bbs_time_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_time"))	
          Response.Write "&bbs_subject_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_subject"))
    	   Response.Write "&bbs_name_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_name"))
             Response.Write "&bbs_email_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_email"))                            

          if currentid="" then	  '�鿴����������Ҫbbs_id��

             Response.Write "&bbs_id_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_id"))	
	          Response.Write "&bbs_view_num_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_view_num"))
                  Response.Write "&bbs_reply_num_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_reply_num"))
     	          Response.Write "&bbs_lastreply_time_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_lastreply_time"))
     	          Response.Write "&bbs_lastreply_name_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_lastreply_name"))	
                            
          else
             Response.Write  "&bbs_content_"&howmanyrecs&"="&Server.URLEncode(rstemp("bbs_content"))
          end if
             rstemp.MoveNext
            howmanyrecs=howmanyrecs+1
       Loop
       Response.Write "&totalrec="&rstemp.RecordCount
       Response.Write "&maxpage="&maxcount
       Response.Write "&howmanyrecs="&howmanyrecs
       Response.Write "&currentpage="&currentpage
       Response.Write "&recsperpage="&recsperpage
       Response.Write "&have_record=true"
       Response.Write "&data_load=yes"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
  end if
 end if
 
                      '2001.1.12
%>
