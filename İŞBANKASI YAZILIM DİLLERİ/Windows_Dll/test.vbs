msgbox("Ýþbankasý Sanal POS test'e baþlamak için týklayýnýz..." & Chr(13) & Chr(13) & "(iþlem 20 saniye kadar sürebilir)")

wscript.echo "Lütfen bekleyiniz..."

Set pay = CreateObject("epayapi.payment")


'Asagidaki bilgiler test icindir gercek islem icin bankadan gonderilen bilgileri kullanmalýsýnýz
pay.name="isbank2"
pay.password="isbank2"
pay.clientid="7777"
pay.host="testsanalpos.est.com.tr"


'Test yapmak icin host="testsanalpos.est.com.tr" gercek islem icin host="sanalpos.isbank.com.tr" olmalýdýr

host="testsanalpos.est.com.tr"

pay.host=host

pay.OrderResult=0
pay.chargetype="PreAuth"
pay.cardnumber= "4242424242424242"
pay.expmonth="01"
pay.expyear="09"
pay.cv2="000"
pay.subtotal="12.04"
pay.currency=949
pay.transid=""
pay.groupid=""
retval=pay.processorder



If (pay.Appr = "Approved") Then
    retApprCode = pay.code
' geridonus degerleri aliniyor
retOid = pay.oid
end if


if pay.err = "00" Then
	myStr = ""
	myStr = myStr & "Test iþlemi baþarýyla sona erdi." & Chr(13)
	myStr = myStr & "" & Chr(13)
	myStr = myStr & "VBScript dosyasý Ýþbankasý SanalPOS ile baðlantý kurabiliyor." & Chr(13)
	myStr = myStr & "" & Chr(13)
	myStr = myStr & "Sunucu üzerinden çaðýrýlan COM nesnesi farklý þekilde çalýþtýðýndan" & Chr(13)
	myStr = myStr & "test.asp 'yi çalýþtýrarak test'i tamamlamanýzý öneririz." & Chr(13)
	msgbox(myStr)
Else
	myStr = ""
	myStr = myStr & "Sunucunuz "&host&" adresine" & Chr(13)
	myStr = myStr & "443 no'lu port üzerinden baðlantý kuramýyor!" & Chr(13)
	myStr = myStr & "" & Chr(13)
	myStr = myStr & "Lütfen register ettiðiniz COM nesnesinin" & Chr(13)
	myStr = myStr & "bu adrese eriþmek için yeterli yetkilere" & Chr(13)
	myStr = myStr & "sahip olup olmadýðýný kontrol ediniz." & Chr(13)
	myStr = myStr & "" & Chr(13)
	myStr = myStr & "Daha detaylý bilgi için Sanal POS" & Chr(13)
	myStr = myStr & "bilgi dokümanýný incelemenizi tavsiye ederiz." & Chr(13)
	msgbox(myStr)
End if