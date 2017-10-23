<html>
<head>
<title>3D</title>
<meta http-equiv="Content-Language" content="tr">

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

  <meta http-equiv="Pragma" content="no-cache">

  <meta http-equiv="Expires" content="now">
  
  

</head>

<body>
<!-- #include file = "hex_sha1_js.asp" -->
<%


' Ödeme islemi alanlari
Dim name,password,clientid,lip,email,oid,optype,tutar,cv2,taksit,mdStatus,xid,eci,cavv,md,req,ox,mode,obj,hashparams,hashparamsval,hash,index1,index2,storekey,hashparam,val,hashval,paramsval

'hash kontrolu için gerekli parametreler
storekey = "XXXXXX"
index1 = 1
index2 = 1
hashparams = request.form("HASHPARAMS")
hashparamsval = request.form("HASHPARAMSVAL") 
hashparam = request.form("HASH")	

paramsval = ""


%>
<h1>3D Ödeme Sayfasi</h1>
    
    
<h3>3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre Ismi</b></td>
            <td><b>Parametre Degeri</b></td>
        </tr>
<%

	for each obj in request.form
		response.write("<tr><td>" & obj &"</td><td>" & request.form(obj) & "</td></tr>")
	next

%>
</table>
<br/>
<br/>








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








name="XXXXXXXX"       				'Sanal pos api kullanic adi
password="xxxxxxxx"    			'Sanal pos api kullanicisi sifresi
clientid=request.form("clientid")  	        'Sanal pos magaza numarasi
lip= Request.Servervariables("REMOTE_HOST") 	'Son kullanici IP adresi
email=""  				        'Email
oid= ""		                                'Siparis numarasy her islem icin farkli olmalidir ,
                                    		'bos gonderilirse sistem bir siparis numarasi üretir.
optype="Auth"   					'Auth: Satış PreAuth: Ön Otorizasyon
tutar=request.form("amount")  			'Kurus ayyraci olarak "." kullanylmalydyr.
cv2=request.form("cv2")                 	'Kart guvenlik kodu
taksit=""           				'Taksit sayisi Pe?in saty?larda bo? gonderilmelidir, "0" gecerli sayilmaz.
                                    		'Provizyon alinamadigi durumda taksit sayisi degistirilirse sipari numarasininda
                                    		'degistirilmesi gerekir.
mdStatus=request.form("mdStatus")       	'3d Secure işleminin sonucu mdStatus 1,2,3,4 ise başarılı 5,6,7,8,9,0 başarısızdır
                                    		'3d Decure işleminin sonucu başarısız ise işlemi provizyona göndermeyiniz (XML göndermeyiniz).
xid=request.form("xid")                 	'3d Secure özel alani PayerTxnId
eci=request.form("eci")                 	'3d Secure özel alani PayerSecurityLevel
cavv=request.form("cavv")               	'3d Secure özel alani PayerAuthenticationCode
md=request.form("md")                   	'Eğer 3D işlembaşarılısya provizyona kart numarası yerine md değeri gönderilir.
                                    		'Son kullanma tarihi ve cvv2 gönderilmez.

mode = "P"                                      'T ise test, P ise gerçek islem

if(mdStatus = 1 or mdStatus = 2 or mdStatus = 3 or mdStatus = 4) Then

	
	Response.write("<h5>3D Islemi Basarili</h5><br/>")
	
	' XML request sablonu
	req="<?xml version=""1.0"" encoding=""ISO-8859-9""?><CC5Request><Name>{NAME}</Name><Password>{PASSWORD}</Password><ClientId>{CLIENTID}</ClientId><IPAddress>{IP}</IPAddress><Email>{EMAIL}</Email><Mode>P</Mode>"&_
	"<OrderId>{OID}</OrderId><GroupId></GroupId><TransId></TransId><UserId></UserId><Type>{TYPE}</Type><Number>{MD}</Number><Expires></Expires><Cvv2Val></Cvv2Val><Total>{TUTAR}</Total>"&_
	"<Currency>949</Currency><Taksit>{TAKSIT}</Taksit><PayerTxnId>{XID}</PayerTxnId><PayerSecurityLevel>{ECI}</PayerSecurityLevel><PayerAuthenticationCode>{CAVV}</PayerAuthenticationCode><CardholderPresentCode>13</CardholderPresentCode><BillTo><Name></Name>"&_
	"<Street1></Street1><Street2></Street2><Street3></Street3><City></City><StateProv></StateProv><PostalCode></PostalCode><Country></Country><Company></Company><TelVoice></TelVoice></BillTo><ShipTo><Name></Name><Street1></Street1><Street2></Street2><Street3></Street3>"&_
	"<City></City><StateProv></StateProv><PostalCode></PostalCode><Country></Country></ShipTo><Extra></Extra></CC5Request>"






	'Degisken parametrelerin XML sablona yazilmasi

        req=Replace(req,"{NAME}",name)
      
        req=Replace(req,"{PASSWORD}",password)
        req=Replace(req,"{CLIENTID}",clientid)
        req=Replace(req,"{IP}",ip)
        req=Replace(req,"{OID}",oid)
        req=Replace(req,"{TYPE}",optype)
        req=Replace(req,"{XID}",xid)
        req=Replace(req,"{ECI}",eci)
        req=Replace(req,"{CAVV}",cavv)
        req=Replace(req,"{MD}",md)
        req=Replace(req,"{TUTAR}",tutar)
        req=Replace(req,"{TAKSIT}",taksit)
      
       
       post(req)               'ödeme için olusturulan xml post ediliyor. Ödeme gerçeklestiriliyor
       
%>

<script language="javascript" runat="server">

function post(x)
{
    var xmlhttp = new ActiveXObject("MSXML2.ServerXMLHTTP"); 
    xmlhttp.open("POST", "https://<sunucu_adresi>/<apiserver_path>", 0); 
    xmlhttp.send("DATA="+x); 
    //Response.Write(xmlhttp.responseText);

    var response =  getReply("Response",xmlhttp.responseText);
    var authcode = getReply("AuthCode",xmlhttp.responseText);
    var hostrefnum = getReply("HostRefNum",xmlhttp.responseText);
    var procreturncode = getReply("ProcReturnCode",xmlhttp.responseText);
    var transid = getReply("TransId",xmlhttp.responseText);
    var errmsg = getReply("ErrMsg",xmlhttp.responseText);

    Response.Write("<h3>Ödeme Sonucu</h3>" +
                 "<table border=1>" +
                 "<tr>" +
                 "<td><b>Parameter Ismi:</b></td>"+
                 "<td><b>Parameter Degeri</b></td>"+
                 "</tr>" +
                    
                 "<tr>" +
                 "<td>AuthCode</td>"+
                 "<td>"+authcode+"</td>"+
                 "</tr>"+
                    
                 "<tr>"+
                 "<td>Response</td>"+
                 "<td>"+response+"</td>"+
                 "</tr>"+
                    
                 "<tr>" +
                 "<td>HostRefNum</td>" +
                 "<td>"+hostrefnum+"</td>" +
                 "</tr>"+
                    
                 "<tr>" +
                 "<td>ProcReturnCode</td>" +
                 "<td>"+procreturncode+"</td>"+
                 "</tr>"+
                    
                 "<tr>" +
                 "<td>TransId</td>"+
                 "<td>"+transid +"</td>"+
                 "</tr>"+
                    
                 "<tr>"+
                 "<td>ErrMsg</td>"+
                 "<td>"+errmsg +"</td>"+
                 "</tr>"+
                    
                 "</table>");

	
    
    if(response =="Approved")
    {
	Response.Write("<br><p>Ödeme Bilgileriniz Onaylanmistir</p>");
	
    }
    else
    {
	
	Response.Write("<br><p>Ödeme Bilgileriniz Onaylanmamistir</p>");
    }
    

    
}
function getReply(value,coming)
{
	var xf = "<" + value + ">";
	var xs = "</" + value + ">";
	var index1 = coming.indexOf(xf);
	var index2 = coming.indexOf(xs);
	return coming.substring(index1 + value.length + 2,index2);

}
	




	
</script>

<%

Else
	Response.Write("<br><p>3D onayi alinamadi</p>")
	
End If
%>	
		












</body>
</html>