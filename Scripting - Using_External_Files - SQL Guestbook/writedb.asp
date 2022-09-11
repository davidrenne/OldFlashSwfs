<%

name = Request.Form("wname")
email = Request.Form("wemail")
company = Request.Form("wcompany")
thecomment = Request.Form("wthecomment")

set conn = server.createobject("adodb.connection")
DSNtemp="DRIVER={Microsoft Access Driver (*.mdb)}; "
DSNtemp=dsntemp & "DBQ=" & server.mappath("/sql_guestbook/guestbook.mdb")
conn.Open DSNtemp

'name = "true"
'email = "true"
'company = "true"
'thecomment = "true"

SQLstmt = "INSERT INTO guestbook (name,email,company,thecomment)"
	SQLstmt = SQLstmt & " VALUES (" 
	SQLstmt = SQLstmt & "'" & name & "',"
	SQLstmt = SQLstmt & "'" & email & "',"
	SQLstmt = SQLstmt & "'" & company & "',"
	SQLstmt = SQLstmt & "'" & thecomment & "'"
	SQLstmt = SQLstmt & ")"

Set RS = conn.execute(SQLstmt)

Conn.Close

set conn = nothing

response.write("Record is registrated. Please close this windows")
%>
