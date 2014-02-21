global with sharing class SampleDynamicPage {
	
	global static List<Account> accontList{get;set;}
	
	@RemoteAction
	global static List<Account> getAccountList(){
		
		accontList = new List<Account>();
		return accontList = [Select Name,Phone,GenerateHtml__c From Account Limit 5];
	}

}