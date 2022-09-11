<%@ Language=VBScript %>
<%
Option Explicit
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0
Dim fsoObject, fileName, filTextStream, strName, strEmail, strMessage, strDate, strData, strOldData, x, filepath
Dim process
'Get Path of Current ASP file
filepath = Server.MapPath("myxml.asp")
'Use The Path
filepath = left(filepath, len(filepath) - 9)

Set fsoObject = Server.CreateObject("Scripting.FileSystemObject")
Set fileName = fsoObject.GetFile(filepath & "myxml.xml")
Set filTextStream = fileName.OpenAsTextStream(ForReading, TristateFalse)

strOldData = filTextStream.ReadAll
x = len(strOldData) - 13

strData = Mid(strOldData, 1, x)
'Response.Write strData
filTextStream.close
Set filTextStream = fileName.OpenAsTextStream(ForWriting, TristateFalse)
strDate = Date  
strName = Request.Form("strName")
strEmail = Request.Form("strEmail")
strMessage = Request.Form("strMessage")

'strData = Mid(strData, 32)
strData = strData & vbcrlf & "<entry>" & vbcrlf
strData = strData & "<date>" & strDate & "</date>" & vbcrlf
strData = strData & "<name>" & strName & "</name>" & vbcrlf
strData = strData & "<email>" & strEmail & "</email>" & vbcrlf
strData = strData & "<message>" & strMessage & "</message>" & vbcrlf
strData = strData & "</entry>" & vbcrlf
strData = strData & "</sqltable>" 


filTextStream.Write strData
filTextStream.close

Set fsoObject = nothing
set fileName = nothing
set filTextStream = nothing
process = true
Response.Expires = 0

If process = true then
	Response.Redirect "xml.asp"
End If	


%>