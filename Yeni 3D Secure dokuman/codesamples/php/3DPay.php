<html>
<head>
<title>3D PAY</title>
<meta http-equiv="Content-Language" content="tr">

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

  <meta http-equiv="Pragma" content="no-cache">

  <meta http-equiv="Expires" content="now">
  
  

</head>

<body>

<?php
//  ASAGIDA 3D SECURE ISLEMI IÇIN GEREKLI ALANLAR VE KULLANIMLARI ILE PHP KOD ÖRNEGI VERILMISTIR. GIRILEN DEGERLER TEST AMAÇLI GIRILMISTIR.
//  3D PAY MODEL ÜZERINE DÜZENLENMIS KOD ÖRNEGIDIR. IS YERLERI KENDI DEGERLERIYLE DEGISKENLERI TANIMLAMALIDIR. 
//  IS YERLERINE REFERANS AMAÇLI OLUSTURULMUSTUR.

// 3D secure için gerekli alanlar 3d modelinde asagidaki alanlar ile birlikte formda yollanan alanlardir. 
// Form disindaki alanlarin hidden text olarak post gerekmektedir. 




$clientId = "XXXXXXXX";  //Banka tarafindan verilen isyeri numarasi
$amount = "9.95";         //Islem tutari
$oid = "";      //Siparis Numarasi

$okUrl = "http://<sunucu_adresi>/3DPayOdeme.php";    //Islem basariliysa dönülecek isyeri sayfasi  (3D isleminin ve ödeme isleminin sonucu)
$failUrl = "http://<sunucu_adresi>/3DPayOdeme.php";  //Islem basarizsa dönülecek isyeri sayfasi  (3D isleminin ve ödeme isleminin sonucu)

$rnd = microtime();    //Tarih veya her seferinde degisen bir deger güvenlik amaçli
$taksit = "";         //taksit sayisi
$islemtipi="Auth";     //Islem tipi
$storekey = "xxxxxx";  //isyeri anahtari

// hash hesabinda taksit ve islemtipi de kullanilir.

$hashstr = $clientId . $oid . $amount . $okUrl . $failUrl .$islemtipi. $taksit  .$rnd . $storekey;


$hash = base64_encode(pack('H*',sha1($hashstr)));



// Form parametrelerinde ve input degerlerde 3d ve ödeme için gerekli alanlar bulunur.
//3d onayi ve ödeme sistem tarafindan yapilacaktir. 
?>

<center>
            <form method="post" action="https://<sunucu_adresi>/<3dgate_path>">
                <table>
                    <tr>
                        <td>Kredi Kart Numarasi:</td>
                        <td><input type="text" name="pan" size="20"/>
                    </tr>
                    
                    <tr>
                        <td>Güvenlik Kodu:</td>
                        <td><input type="text" name="cv2" size="4" value=""/></td>
                    </tr>
                    
                    <tr>
                        <td>Son Kullanma Yili:</td>
                        <td><input type="text" name="Ecom_Payment_Card_ExpDate_Year" value=""/></td>
                    </tr>
                    
                    <tr>
                        <td>Son Kullanma Ayi:</td>
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
                <input type="hidden" name="clientid" value="<?php  echo $clientId ?>">
		
                <input type="hidden" name="amount" value="<?php  echo $amount ?>">
                <input type="hidden" name="oid" value="<?php  echo $oid ?>">	
                <input type="hidden" name="okUrl" value="<?php  echo $okUrl ?>">
                <input type="hidden" name="failUrl" value="<?php  echo $failUrl ?>">
                <input type="hidden" name="rnd" value="<?php  echo $rnd ?>" >
                <input type="hidden" name="hash" value="<?php  echo $hash ?>" >
		<input type="hidden" name="islemtipi" value="<?php echo $islemtipi ?>" >
		<input type="hidden" name="taksit" value="<?php echo $taksit ?>" >
                
                <input type="hidden" name="storetype" value="3d_pay" >	
                
                <input type="hidden" name="lang" value="tr">
				<input type="hidden" name="currency" value="949">
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
                
            </form>
            <b>Kullanilan Hidden Parametreler</b>
            <br>
            &lt;input type="hidden" name="clientid" value=""&gt;<br>
            &lt;input type="hidden" name="amount" value=""&gt;<br>
            &lt;input type="hidden" name="oid" value=""&gt;	<br>
            &lt;input type="hidden" name="okUrl" value=""&gt;<br>
            &lt;input type="hidden" name="failUrl" value=""&gt;<br>
            &lt;input type="hidden" name="rnd" value="" &gt;<br>
            &lt;input type="hidden" name="hash" value="" &gt;<br>
            
            &lt;input type="hidden" name="storetype" value="3d_pay" &gt;<br>	
            
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