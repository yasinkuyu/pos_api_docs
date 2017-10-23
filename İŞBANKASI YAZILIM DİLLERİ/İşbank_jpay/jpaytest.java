import java.io.*;
import java.net.*;
import java.lang.*;
import java.util.*;
import java.text.*;



public class jpaytest {

    public static void main(String[] args) {
        try{

            jpay myjpay = new jpay();


            myjpay.setName("isbank2");
            myjpay.setPassword("isbank2");
            myjpay.setClientId("7777");

			myjpay.setIPAddress("");
            myjpay.setMode("P");
            myjpay.setOrderId("");
			myjpay.setGroupId("");
            myjpay.setTransId("");
            myjpay.setUserId("");
            myjpay.setType("PreAuth");
            myjpay.setNumber("4242424242424242");
            myjpay.setExpires("04/09");
            myjpay.setCvv2Val("005");
            myjpay.setTotal("12.50");
            myjpay.setCurrency("949");





            myjpay.setBName("John Doe");
            myjpay.setBStreet1("Adresim1");
            myjpay.setBStreet2("Adresim2");
            myjpay.setBStreet3("Adresim3");
            myjpay.setBCity("Ýstanbul");

            myjpay.setBStateProv("");
            myjpay.setBCompany("");
            myjpay.setBTelVoice("212212212");
            myjpay.setBTelFax("213213213");


		    myjpay.setSName("John Doe");
            myjpay.setSStreet1("Adresim1");
            myjpay.setSStreet2("Adresim2");
            myjpay.setSStreet3("Adresim3");
            myjpay.setSCity("Ýstanbul");

            myjpay.setSStateProv("");
            myjpay.setSCompany("");
            myjpay.setSTelVoice("212212212");
            myjpay.setSTelFax("213213213");



                if(myjpay.processTransaction("testsanalpos.est.com.tr", 443,"/servlet/cc5ApiServer" ) > 0){

            	System.out.println("OrderId:        		"+myjpay.getOrderId());
            	System.out.println("GroupId:        		"+myjpay.getGroupId());
            	System.out.println("AuthCode:       		"+myjpay.getAuthCode());
				System.out.println("Response:       		"+myjpay.getResponse());
            	System.out.println("HostRefNum:     		"+myjpay.getHostRefNum());
            	System.out.println("ProcreturnCode: 		"+myjpay.getProcReturnCode());
           		System.out.println("TransId:        		"+myjpay.getTransId());
           		System.out.println("ErrMsg:         		"+myjpay.getErrMsg());
                System.out.println("HOSTMSG:        		"+myjpay.getExtra("HOSTMSG"));
                System.out.println("HOSTMSG2:         		"+myjpay.getExtra("HOSTMSG2"));
                System.out.println("BANKA:         			"+myjpay.getExtra("BANKA"));
                System.out.println("DATETIME:         		"+myjpay.getExtra("DATETIME"));

                //Taksitli islem ve provizyon almis ise asagidaki bilgilerde dolu donecektir
                System.out.println("INSTALLMENTCOUNT:       "+myjpay.getExtra("INSTALLMENTCOUNT"));
                System.out.println("NEXTINSTALLMENTAMOUNTS: "+myjpay.getExtra("NEXTINSTALLMENTAMOUNTS"));
                System.out.println("FIRSTINSTALLMENTAMOUNT: "+myjpay.getExtra("FIRSTINSTALLMENTAMOUNT"));
                System.out.println("FIRSTINSTALLMENTDATE:   "+myjpay.getExtra("FIRSTINSTALLMENTDATE"));

            }
            else{
                System.out.println("processTransaction Error: " );
			}

		}

		catch(Exception e)
        {
            System.out.println("jpaytest Exception" + e);

		}

	}

} //End