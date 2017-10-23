<%@page contentType="text/html;charset=ISO-8859-9"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

   <html>
       <head>
           <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
           <title>3D Pay Ödeme Sayfası</title>
       </head>
       <body>
        <h1>Ödeme Sayfası</h1>
    
    
    <h3> 3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre İsmi:</b></td>
            <td><b>Parametre Değeri:</b></td>
        </tr>
    
    <%
       String [] odemeparametreleri = new String[]{"AuthCode","Response","HostRefNum","ProcReturnCode","TransId","ErrMsg"};
       java.util.Enumeration enu = request.getParameterNames();
                while(enu.hasMoreElements())
                    {
                        String param = (String)enu.nextElement();
                        String val = (String)request.getParameter(param);
                        boolean ok = true;
                        for(int i=0;i<odemeparametreleri.length;i++)
                        {
                            if(param.equalsIgnoreCase(odemeparametreleri[i]))
                            {    
                                ok = false;
                                break;
                            }
                        }
                        if(ok)
                            out.println("<tr><td>"+param+"</td>"+"<td>"+val+"</td></tr>");
                    }
    
    %>
    </table>
    <br>
    <br>
    <%
         String hashparams = request.getParameter("HASHPARAMS");
    String hashparamsval = request.getParameter("HASHPARAMSVAL");
    String storekey="xxxxxx";
    String paramsval="";
    int index1=0,index2=0;
    // hash hesaplamada kullanılacak değerler ayrıştırılıp değerleri birleştiriliyor.
    do
    {   
        index2 = hashparams.indexOf(":",index1);
        String val = request.getParameter(hashparams.substring(index1,index2)) == null ? "" : request.getParameter(hashparams.substring(index1,index2));
        paramsval += val;
        index1 = index2 + 1;
    }
    while(index1<hashparams.length());
    
    //out.println("hashparams="+hashparams+"<br/>");
    //out.println("hashparamsval="+hashparamsval+"<br/>");
    //out.println("paramsval="+paramsval+"<br/>");
    String hashval = paramsval + storekey;         //elde edilecek hash değeri için paramsval e store key ekleniyor. (işyeri anahtarı)
    String hashparam = request.getParameter("HASH");
    java.security.MessageDigest sha1 = java.security.MessageDigest.getInstance("SHA-1");
        
    String hash = (new sun.misc.BASE64Encoder()).encode(sha1.digest(hashval.getBytes()));
    //out.println("gelen hash="+hashparam+"<br/>");
    //out.println("oluşturulan hash="+hash+"<br/>");
    
         
         
         String mdStatus = request.getParameter("mdStatus"); // 3D işleminin sonucunu gösterir (1,2,3,4) ise başarılı, (5,6,7,8,9,0) işe başarısıdır
            if(mdStatus!=null && (mdStatus.equals("1") || mdStatus.equals("2") || mdStatus.equals("3")|| mdStatus.equals("4"))) //Başarılı ve ödeme gerçekleştiriliyor
            {
                
             %>
                <h5>3D İşlemi Başarılı</h5><br/>
                <h3> Ödeme Sonucu</h3>
                <table border="1">
                    <tr>
                        <td><b>Parametre İsmi</b></td>
                        <td><b>Parameter Değeri</b></td>
                    </tr>
                    <%
                        for(int i=0;i<odemeparametreleri.length;i++)
                        {
                            String paramname = odemeparametreleri[i];
                            String paramval = request.getParameter(paramname);
                            out.println("<tr><td>"+paramname+"</td><td>"+paramval+"</td></tr>");
                        }
                    
                    %>
                </table>
                
            <%
            
            
            
            
            
            if("Approved".equalsIgnoreCase(request.getParameter("Response")))
            {
            %>
                <h6>Ödeme İşlemi Başarılı</h6>
            <%
            }else{
                %>
                    <h6>Ödeme İşlemi Başarısız</h6>
                <%
            }
            }else{
             %>
             <h5>3D İşlemi Başarısız</h5>
             <%
            }
            if(!paramsval.equals(hashparamsval)|| !hash.equals(hashparam)) //oluşturulan hash ile gelen hash ve hash parametreleri değerleri ile ayrıştırılıp edilen edilen aynı olmalı.
            {
                out.println("<h4>Güvenlik Uyarısı. Sayısal İmza Geçerli Değil</h4>");
            }
    
        %>              
           
       </body>
       
   </html>