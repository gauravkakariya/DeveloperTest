public with sharing class TestSoapWeb {
	
   public static void main(String[] args) 
   {
       try 
       {
         //Get a stub for calling partner WSDL's login method in order to get SessionID
         SoapBindingStub bind= (SoapBindingStub)new SforceServiceLocator().getSoap();
         LoginResult lr=bind.login('gaurav.kakariya@espl.com', 'test@123L0s39gZ9O77LY2NvkwDYwY9l5');
 
         //Create a sessionHeader object and set its sessioId property to sessionId 
         //received in loginResult object                        
         SessionHeader sh=new SessionHeader();
         sh.setSessionId(lr.getSessionId());
 
         //Create a service locator object for your custom web service
         KartikServiceServiceLocator locator=new KartikServiceServiceLocator();
 
         //Get URL for your custom web service
         URL url=new URL(locator.getKartikServiceAddress());
 
         //Create a stub for your custom web service with URL for your service and locator as parameters
         KartikServiceBindingStub stub=new KartikServiceBindingStub(url, locator);
 
         //Set the header property of stub with name "SessionHeader" and value as sh-sessionHeader 
         //object created above 
         stub.setHeader(locator.getKartikServiceAddress(), 'SessionHeader', sh);
 
         //now make call to custom service-in our case its "Hello(String name)"
         System.out.println(stub.hello('KARTIK'));
        }
        catch (Exception e) 
        {e.printStackTrace(); }  
   } 
}
