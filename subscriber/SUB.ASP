<%@ LANGUAGE="VBSCRIPT" %>
<html>

<head>
<title>.::: sub | scriber :::.</title>
<%
      Sub Write(strWriteThis)
      response.write(strWriteThis & "<br>")
      end sub

      %>
</head>

<body>
<%
      strFrom=request.form("email")
      strTo="info@substring.net"
      strSubject = "Response from SUBSTRING website"
      strBody="Name: " & request.form("name") & CHR(13) & "Email: " & request.form("email")

      Set myCDONTSMail = CreateObject("CDONTS.NewMail")

      myCDONTSMail.Send strFrom,strTo,strSubject,strBody

      Set myCDONTSMail  = Nothing
      %>
</body>
</html>
