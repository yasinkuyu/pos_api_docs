Set pay = CreateObject("epayapi.payment")

'baglanti bilgileri
pay.name="isbank2"
pay.password="isbank2"
pay.clientid="7777"
pay.host="testsanalpos.est.com.tr"

pay.OrderResult=0

pay.oid="170303distest0042"

pay.chargetype="Credit"
'pay.cardnumber="4999560000015253"
'pay.expmonth="12"
'pay.expyear="03"
'pay.cv2="001"

'pay.subtotal="2.5"
'pay.currency=949

retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"HostMsg: " & pay.Extra("HostMsg") & Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno
