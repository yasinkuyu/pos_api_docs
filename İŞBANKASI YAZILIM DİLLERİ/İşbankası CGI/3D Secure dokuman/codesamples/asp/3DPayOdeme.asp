<html>
<head>
<title>3D Pay Ödeme Sayfasi</title>
<meta http-equiv="Content-Language" content="tr">

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

  <meta http-equiv="Pragma" content="no-cache">

  <meta http-equiv="Expires" content="now">
  
  

</head>

<body>
<!-- #include file = "hex_sha1_js.asp" -->
 <h1>Ödeme Sayfasi</h1>
    
    
    <h3> 3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre Ismi:</b></td>
            <td><b>Parametre Degeri:</b></td>
        </tr>
<%
	dim obj,ok,mdstatus,hashparams,hashparamsval,hash,index1,index2,storekey,hashparam,val,hashval,paramsval
	dim odemeparametreleri(5)
	ok = 1

	'hash kontrolu için gerekli parametreler
	
	storekey = "xxxxxx"
	index1 = 1
	index2 = 1
	hashparams = request.form("HASHPARAMS")
	hashparamsval = request.form("HASHPARAMSVAL") 
	hashparam = request.form("HASH")	

	paramsval = ""



	odemeparametreleri(0) = "AuthCode"
	odemeparametreleri(1) = "Response"
	odemeparametreleri(2) = "HostRefNum"
	odemeparametreleri(3) = "ProcReturnCode"
	odemeparametreleri(4) = "TransId"
	odemeparametreleri(5) = "ErrMsg"

	for each obj in request.form
		ok = 1
		for each item in odemeparametreleri
			if(item = obj) Then
				ok = 0
				exit for
			end if
		next
		if ok = 1 then
		response.write("<tr><td>"&obj & "</td><td>" & request.form(obj) & "</td></tr>")
		end if
	next
%>
	</table>
	<br>
	<br>

<%

	'hash kontrolu yapiliyor
	
	
	while index1 < Len(hashparams)
		
		
		
		index2 = InStr(index1,hashparams,":")

		
		xvalx = Mid(hashparams,index1,index2 - index1)
		
		val = request.form(xvalx)
		
		if val = null then
		val = ""
		end if
		paramsval = paramsval & val
		index1 = index2 + 1
	
	Wend
	
	hashval = paramsval & storekey 
	hash = b64_sha1(hashval)
	'response.write("hash=" & hash & "<br/>hashparam=" & hashparam &"<br>paramsval=" & paramsval &"<br>hashparamsval=" & hashparamsval )
	
	if hash <> hashparam or paramsval <> hashparamsval then
		response.write("<h4>Güvenlik Uyarisi. Sayisal Imza Geçerli Degil</h4>") 
	end if





	mdstatus = Request.Form("mdStatus")
	if mdstatus = 1 or mdstatus = 2  or mdstatus = 3 or mdstatus = 4 Then
%>
	<h5>3D Islemi Basarili</h5><br/>
                <h3> Ödeme Sonucu</h3>
                <table border="1">
                    <tr>
                        <td><b>Parametre Ismi</b></td>
                        <td><b>Parameter Degeri</b></td>
                    </tr>




<%
	for each item in odemeparametreleri
		response.Write("<tr><td>" & item &"</td><td>" & request.form(item) & "</td></tr>")
	next

%>

	</table>
	

<%
	if "Approved" = request.form("Response") Then
		Response.write("<h6>Ödeme Islemi Basarili</h6>")
	Else
		Response.write("<h6>Ödeme islemi Basarisiz</h6>")
	end if	



	else
		Response.Write("<h6>3D Onayi Alinamadi</h6>")

	end if



%>









</body>
</html>