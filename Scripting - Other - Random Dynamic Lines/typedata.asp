<%
function writeurlvar(vname,vdata)
response.write "&"
response.write vname
response.write "="
response.write SERVER.URLENCODE(vdata)
end function

response.write "typecount=3"
writeurlvar "typetext0","visit"+vbcrlf+"http://www.flashkit.com"
writeurlvar "typetext1","DivX ;-) MPEG4 Hi-Res"+vbcrlf+"Video Codec"+vbcrlf+"http://divx.ctw.cc"
writeurlvar "typetext2","Eye4U"+vbcrlf+"falsh site"+vbcrlf+"http://www.eye4u.com"
writeurlvar "typeurl0","http://www.flashkit.com"
writeurlvar "typeurl1","http://divx.ctw.cc"
writeurlvar "typeurl2","http://www.eye4u.com"
writeurlvar "vend","yes"
%>