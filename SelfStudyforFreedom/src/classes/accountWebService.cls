//Creating web service for account
@RestResource(urlMapping='/accountWeb/')
global with sharing class accountWebService {
	
	@Httpget
	global static void doGet(){
		
		Account account = new Account();
		account.First_Name__c = 'abc';
		account.Last_Name__c ='xyz';
		account.Name = 'abc xyz';
		account.Email__c = 'abc@gmail.com';
		
		String xmlOutput = xmlGenerateInApex.getXml();
		system.debug('***'+xmlOutput);
		
		RestContext.response.addHeader('Content-Type', 'text/plain');
		RestContext.response.responseBody = Blob.valueOf(xmlOutput);
	}
	
}