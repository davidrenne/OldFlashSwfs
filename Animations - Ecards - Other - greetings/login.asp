<%	login=Trim(Request.QueryString("login"))
	passwort=Trim(Request.QueryString("passwort"))
	sql="SELECT * FROM Mitglieder WHERE Login='"+login+"' AND Passwort='"+passwort+"'"
	
	set db=Server.CreateObject("ADODB.Connection")
	db.Open "name of database ... for example ... database"
	set rs=Server.CreateObject("ADODB.RECORDSET")
	rs.Open sql, db, 3, 3
	
	if not rs.EOF then
	' Die Login-Informationen sind korrekt.
		Response.Write("ergebnis=true")
	else
	' Die Login-Informationen sind falsch.
		Response.Write("ergebnis=false")
	end if
	
	rs.Close
	set rs=nothing
	db.Close
	set db=nothing %>