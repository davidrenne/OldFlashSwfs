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

 ! bbs_view.asp中约定:对显示bbs中帖子的主题,发起人,点击(数),回复(数),最后回复时间/人这些内容的处理
   称为浏览处理；对查看具体帖子内容及其回复的处理称为查看处理.
-->

<%@Language="VBScript"%>

<%

 '说明变量
 Dim currentpage            '当前页页码 
 Dim currentid                 '原始帖号 
 Dim rstemp                 'RecordSet对象实例
 Dim connectdb              '表示ActiveConnection属性的字符串
 Dim sql                    'SQL字符串 
 Dim maxcount               '共有几页(数据集按PageSize分页时)
 Dim howmanyrecs            '统计当前页的确切记录数 
 Dim recsperpage            '每页显示多少条记录

 

'------------------------------------------------------------------------'接受Flash传递的GET变量
'指明当前显示哪一页.并且如没有指明(whichpage),则初始显示第一页的内容.
 currentpage=Request.QueryString("whichpage")
 if currentpage="" then
    currentpage=1
 end if
 
 currentid=Request.QueryString("whichid")
'-----------------------------------------------------------------------

'----------------------------------------------------------------------公共部分
'连接数据库,示例所用的是Access数据库，使用者可以替换为SQLServer等数据库。
 
SET rstemp=Server.CreateObject("ADODB.RecordSet")
 
'使用者可以在下句中替换适当的数据库的路径。               
 
connectdb="DBQ="+Server.MapPath("../db/bbs/bbs_data.mdb")+";DRIVER={Microsoft Access Driver (*.mdb)};"    
 
'---------------------------------------------------------------------------------

'当为查看操作时，处理点击数，原始帖内容的显示.
 if currentid<>"" then		'表明是查看帖子
       ON ERROR RESUME NEXT
    '点击次数累加一 
    sql="UPDATE bbs_table SET bbs_view_num=bbs_view_num+1 WHERE bbs_id="&currentid
      rstemp.Open sql,connectdb,3
    '-----------------------------------------------------------------------
    '设置错误陷阱
 
    '以上操作如果有错误,则给出错误提示信息.
 
    if Err.Number<>0 then
    
        '由于传递给Flash的参数是标准MIME类型,所以最好用URLEncode方法将参数按URL的编码输出.
    
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
    
       		'由于传递给Flash的参数是标准MIME类型,所以最好用URLEncode方法将参数按URL的编码输出.
    
       		Response.Write "&error_msg="&Server.URLEncode(Err.Description)
       		Response.Write "&data_load=error"
       		rstemp.Close
       		Set rstemp=Nothing
       		Response.End
       else
             '设置好原始帖内容变量。
           Response.Write  "&bbs_content="&Server.URLEncode(rstemp("bbs_content"))
       end if
     end if
  end if

'下面是浏览/查看操作中处理语句的整合部分。

 ON ERROR RESUME NEXT
 
 if currentid="" then		'表明是浏览处理

                        
     sql="SELECT bbs_id,bbs_time,bbs_subject,bbs_name,bbs_email,bbs_view_num,bbs_reply_num,"
     sql=sql&"bbs_lastreply_time,bbs_lastreply_name FROM bbs_table where "
     sql=sql&"bbs_is_reply=False ORDER BY bbs_lastreply_time DESC" 
 else
      rstemp.Close
     sql="SELECT bbs_subject,bbs_time,bbs_name,bbs_email,bbs_content FROM bbs_table where "
     sql=sql&"bbs_reply_id="&currentid&" or  bbs_id="&currentid&"  ORDER BY bbs_time"  
 end if 
          
 rstemp.Open sql,connectdb,3

 '设置错误陷阱
 
 '以上操作如果有错误,则给出错误提示信息.
 
 if Err.Number<>0 then
    
    '由于传递给Flash的参数是标准MIME类型,所以最好用URLEncode方法将参数按URL的编码输出.
    
    Response.Write "&error_msg="&Server.URLEncode(Err.Description)
    Response.Write "&data_load=error"
    rstemp.Close
    Set rstemp=Nothing
    Response.End
  
    '否则如果无错,则向Flash传递正确的记录信息.
 
 else

    '对浏览操作来说，这是指没有帖子;对查看操作来说，是指没有回复                 

    if rstemp.EOF and rstemp.BOF then    
      Response.Write "&have_record=false"
      Response.Write "&data_load=yes"
       rstemp.Close
       Set rstemp=Nothing
       Response.End
    else
       if currentid="" then		
          rstemp.PageSize=15  '确定每页显示15条记录,用户可以随意改变数目
        else
          rstemp.PageSize=3  '确定每页显示3条记录,用户可以随意改变数目
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

          if currentid="" then	  '查看操作并不需要bbs_id等

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
