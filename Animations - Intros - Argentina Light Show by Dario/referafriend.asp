<%
<!--I hope you enjoy this script and if you have any comments or questions email me at jwtaylor@naxs.net - I am currently providing contract work for NetAccess seeking a fulltime position -anywhere in the world- please take a moment view my latest work at webdesign.naxs.com, have a great day. -->

strHost = "mail.naxs.com"<!--change to your mail server, then just change the email addresses of confirmation email -->

 address1 = Request("txtEmail1")
 address2 = Request("txtEmail2")
 address3 = Request("txtEmail3")
 address4 = Request("txtEmail4")
 address5 = Request("txtEmail5")


 Set Mail = Server.CreateObject("Persits.MailSender")<!--We use Persist and it is a free download, script will work with    others-->
 Mail.Host = strHost 
 strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 strBody = strBody & request("txtMessage") & chr(10)
 strBody = strBody & "    " & chr(10) & chr(10) 
 strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)<!--You will want to change this line to meet your needs for each email-->
 Mail.From = Request("txtFrom") 
 Mail.FromName = Request("txtName")
 Mail.AddAddress  Request("txtEmail")
 Mail.Subject = "Check out this site"
 Mail.Body = strBody 
 On Error Resume Next 
 Mail.Send

 Set Mail = Server.CreateObject("Persits.MailSender")<!--This sends a confirmation email to addresses listed below, change to suit. -->
 Mail.Host = strHost 
 strBody = "Someone Recommended our Web Design Site " & chr(10) & chr(10) 
 strBody = strBody & "That someone was:    " & request("txtName") & chr(10) 
 strBody = strBody & "Their email address is:    " & request("txtFrom") & chr(10)
 strBody = strBody & "This is what their message said:   " & request("txtMessage") & chr(10)
 strBody = strBody & "    " & chr(10) & chr(10) 
 strBody = strBody & " Here are the emails that the message was sent to:  " & chr(10) & chr(10) 
 strBody = strBody & " Email:  " & request("txtEmail") & chr(10)
 strBody = strBody & " Email:  " & address1 & chr(10)
 strBody = strBody & " Email:  " & address2 & chr(10)
 strBody = strBody & " Email:  " & address3 & chr(10)
 strBody = strBody & " Email:  " & address4 & chr(10)
 strBody = strBody & " Email:  " & address5 & chr(10) 
 Mail.From = Request("txtFrom") 
 Mail.FromName = Request("txtName")
 Mail.AddAddress "jwtaylor@naxs.net"
 Mail.AddAddress "kbruce@naxs.com"
 Mail.AddAddress "rudy@naxs.com"
 Mail.Subject = "Someone recommended us for web design"
 Mail.Body = strBody 
 On Error Resume Next 
 Mail.Send


		If address1 = "" Then
		Set Mail = Nothing
		Else
		Set Mail = Server.CreateObject("Persits.MailSender")
 		Mail.Host = strHost 
 		strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 		strBody = strBody & request("txtMessage") & chr(10)
 		strBody = strBody & "    " & chr(10) & chr(10) 
 		strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)  
 		Mail.From = Request("txtFrom") 
 		Mail.FromName = Request("txtName")
 		Mail.AddAddress  address1
 		Mail.Subject = "Check out this site"
 		Mail.Body = strBody 
 		On Error Resume Next 
 		Mail.Send
		End If

		If address2 = "" Then
		Set Mail = Nothing
		Else
		Set Mail = Server.CreateObject("Persits.MailSender")
 		Mail.Host = strHost 
 		strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 		strBody = strBody & request("txtMessage") & chr(10)
 		strBody = strBody & "    " & chr(10) & chr(10) 
 		strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)  
		Mail.From = Request("txtFrom") 
 		Mail.FromName = Request("txtName")
 		Mail.AddAddress  address2
 		Mail.Subject = "Check out this site"
		Mail.Body = strBody 
 		On Error Resume Next 
 		Mail.Send
		End If

		If address3 = "" Then
		Set Mail = Nothing
		Else
		Set Mail = Server.CreateObject("Persits.MailSender")
 		Mail.Host = strHost 
 		strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 		strBody = strBody & request("txtMessage") & chr(10)
 		strBody = strBody & "    " & chr(10) & chr(10) 
 		strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)  
		Mail.From = Request("txtFrom") 
 		Mail.FromName = Request("txtName")
 		Mail.AddAddress  address3
 		Mail.Subject = "Check out this site"
		Mail.Body = strBody 
 		On Error Resume Next 
 		Mail.Send
		End If

		If address4 = "" Then
		Set Mail = Nothing
		Else
		Set Mail = Server.CreateObject("Persits.MailSender")
 		Mail.Host = strHost 
 		strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 		strBody = strBody & request("txtMessage") & chr(10)
 		strBody = strBody & "    " & chr(10) & chr(10) 
 		strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)  
		Mail.From = Request("txtFrom") 
 		Mail.FromName = Request("txtName")
 		Mail.AddAddress  address4
 		Mail.Subject = "Check out this site"
		Mail.Body = strBody 
 		On Error Resume Next 
 		Mail.Send
		End If

		If address5 = "" Then
		Set Mail = Nothing
		Else
		Set Mail = Server.CreateObject("Persits.MailSender")
 		Mail.Host = strHost 
 		strBody = "Come see the new NetAccess Web Design website " & chr(10) & chr(10) 
 		strBody = strBody & request("txtMessage") & chr(10)
 		strBody = strBody & "    " & chr(10) & chr(10) 
 		strBody = strBody & " This message was generated at http://webdesign.naxs.com by:" & request("txtName") & chr(10)  
		Mail.From = Request("txtFrom") 
 		Mail.FromName = Request("txtName")
 		Mail.AddAddress  address5
 		Mail.Subject = "Check out this site"
		Mail.Body = strBody 
 		On Error Resume Next 
 		Mail.Send
		End If

Set Mail = Nothing
%>