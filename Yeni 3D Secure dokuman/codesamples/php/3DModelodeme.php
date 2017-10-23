<html>
<head>
<title>3D</title>
<meta http-equiv="Content-Language" content="tr">

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

  <meta http-equiv="Pragma" content="no-cache">

  <meta http-equiv="Expires" content="now">
  
  

</head>

<body>

<h1>3D Ödeme Sayfasi</h1>
    
    
<h3>3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre Ismi</b></td>
            <td><b>Parametre Degeri</b></td>
        </tr>
<?php

	foreach($_POST as $key => $value)
{
	echo "<tr><td>".$key."</td><td>".$value."</td></tr>";
}

?>

</table>
<br>
<br>


<?php

 /* Yollanan hash ve gelen parametrelerle yeni olusturulan hash kontrol ediliyor */	


	 $hashparams = $_POST["HASHPARAMS"];
    	 $hashparamsval = $_POST["HASHPARAMSVAL"];
	 $hashparam = $_POST["HASH"];
         $storekey="xxxxxx";
         $paramsval="";
         $index1=0;
	 $index2=0;

	 while($index1 < strlen($hashparams))
	 {
   		$index2 = strpos($hashparams,":",$index1);
		$vl = $_POST[substr($hashparams,$index1,$index2- $index1)];
		if($vl == null)
		$vl = "";
 		$paramsval = $paramsval . $vl; 
		$index1 = $index2 + 1;
	}
	$storekey = "xxxxxx";
	$hashval = $paramsval.$storekey;


	

	$hash = base64_encode(pack('H*',sha1($hashval)));
	
	if($paramsval != $hashparamsval || $hashparam != $hash) 	
		echo "<h4>Güvenlik Uyarisi. Sayisal Imza Geçerli Degil</h4>";







//             ÖDEME ISLEMI ALANLARI


$name="XXXXXXXX";       		//is yeri kullanic adi
$password="xxxxxxxxx";    		//Is yeri sifresi
$clientid=$_POST["clientid"];  		//Is yeri numarasi

$mode = "P";                            //P olursa gerçek islem, T olursa test islemi yapar
$type="Auth";   			//Auth: Satış PreAuth: Ön Otorizasyon
$expires = $_POST["Ecom_Payment_Card_ExpDate_Month"]."/".$_POST["Ecom_Payment_Card_ExpDate_Year"]; //Kredi Karti son kullanim tarihi mm/yy formatindan olmali
$cv2=$_POST['cv2'];                     //Kart guvenlik kodu
$tutar=$_POST["amount"];                // Islem tutari
$taksit="";           			//Taksit sayisi Pesin satislarda bos gonderilmelidir, "0" gecerli sayilmaz.
$oid= $_POST['oid'];			//Siparis numarasy her islem icin farkli olmalidir ,
                                        //bos gonderilirse sistem bir siparis numarasi üretir.






$lip=GetHostByName($REMOTE_ADDR);  	//Son kullanici IP adresi
$email="";  				//Email



                                    //Provizyon alinamadigi durumda taksit sayisi degistirilirse sipari numarasininda
                                    //degistirilmesi gerekir.
$mdStatus=$_POST['mdStatus'];       // 3d Secure işleminin sonucu mdStatus 1,2,3,4 ise başarılı 5,6,7,8,9,0 başarısızdır
                                    // 3d Decure işleminin sonucu başarısız ise işlemi provizyona göndermeyiniz (XML göndermeyiniz).
$xid=$_POST['xid'];                 // 3d Secure özel alani PayerTxnId
$eci=$_POST['eci'];                 // 3d Secure özel alani PayerSecurityLevel
$cavv=$_POST['cavv'];               // 3d Secure özel alani PayerAuthenticationCode
$md=$_POST['md'];                   // Eğer 3D işlembaşarılısya provizyona kart numarası yerine md değeri gönderilir.
                                    // Son kullanma tarihi ve cvv2 gönderilmez.


if($mdStatus =="1" || $mdStatus == "2" || $mdStatus == "3" || $mdStatus == "4")
{ 	
	echo "<h5>3D Islemi Basarili</h5><br/>";

	// XML request sablonu
	$request= "DATA=<?xml version=\"1.0\" encoding=\"ISO-8859-9\"?>".
	"<CC5Request>".
	"<Name>{NAME}</Name>".
	"<Password>{PASSWORD}</Password>".
	"<ClientId>{CLIENTID}</ClientId>".
	"<IPAddress>{IP}</IPAddress>".
	"<Email>{EMAIL}</Email>".
	"<Mode>P</Mode>".
	"<OrderId>{OID}</OrderId>".
	"<GroupId></GroupId>".
	"<TransId></TransId>".
	"<UserId></UserId>".
	"<Type>{TYPE}</Type>".
	"<Number>{MD}</Number>".
	"<Expires></Expires>".
	"<Cvv2Val></Cvv2Val>".
	"<Total>{TUTAR}</Total>".
	"<Currency>949</Currency>".
	"<Taksit>{TAKSIT}</Taksit>".
	"<PayerTxnId>{XID}</PayerTxnId>".
	"<PayerSecurityLevel>{ECI}</PayerSecurityLevel>".
	"<PayerAuthenticationCode>{CAVV}</PayerAuthenticationCode>".
	"<CardholderPresentCode>13</CardholderPresentCode>".
	"<BillTo>".
	"<Name></Name>".
	"<Street1></Street1>".
	"<Street2></Street2>".
	"<Street3></Street3>".
	"<City></City>".
	"<StateProv></StateProv>".
	"<PostalCode></PostalCode>".
	"<Country></Country>".
	"<Company></Company>".
	"<TelVoice></TelVoice>".
	"</BillTo>".
	"<ShipTo>".
	"<Name></Name>".
	"<Street1></Street1>".
	"<Street2></Street2>".
	"<Street3></Street3>".
	"<City></City>".
	"<StateProv></StateProv>".
	"<PostalCode></PostalCode>".
	"<Country></Country>".
	"</ShipTo>".
	"<Extra></Extra>".
	"</CC5Request>";


      $request=str_replace("{NAME}",$name,$request);


      $request=str_replace("{PASSWORD}",$password,$request);
      $request=str_replace("{CLIENTID}",$clientid,$request);
      $request=str_replace("{IP}",$lip,$request);
      $request=str_replace("{OID}",$oid,$request);
      $request=str_replace("{TYPE}",$type,$request);
      $request=str_replace("{XID}",$xid,$request);
      $request=str_replace("{ECI}",$eci,$request);
      $request=str_replace("{CAVV}",$cavv,$request);
      $request=str_replace("{MD}",$md,$request);
      $request=str_replace("{TUTAR}",$tutar,$request);
      $request=str_replace("{TAKSIT}",$taksit,$request);


     

	// Sanal pos adresine baglanti kurulmasi
	
        $url = "https://<sunucu_adresi>/<apiserver_path>";  //TEST

		$ch = curl_init();    // initialize curl handle
		
		curl_setopt($ch, CURLOPT_URL,$url); // set url to post to
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,1);
		curl_setopt($ch, CURLOPT_SSLVERSION, 3);
		
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,0);
		
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
		curl_setopt($ch, CURLOPT_TIMEOUT, 90); // times out after 90s
		curl_setopt($ch, CURLOPT_POSTFIELDS, $request); // add POST fields



        // Buraya mdStatusa göre bir kontrol koymalisiniz.
        // 3d Secure işleminin sonucu mdStatus 1,2,3,4 ise başarılı 5,6,7,8,9,0 başarısızdır
        // 3d Decure işleminin sonucu başarısız ise işlemi provizyona göndermeyiniz (XML göndermeyiniz).

		$result = curl_exec($ch); // run the whole process
//echo htmlspecialchars($result);
echo "<br>";

       if (curl_errno($ch)) {
           print curl_error($ch);
       } else {
           curl_close($ch);
       }


 $Response ="";
 $OrderId ="";
 $AuthCode  ="";
 $ProcReturnCode    ="";
 $ErrMsg  ="";
 $HOSTMSG  ="";
 $HostRefNum = "";
 $TransId="";

$response_tag="Response";
$posf = strpos (  $result, ("<" . $response_tag . ">") );
$posl = strpos (  $result, ("</" . $response_tag . ">") ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$Response = substr (  $result, $posf, $posl - $posf) ;

$response_tag="OrderId";
$posf = strpos (  $result, ("<" . $response_tag . ">") );
$posl = strpos (  $result, ("</" . $response_tag . ">") ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$OrderId = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="AuthCode";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$AuthCode = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="ProcReturnCode";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$ProcReturnCode = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="ErrMsg";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$ErrMsg = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="HostRefNum";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$HostRefNum = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="TransId";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$$TransId = substr (  $result, $posf , $posl - $posf   ) ;


//echo $Response;
//echo $ProcReturnCode;

?>
			<h3>Ödeme Sonucu</h3>
                <table border="1">
                    <tr>
                        <td><b>Parameter Ismi:</b></td>
                        <td><b>Parameter Degeri</b></td>
                    </tr>
                    
                    <tr>
                        <td>AuthCode</td>
                        <td><?php echo $AuthCode; ?></td>
                    </tr>
                    
                    <tr>
                        <td>Response</td>
                        <td><?php echo $Response; ?></td>
                    </tr>
                    
                    <tr>
                        <td>HostRefNum</td>
                        <td><?php echo $HostRefNum;?></td>
                    </tr>
                    
                    <tr>
                        <td>ProcReturnCode</td>
                        <td><?php echo $ProcReturnCode?></td>
                    </tr>
                    
                    <tr>
                        <td>TransId</td>
                        <td><?php echo $TransId ?></td>
                    </tr>
                    
                    <tr>
                        <td>ErrMsg</td>
                        <td><?php echo $ErrMsg?></td>
                    </tr>
                    
                </table>

<?php


if ( $Response === "Approved")
{

	  echo "Ödeme isleminiz basariyla gerçeklestirildi";
  



}
else
{
         echo "Ödeme isleminiz basariyla gerçeklestirilmedi.Hata=".$ErrMsg;
    
}

}
else{
	echo "3D islemi onay almadi";
}





?>



</body>
</html>