<%@ page language="C#" autoeventwireup="true" inherits="odemesayfasi3dpay, App_Web_fr4klrwv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>3D Pay Ödeme Sayfası</title>
</head>
<body>
<h1>3D Ödeme Sayfası</h1>
    
    
    <h3> 3D Dönen Parametreler</h3>
    <table border="1">
        <tr>
            <td><b>Parametre İsmi:</b></td>
            <td><b>Parametre Değeri:</b></td>
        </tr>
        <%
            String[] odemeparametreleri = new String[] { "AuthCode", "Response", "HostRefNum", "ProcReturnCode", "TransId", "ErrMsg" };
            IEnumerator e = Request.Form.GetEnumerator();
            while (e.MoveNext())
            {
                String xkey = (String)e.Current;
                String xval = Request.Form.Get(xkey);
                bool ok = true;
                for (int i = 0; i < odemeparametreleri.Length; i++)
                {
                    if (xkey.Equals(odemeparametreleri[i]))
                    {
                        ok = false;
                        break;
                    }
                }
                if(ok)
                    Response.Write("<tr><td>" +xkey +"</td><td>"+ xval+"</td></tr>");
            }
         %>
        
        
        </table>
    <%
        String hashparams = Request.Form.Get("HASHPARAMS");
        String hashparamsval = Request.Form.Get("HASHPARAMSVAL");
        String storekey = "xxxxxx";
        String paramsval = "";
        int index1 = 0, index2 = 0;
        // hash hesaplamada kullanılacak değerler ayrıştırılıp değerleri birleştiriliyor.
        do
        {
            index2 = hashparams.IndexOf(":", index1);
            String val = Request.Form.Get(hashparams.Substring(index1, index2-index1)) == null ? "" : Request.Form.Get(hashparams.Substring(index1, index2-index1));
            paramsval += val;
            index1 = index2 + 1;
        }
        while (index1 < hashparams.Length);

        //out.println("hashparams="+hashparams+"<br/>");
        //out.println("hashparamsval="+hashparamsval+"<br/>");
        //out.println("paramsval="+paramsval+"<br/>");
        String hashval = paramsval + storekey;         //elde edilecek hash değeri için paramsval e store key ekleniyor. (işyeri anahtarı)
        String hashparam = Request.Form.Get("HASH");

        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashval);
        byte[] inputbytes = sha.ComputeHash(hashbytes);

        String hash = Convert.ToBase64String(inputbytes); //Güvenlik ve kontrol amaçlı oluşturulan hash

        if (!paramsval.Equals(hashparamsval) || !hash.Equals(hashparam)) //oluşturulan hash ile gelen hash ve hash parametreleri değerleri ile ayrıştırılıp edilen edilen aynı olmalı.
        {
            Response.Write("<h4>Güvenlik Uyarısı. Sayısal İmza Geçerli Değil</h4>");
        }
        
        
        
        
        String mdStatus = Request.Form.Get("mdStatus"); // 3d işlemin sonucu
        if(mdStatus.Equals("1") || mdStatus.Equals("2") || mdStatus.Equals("3") || mdStatus.Equals("4"))
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
         for(int i=0;i<odemeparametreleri.Length;i++)
         {
               String paramname = odemeparametreleri[i];
               String paramval = Request.Form.Get(paramname);
               Response.Write("<tr><td>"+paramname+"</td><td>"+paramval+"</td></tr>");
         }
    
     %>
     </table>
     <%
            if("Approved".Equals(Request.Form.Get("Response")))
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
    
    
        %>             
</body>
</html>
