<html>
<head>
<title>3D</title>
<meta http-equiv="Content-Language" content="tr">

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

  <meta http-equiv="Pragma" content="no-cache">

  <meta http-equiv="Expires" content="now">
  
  

</head>

<body>

<?php

//  ASAGIDA 3D SECURE ISLEMI IÇIN GEREKLI ALANLAR VE KULLANIMLARI ILE PHP KOD ÖRNEGI VERILMISTIR. GIRILEN DEGERLER TEST AMAÇLI GIRILMISTIR.
//  3D MODEL ÜZERINE DÜZENLENMIS KOD ÖRNEGIDIR. IS YERLERI KENDI DEGERLERIYLE DEGISKENLERI TANIMLAMALIDIR. 
//  IS YERLERINE REFERANS AMAÇLI OLUSTURULMUSTUR.

// 3D secure için gerekli alanlar 3d modelinde asagidaki alanlar ile birlikte formda yollanan alanlardir. 
// Form disindaki alanlarin hidden text olarak post gerekmektedir. 


//          GEREKLI ALANLAR



$clientId = "XXXXXXXX";    //Banka tarafindan verilen is yeri numarasi
$amount = "9.95";           //Islem tutari
$oid = "";         //Siparis numarasi

$okUrl = "http://<magaza_sunucu_adresi>/3DModelodeme.php";        //Islem basariliysa dönülecek isyeri sayfasi  (3D isleminin sonucu, ödeme isleminin degil)
$failUrl = "http://<magaza_sunucu_adresi>/3DModelodeme.php";      //Islem basarisiz ise dönülecek isyeri sayfasi (3D isleminin sonucu, ödeme isleminin degil)

$rnd = microtime();            //Tarih veya her seferinde degisen bir deger güvenlik amaçli
//$rnd = "x";

$storekey = "xxxxxx";          //is yeri ayiraci (is yeri anahtari)
$storetype = "3d";             //3D modeli


// 3D modelinde hash hesaplamasinda islem tipi ve taksit kullanilmiyor

$hashstr = $clientId . $oid . $amount . $okUrl . $failUrl . $rnd  . $storekey;

//echo $hashstr;

$hash = base64_encode(pack('H*',sha1($hashstr)));

//         GEREKLI ALANLAR




//      ISTEGE BAGLI ALANLAR    

$description = ""; //Açiklama
$xid = "";    //Islem takip numarasi 3D için XID i magaza üretirse o kullanir, yoksa sistem üretiyor. (3D secure islemleri için islem takip numarasi 20 bytelik bilgi 28 karaktere base64 olarak kodlanmali, geçersiz yada bos ise sistem tarafindan üretilir.)
$lang="";     //gösterim dili bos ise Türkçe (tr), Ingilizce için (en)
$email="";    //email adresi
$userid="";   //Kullanici takibi için id

//       ISTEGE BAGLI ALANLAR    
        
//  FORMDA YER ALAN ALANLAR KART SAHIBININ KART BILGILERINI GIRDIGI GEREKLI ALANLARDIR 


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
                
                <input type="hidden" name="storetype" value="3d" >		
                <input type="hidden" name="lang" value="tr">
				<input type="hidden" name="currency" value="949">
                
               
            </form>
            <br>
            <b>Kullanilan Hidden Parametreler</b>
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