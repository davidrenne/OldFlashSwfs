<%@LANGUAGE="VBSCRIPT"%><%

If Request("sms") = "" then
	Response.Write "done=error"
	Response.End
Else
	Dim objCDO
	Set objCDO = Server.CreateObject("CDONTS.NewMail")
	objCDO.From = "sms@ian-b.co.uk"
	objCDO.To = "ianz2@sms.genie.co.uk"
	objCDO.CC = "sms@ian-b.co.uk"
	objCDO.Subject = ""
	objCDO.Body = request("sms")
	objCDO.Send
	
	response.Write ("done=done")
End If
%>