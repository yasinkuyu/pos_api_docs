Set pay = CreateObject("epayapi.payment")

pay.name="isbank2"
pay.password="isbank2"
pay.clientid="7777"


pay.ip=""
pay.host="testsanalpos.est.com.tr.est.com.tr"

pay.OrderResult=0

pay.oid=""
pay.groupid=""
pay.transid=""
pay.taksit=3

pay.userid="userid"

pay.chargetype="PreAuth"
pay.cardnumber="4242424242424242"
pay.expmonth="01"
pay.expyear="09"
pay.cv2="000"

pay.subtotal="12.14"
pay.currency=949




pay.bname="bname"
pay.Baddr1=""
pay.Baddr2=""
pay.Baddr3=""
pay.bcity=""
pay.bzip=332211
pay.bstate="B_STATE"

pay.sname="sname"
pay.saddr1=""
pay.saddr2=""
pay.saddr3=""
pay.scity="scity"
pay.szip=112233
pay.sstate="S_STATE"



retval=pay.processorder

msgbox "retval:" & retval
msgbox "OrderID:" & pay.oid
msgbox "GroupID:" & pay.GroupId
msgbox "TransID:" & pay.TransId
msgbox "appr:" & pay.appr
msgbox "retcode:" & pay.code
msgbox "err:" & pay.err
msgbox "errmsg:" & pay.errmsg


