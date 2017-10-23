Set pay = CreateObject("epayapi.payment")

'baglanti bilgileri
pay.name="isbank2"
pay.password="isbank2"
pay.clientid="7777"
pay.host="testsanalpos.est.com.tr"

pay.OrderResult=0

pay.oid="03042003distest0003"
pay.chargetype="Credit"

'pay.subtotal="12.14"
'pay.currency=949

retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"HostMsg: " & pay.Extra("HostMsg") & Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno
