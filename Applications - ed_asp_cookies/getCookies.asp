<%
For each cookie in Request.Cookies
   strOut = strOut & Server.URLEncode(cookie) & "="
   strOut = strOut & Server.URLEncode(Request.Cookies(cookie))
   strOut = strOut & "&"
Next
Response.Write strOut
%>