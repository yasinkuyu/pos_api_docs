<%@page contentType="text/html;charset=ISO-8859-9"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.est.jpay"%>
<%@page import="java.util.Enumeration"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
        <title>3DModel Ödeme Sayfası</title>
    </head>
    <body>

    <h1>3D Ödeme Sayfası</h1>    
    <h3>3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre İsmi:</b></td>
            <td><b>Parametre Değeri:</b></td>
        </tr>
    <%
    	Enumeration enu = request.getParameterNames();
    	while (enu.hasMoreElements()) {
    		String param = (String) enu.nextElement();
    		String val = (String) request.getParameter(param);
    		out.println("<tr><td>" + param + "</td>" + "<td>" + val + "</td></tr>");
    	}
    %>
    </table>
    <br>
    <br>
    <%
    	String hashparams = request.getParameter("HASHPARAMS");
    	String hashparamsval = request.getParameter("HASHPARAMSVAL");
    	String storekey = "xxxxxx";
    	String paramsval = "";
    	int index1 = 0, index2 = 0;
    	// hash hesaplamada kullanılacak değerler ayrıştırılıp değerleri birleştiriliyor.
    	do {
    		index2 = hashparams.indexOf(":", index1);
    		String val = request.getParameter(hashparams.substring(index1,
    		index2)) == null ? "" : request.getParameter(hashparams
    		.substring(index1, index2));
    		paramsval += val;
    		index1 = index2 + 1;
    	} while (index1 < hashparams.length());

    	//out.println("hashparams="+hashparams+"<br/>");
    	//out.println("hashparamsval="+hashparamsval+"<br/>");
    	//out.println("paramsval="+paramsval+"<br/>");
    	String hashval = paramsval + storekey; //elde edilecek hash değeri için paramsval e store key ekleniyor. (işyeri anahtarı)
    	String hashparam = request.getParameter("HASH");
    	java.security.MessageDigest sha1 = java.security.MessageDigest
    			.getInstance("SHA-1");

    	String hash = (new sun.misc.BASE64Encoder()).encode(sha1
    			.digest(hashval.getBytes()));
    	//out.println("gelen hash="+hashparam+"<br/>");
    	//out.println("oluşturulan hash="+hash+"<br/>");
    	if (paramsval.equals(hashparamsval) && hash.equals(hashparam)) //oluşturulan hash ile gelen hash ve hash parametreleri değerleri ile ayrıştırılıp edilen edilen aynı olmalı.
    	{
    		out.println("<h4>Güvenlik Uyarısı. Sayısal İmza Geçerli Değil</h4>");
    		/************     Ödeme işlemi alanları      ****************/
    		String name = "xxxxxxxx"; //İşyeri kullanıcı adı
    		String password = "XXXXXXXX"; //İşyeri şifresi
    		String clientId = request.getParameter("clientid"); // İşyeri numarası
    		String mode = "P"; //P olursa gerçek işlem, T olursa test işlemi yapar.
    		String islemtipi = "Auth"; //Auth PreAuth PostAuth Credit Void olabilir.
    		String expires = request.getParameter("Ecom_Payment_Card_ExpDate_Month") + "/" + request.getParameter("Ecom_Payment_Card_ExpDate_Year"); //Kredi Kartı son kullanım tarihi mm/yy formatından olmalı
    		String cv2 = request.getParameter("cv2"); //Güvenlik Kodu
    		String amount = request.getParameter("amount"); //Tutar

    		String taksit = "4"; //Taksit sayısı peşin satışlar da boş olarak gönderilmelidir.
    		String oid = request.getParameter("oid"); // 3D modelde boş yollanmışsa sistem tarafından üretilir.

    		String mdStatus = request.getParameter("mdStatus"); // 3D işleminin sonucunu gösterir (1,2,3,4) ise başarılı, (5,6,7,8,9,0) işe başarısıdır
    		if (mdStatus != null
    		&& (mdStatus.equals("1") || mdStatus.equals("2")
    				|| mdStatus.equals("3") || mdStatus.equals("4"))) //Başarılı ve ödeme gerçekleştiriliyor
    		{
    %>
                <h5>3D İşlemi Başarılı</h5><br/>
            <%
                                            			String paymentHost = "<odeme_gecidi>"; //Ödeme geçidi hos ismi
                                            			String api = "<apiserver_path>"; //
                                            			int port = 443;
                                            			jpay myjpay = new jpay();
                                            			myjpay.setDebug(true);

                                            			/**************************   ÖDEME İÇİN GEREKLİ PARAMETRELER      ******************************/

                                            			myjpay.setName(name);
                                            			myjpay.setPassword(password);
                                            			myjpay.setClientId(clientId);
                                            			myjpay.setMode(mode);
                                            			myjpay.setType(islemtipi);
                                            			myjpay.setNumber(request.getParameter("md")); // Kart numarası yerine 3d secure işleminden dönen MD parametresi kullanılmalıdır.
                                            			myjpay.setExpires(""); // Son kullanma tarihine md kullanıldığı için gerek yoktur.
                                            			myjpay.setCvv2Val(""); // MD değeri kullanıldığında gerek yoktur.
                                            			myjpay.setTotal(amount);
                                            			myjpay.setCurrency("949"); //YTL icin 949

                                            			// 3d için deme alanları
                                            			myjpay.setCardholderPresentCode("13"); // her zaman 13 değerini alır
                                            			myjpay.setPayerSecurityLevel(request.getParameter("eci")); // 3d sonucu parametre olarak gelir
                                            			myjpay.setPayerTxnId(request.getParameter("xid")); //3d Sonucu parametre olarak gelir.
                                            			myjpay.setPayerAuthenticationCode(request
                                            			.getParameter("cavv")); //3d sonucu parametre olarak gelir

                                            			/************************    ÖDEME İÇİN GEREKLİ PARAMETRELER        ****************************/

                                            			/************************    ÖDEME İÇİN İSTEĞE BAĞLI ALANLAR        *****************************/

                                            			myjpay.setTaksit("4");
                                            			myjpay.setOrderId(oid);
                                            			myjpay.setGroupId("");
                                            			myjpay.setTransId("");
                                            			myjpay.setIPAddress("");
                                            			myjpay.setUserId("");
                                            			myjpay.setComments("");
                                            			myjpay.setBName("xxxfirma");
                                            			myjpay.setBStreet1("");
                                            			myjpay.setBStreet2("");
                                            			myjpay.setBStreet3("");
                                            			myjpay.setBCity("");
                                            			myjpay.setBPostalCode("");
                                            			myjpay.setBStateProv("");
                                            			myjpay.setSName("");
                                            			myjpay.setSStreet1("");
                                            			myjpay.setSStreet2("");
                                            			myjpay.setSStreet3("");
                                            			myjpay.setSCity("");
                                            			myjpay.setSPostalCode("");
                                            			myjpay.setSStateProv("");
                                            			//myjpay.setExtra("","");

                                            			int val = myjpay.processTransaction(paymentHost, port, api);
                                            			if (val > 0) {
                                            %>
                
                <h3>Ödeme Sonucu</h3>
                <table border="1">
                    <tr>
                        <td><b>Parameter İsmi:</b></td>
                        <td><b>Parameter Değeri</b></td>
                    </tr>
                    
                    <tr>
                        <td>AuthCode</td>
                        <td><%=myjpay.getAuthCode()%></td>
                    </tr>
                    
                    <tr>
                        <td>Response</td>
                        <td><%=myjpay.getResponse()%></td>
                    </tr>
                    
                    <tr>
                        <td>HostRefNum</td>
                        <td><%=myjpay.getHostRefNum()%></td>
                    </tr>
                    
                    <tr>
                        <td>ProcReturnCode</td>
                        <td><%=myjpay.getProcReturnCode()%></td>
                    </tr>
                    
                    <tr>
                        <td>TransId</td>
                        <td><%=myjpay.getTransId()%></td>
                    </tr>
                    
                    <tr>
                        <td>ErrMsg</td>
                        <td><%=myjpay.getErrMsg()%></td>
                    </tr>
                    
                </table>
                
                
                <%
                                                			if ("Approved".equalsIgnoreCase(myjpay.getResponse())) {
                                                			out
                                                			.println("<b>Ödeme İşleminiz Başarıyla Gerçekleştirildi</b>");
                                                		} else {
                                                			out
                                                			.println("<b>Ödeme İşleminiz Başarıyla Gerçekleştirilmedi</b> ");
                                                		}
                                                			} else {
                                                		out.println("<b>Bağlantı Hatası</b>");
                                                			}

                                                		} else {
                                                			out.println("3D Onayı  Alamadınız");
                                                		}
                                                	} else {
                                                		out
                                                		.println("hash değerleri uyuşmamaktadır. İşlem devam ettirilemez.");
                                                	}
                                                %>
    
    
    </body>
</html>
