Set pay = CreateObject("epayapi.payment")


'baglanti bilgileri
pay.name="sedat"
pay.password="TRps1000"
pay.clientid="7008"
pay.host="testsanalpos.est.com.tr"

'alisverisi yapanin ip'si
'pay.ip="192.169.0.30"

pay.OrderResult=0

'pay.oid="Sipariþ numarasý isteðe baðlý olarak boþ býrakalabilir."
pay.oid="00011111111111111111111111145"

pay.chargetype="Auth"
pay.cardnumber="5406681700000801"
pay.expmonth="10"
pay.expyear="09"
pay.cv2="000"

pay.subtotal="75"
pay.currency=949



retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"HostMsg: " & pay.Extra("HostMsg") & Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno

