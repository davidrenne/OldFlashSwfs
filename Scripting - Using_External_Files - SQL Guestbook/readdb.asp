<%
' Encode a number from 0..15 to a single hex digit
Function HexChar(ByVal i)
	If i < 10 Then
		HexChar = Chr(i+Asc("0"))
	Else
		HexChar = Chr(i-10+Asc("A"))
	End If
End Function

' Encode the control and punctuation characters in a string to %xx hex values
Function URLEncode(ByVal s)
	Dim result, ch
	Do While Len(s) > 0
		ch = Asc(s)
		s = Right(s, Len(s)-1)
		If (ch >= Asc("a") And ch <= Asc("z")) Or (ch >= Asc("A") And ch <= Asc("Z")) Then
			result = result & Chr(ch)
		ElseIf ch = Asc(" ") Then
			result = result & "+"
		Else
			'result = result & "*" & ch
			'result = result & "!" & (ch/16) & (ch mod 16)
			result = result & "%" & HexChar(Int(ch/16)) & HexChar(ch Mod 16)
		End If
	Loop
	URLEncode = result
End Function

'PageNo=1

set conn = server.createobject("adodb.connection")
DSNtemp="DRIVER={Microsoft Access Driver (*.mdb)}; "
DSNtemp=dsntemp & "DBQ=" & server.mappath("/sql_guestbook/guestbook.mdb")
conn.Open DSNtemp

' Få recnum fra flash
recnum = Request.Form("recnum")

sqlstmt = "SELECT * from guestbook ORDER BY id DESC"
Set rs = Server.CreateObject("ADODB.Recordset")

rs.Open sqlstmt, conn, 3, 3

TotalRecs = rs.recordcount -1

'rs.Pagesize=10
'TotalPages = cInt(rs.pagecount)
'rs.absolutepage=PageNo


x = 0
For x = 1 to recnum
	If rs.eof then
		Exit For
	Else
		rs.MoveNext
	End If
Next

If rs.eof then
	Conn.Close
Else
	IDnum = rs("id")
	When = rs("postdate")
	Name = rs("name")
	'Name = Replace(Name,"''","'")

	Email = rs("email")
	'Email = Replace(Email,"''","'")

	Company = rs("company")
	'Company = replace(Company, "''", "'")

	TheComment = rs("thecomment")
	'Comment = replace(comment, "''", "'")


	response.write("name="+URLEncode(Name)+"&email="+URLEncode(Email)+"&company="+URLEncode(Company)+"&thecomment="+URLEncode(TheComment)+"&when="+URLEncode(When)+"&totalrecs="+URLEncode(TotalRecs)+"&idnum="+URLEncode(IDnum))

	Conn.Close
End If

set conn = nothing

%>
