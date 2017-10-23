<%@ page language="C#" autoeventwireup="true" inherits="_3DModel, App_Web_fr4klrwv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>3D Model</title>
</head>
<body>
<%
    //  AŞAĞIDA 3D SECURE İŞLEMİ İÇİN GEREKLİ ALANLAR VE KULLANIMLARI İLE ASP.NET KOD ÖRNEĞİ VERİLMİŞTİR. GİRİLEN DEĞERLER TEST AMAÇLI GİRİLMİŞTİR.
    //  3D MODEL ÜZERİNE DÜZENLENMİŞ KOD ÖRNEĞİDİR. İŞ YERLERİ KENDİ DEĞERLERİYLE DEĞİŞKENLERİ TANIMLAMALIDIR. 
    //  İŞ YERLERİNE REFERANS AMAÇLI OLUŞTURULMUŞTUR.
        
    
        /********************         GEREKLİ PARAMETRELER            ******************/
        
        String clientId = "XXXXXXXX";  //Banka tarafından mağazaya verilen iş yeri numarası
        String amount = "9.95";         //İşlem tutarı
        String oid = "";                //Sipariş numarası         
        String okUrl = "http://<sunucu_adresi>/odemesayfasi3dmodel.aspx";    //İşlem başarılıysa dönülecek işyeri sayfası  (3D işleminin sonucu ödeme işleminin değil)
        String failUrl = "http://<sunucu_adresi>/odemesayfasi3dmodel.aspx";  //İşlem başarısızsa dönülecek işyeri sayfası  (3D işleminin sonucu ödeme işleminin değil)
        String rnd = DateTime.Now.ToString();        //Güvenlik ve kontrol amaçlı tarih yada sürekli değişen bir değer
        
        
        String storekey="xxxxxx";                    //işyeri anahtarı
        String storetype = "3d";
        String hashstr = clientId + oid + amount + okUrl + failUrl  + rnd + storekey;  
        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
        byte[] inputbytes = sha.ComputeHash(hashbytes);
       
        String hash = Convert.ToBase64String(inputbytes);   //Günvelik amaçlı oluşturulan hash
        
        /******************          GEREKLİ PARAMETRELER             *********************/

        /***************       ISTEĞE BAĞLI ALANLAR    *********************************/
        String description = ""; //Açıklama
        String xid = "";    //İşlem takip numarası 3D için XID i mağaza üretirse o kullanir, yoksa sistem üretiyor. (3D secure işlemleri için işlem takip numarası 20 bytelik bilgi 28 karaktere base64 olarak kodlanmalı, geçersiz yada boş ise sistem tarafından üretilir.)
        String lang = "";     //gösterim dili boş ise Türkçe (tr), İngilizce için (en)
        String email = "";    //email adresi
        String userid = "";   //Kullanıcı takibi için id
        /***************       ISTEĞE BAĞLI ALANLAR     ********************************/
        
            
    
    %>
   <center>
            <form method="post" action="https://<sunucu_adresi>/<3dgate_path>">
                <table>
                    <tr>
                        <td>Kredi Kart Numarası:</td>
                        <td><input type="text" name="pan" size="20"/>
                    </tr>
                    
                    <tr>
                        <td>Güvenlik Kodu:</td>
                        <td><input type="text" name="cv2" size="4" value=""/></td>
                    </tr>
                    
                    <tr>
                        <td>Son Kullanma Yılı:</td>
                        <td><input type="text" name="Ecom_Payment_Card_ExpDate_Year" value=""/></td>
                    </tr>
                    
                    <tr>
                        <td>Son Kullanma Ayı:</td>
                        <td><input type="text" name="Ecom_Payment_Card_ExpDate_Month" value=""/></td>
                    </tr>
                    
                    <tr>
                        <td>Visa/MC secimi</td>
                        <td><select name="cardType">
                            <option value="1">Visa</option>
                            <option value="2">MasterCard</option>
                        </select>
                    </tr>
                    
                    <tr>
                        <td align="center" colspan="2">
                            <input type="submit" value="Ödemeyi Tamamla"/>
                        </td>
                    </tr>
                    
                </table>
                <input type="hidden" name="clientid" value="<%=clientId%>">
                <input type="hidden" name="amount" value="<%=amount%>">
                <input type="hidden" name="oid" value="<%=oid%>">	
                <input type="hidden" name="okUrl" value="<%=okUrl%>">
                <input type="hidden" name="failUrl" value="<%=failUrl%>">
                <input type="hidden" name="rnd" value="<%=rnd%>" >
                <input type="hidden" name="hash" value="<%=hash%>" >
                
                <input type="hidden" name="storetype" value="3d" >		
                <input type="hidden" name="lang" value="tr">
				<input type="hidden" name="currency" value="949">
                
                
            </form>
            <br>
            <b>Kullanılan Hidden Parametreler</b>
            <br>
            
            &lt;input type="hidden" name="clientid" value=""&gt;<br>
                &lt;input type="hidden" name="amount" value=""&gt;<br>
                &lt;input type="hidden" name="oid" value=""&gt;	<br>
                &lt;input type="hidden" name="okUrl" value=""&gt;<br>
                &lt;input type="hidden" name="failUrl" value=""&gt;<br>
                &lt;input type="hidden" name="rnd" value="" &gt;<br>
                &lt;input type="hidden" name="hash" value="" &gt;<br>
                
                &lt;input type="hidden" name="storetype" value="" &gt;	<br>	
                &lt;input type="hidden" name="lang" value=""&gt;<br>
        </center>
</body>
</html>
