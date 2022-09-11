<%
For each item in Request.QueryString
	Response.Cookies(item) = Request.Querystring(item)
	Response.Cookies(item).Expires = "December 31, 2001"	
Next
%>
