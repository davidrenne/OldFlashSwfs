<% @Language = "VBScript" %>

<!-- #include virtual="/cgi-bin/includes/fun.asp" -->

<%
'--SUPPORT personnel to get his email
SupportName = "Chuck Lewis"
SupportEmail = "chuck@boatventures.com"

'--VARs
Name = trim(request.form("name"))
Company = trim(request.form("company"))
Email = trim(request.form("email"))
Address1 = trim(request.form("address1"))
Address2 = trim(request.form("address2"))
City = trim(request.form("city"))
State = trim(request.form("state"))
Zip = trim(request.form("zip"))
Country = trim(request.form("country"))
Phone = format_phone(trim(request.form("phone")))
Fax = format_phone(trim(request.form("fax")))
ImInterestedIn = request.form("ImInterestedIn")
HowDidYouHear = request.form("HowDidYouHear")
AreYouA = request.form("AreYouA")

'--FORMAT
IF Name = "" THEN Name = "(Unknown)"

'--DELIMIT vowels (and sometimes 'y')
IF (lcase(left(AreYouA, 1)) = "a" OR lcase(left(AreYouA, 1)) = "e" OR lcase(left(AreYouA, 1)) = "i" OR lcase(left(AreYouA, 1)) = "o" OR lcase(left(AreYouA, 1) = "u")) THEN conjugate = "an" ELSE conjugate ="a"

'-SEND
set mailer = server.createobject("cdonts.newmail")
mailer.to = SupportName & " <" & SupportEmail & ">"
mailer.from = Name & " <" & Email & ">"
mailer.subject = "BoatVentures website contact"
mailer.body = "Dear " & SupportName & ":" & vbcrlf & vbcrlf & "Contact form received at " & Time & " on " & Date & "." & vbcrlf & vbcrlf & "Name:" & vbtab & vbtab & Name & " (" & Email & ")" & vbcrlf & "Company:" & vbtab & Company & vbcrlf & "Address:" & vbtab & Address1 & " " & Address2 & vbcrlf & vbtab & vbtab & City & ", " & State & " " & Zip & " " & Country & vbcrlf & "Phone:" & vbtab & Phone & vbcrlf & "Fax:" & vbtab & vbtab & Fax & vbcrlf & vbcrlf & "I'm interested in '" & ImInterestedIn & "'." & vbcrlf & vbcrlf & "I heard about BoatVentures through '" & HowDidYouHear & "'." & vbcrlf & vbcrlf & "I am " & conjugate & " '" & AreYouA & "'." & vbcrlf
mailer.send

'--CLOSE
set mailer = nothing

'--SEND
response.redirect "contactus_form_thankyou.asp" %>