
<html>
<head>
<%
	Dim x,y,index1,hashparams,index2,paramsval,val,xvalx
	index1 = 0
	index2 = 0

	hashparams = "clientid:oid:AuthCode:ProcReturnCode:Response:mdStatus:cavv:eci:md:rnd:"
	
	index2 = InStr(1,hashparams,":")

	'index2 = InStr(index1,hashparams,":")
	'Response.write("index2=" & index2)

	'while CInt(index1) < Len(hashparams)
	'	response.write("while içindeyim")
	'	
	'	response.write("hashparams=" & hashparams)
	'	index2 = InStr(index1,hashparams,":")
	'
	'	response.write(index2 & " "&index1)
	'	xvalx = Mid(hashparams,index1,index2 - index1)
	'	response.write("<br/>xvalx= " & xvalx)
	'	val = request.form(xvalx)
	'	response.write("<br/>val=" & val)
	'	if val = null then
	'	val = ""
	'	end if
	'	paramsval = paramsval & val
	'	index1 = CInt(index2) + 1
	'
	'Wend
%>



</script>
</body>

</html>