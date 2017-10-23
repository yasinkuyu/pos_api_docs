<%@page contentType="text/html;charset=ISO-8859-9"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
        <title>3D Hosting</title>
    </head>
    <body>
        <%
        //  AŞAĞIDA 3D SECURE İŞLEMİ İÇİN GEREKLİ ALANLAR VE KULLANIMLARI İLE JAVA KOD ÖRNEĞİ VERİLMİŞTİR. GİRİLEN DEĞERLER TEST AMAÇLI GİRİLMİŞTİR.
        //  3D PAY HOSTING MODEL ÜZERİNE DÜZENLENMİŞ KOD ÖRNEĞİDİR. İŞ YERLERİ KENDİ DEĞERLERİYLE DEĞİŞKENLERİ TANIMLAMALIDIR. 
        //  İŞ YERLERİNE REFERANS AMAÇLI OLUŞTURULMUŞTUR.
        
        
        /************************     GEREKLİ ALANLAR       *****************/
        
        String clientId = "XXXXXXXX";     //Banka tarafından verilen işyeri numarası
        String amount = "9.95";            //İşlem tutarı
        String oid = "";                   //Sipariş numarası
        String okUrl = "http://<magaza_sunucu_sayfası>/3dpayosting/odemesayfasi.jsp";    //İşlem başarılıysa dönülecek işyeri sayfası  (3D işleminin ve ödeme işleminin sonucu)
        String failUrl = "http://<magaza_sunucu_sayfası>/3dpayhosting/odemesayfasi.jsp";  //İşlem başarısızsa dönülecek işyeri sayfası  (3D işleminin ve ödeme işleminin sonucu)
        String rnd = new java.util.Date().toString();                         // Tarih veya her seferinde değişen bir değer güvenlik amaçlı kullanılıyor
        
        
        String taksit = "";                         //Taksit sayısı
        String islemtipi = "Auth";                  //İşlem tipi
        String storekey="xxxxxx";                   //işyeri anahtarı
        
        String hashstr = clientId + oid + amount + okUrl + failUrl + islemtipi + taksit + rnd + storekey;
        java.security.MessageDigest sha1 = java.security.MessageDigest.getInstance("SHA-1");
        
        String hash = (new sun.misc.BASE64Encoder()).encode(sha1.digest(hashstr.getBytes()));   //Kontrol ve güvenlik için gerekli hashli bilgi
        
        
        %>
   
        <center>
            <form method="post" action="https://<sunucu_adresi>/<3dgate_path>">
                <input type="hidden" name="clientid" value="<%=clientId%>">
                <input type="hidden" name="amount" value="<%=amount%>">

                <input type="hidden" name="oid" value="<%=oid%>">	
                <input type="hidden" name="okUrl" value="<%=okUrl%>" >
                <input type="hidden" name="failUrl" value="<%=failUrl%>" >
                <input type="hidden" name="islemtipi" value="<%=islemtipi%>" >
                <input type="hidden" name="taksit" value="<%=taksit%>">
                <input type="hidden" name="rnd" value="<%=rnd%>" >
                <input type="hidden" name="hash" value="<%=hash%>" >
	
                <input type="hidden" name="storetype" value="3d_pay_hosting" >
	
                <input type="hidden" name="refreshtime" value="10" >
		
                <input type="hidden" name="lang" value="tr">
                <input type="hidden" name="firmaadi" value="Benim Firmam">
	
                <input type="hidden" name="Fismi" value="is">
                <input type="hidden" name="faturaFirma" value="faturaFirma">
                <input type="hidden" name="Fadres" value="XXX">
                <input type="hidden" name="Fadres2" value="XXX">
                <input type="hidden" name="Fil" value="XXX">

                <input type="hidden" name="Filce" value="XXX">
                <input type="hidden" name="Fpostakodu" value="postakod93013">
                <input type="hidden" name="tel" value="XXX">
                <input type="hidden" name="fulkekod" value="tr">

                <input type="hidden" name="nakliyeFirma" value="na fi">
                <input type="hidden" name="tismi" value="XXX">
                <input type="hidden" name="tadres" value="XXX">
                <input type="hidden" name="tadres2" value="XXX">

                <input type="hidden" name="til" value="XXX">
                <input type="hidden" name="tilce" value="XXX">
                <input type="hidden" name="tpostakodu" value="ttt postakod93013">
                <input type="hidden" name="tulkekod" value="usa">
	
                <input type="hidden" name="itemnumber1" value="a1">
                <input type="hidden" name="productcode1" value="a2">
                <input type="hidden" name="qty1" value="3">
                <input type="hidden" name="desc1" value="a4 desc">
                <input type="hidden" name="id1" value="a5">

                <input type="hidden" name="price1" value="6.25">
                <input type="hidden" name="total1" value="7.50">
                
                <input type="submit" value="Devam" />
                
            </form>
            
            <b>Kullanılan Hidden Parametreler</b>
            <br>
                
                &lt;input type="hidden" name="clientid" value=""&gt;<br>
                &lt;input type="hidden" name="amount" value=""&gt;<br>

                &lt;input type="hidden" name="oid" value="hla56bu"&gt;	<br>
                &lt;input type="hidden" name="okUrl" value="" &gt;<br>
                &lt;input type="hidden" name="failUrl" value="" &gt;<br>
                &lt;input type="hidden" name="islemtipi" value="" &gt;<br>
                &lt;input type="hidden" name="taksit" value=""&gt;<br>
                &lt;input type="hidden" name="rnd" value="" &gt;<br>
                &lt;input type="hidden" name="hash" value="" &gt;<br>
	
                &lt;input type="hidden" name="storetype" value="3d_pay_hosting" &gt;<br>
	
                &lt;input type="hidden" name="refreshtime" value="" &gt;<br>
		
                &lt;input type="hidden" name="lang" value=""&gt;<br>
                &lt;input type="hidden" name="firmaadi" value=""&gt;<br>
	
                &lt;input type="hidden" name="Fismi" value=""&gt;<br>
                &lt;input type="hidden" name="faturaFirma" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres2" value=""&gt;<br>
                &lt;input type="hidden" name="Fil" value=""&gt;<br>

                &lt;input type="hidden" name="Filce" value=""&gt;<br>
                &lt;input type="hidden" name="Fpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tel" value=""&gt;<br>
                &lt;input type="hidden" name="fulkekod" value=""&gt;<br>

                &lt;input type="hidden" name="nakliyeFirma" value=""&gt;<br>
                &lt;input type="hidden" name="tismi" value=""&gt;<br>
                &lt;input type="hidden" name="tadres" value=""&gt;<br>
                &lt;input type="hidden" name="tadres2" value=""&gt;<br>

                &lt;input type="hidden" name="til" value=""&gt;<br>
                &lt;input type="hidden" name="tilce" value=""&gt;<br>
                &lt;input type="hidden" name="tpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tulkekod" value=""&gt;<br>
	
                &lt;input type="hidden" name="itemnumber1" value=""&gt;<br>
                &lt;input type="hidden" name="productcode1" value=""&gt;<br>
                &lt;input type="hidden" name="qty1" value=""&gt;<br>
                &lt;input type="hidden" name="desc1" value=""&gt;<br>
                &lt;input type="hidden" name="id1" value=""&gt;<br>

                &lt;input type="hidden" name="price1" value=""&gt;<br>
                &lt;input type="hidden" name="total1" value=""&gt;<br>
                
               
            
        </center>
    </body>
</html>
