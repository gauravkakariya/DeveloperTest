global with sharing class dynamicHtmlController {
	
	global static list<String> stringlist{get;set;}
	global static list<Account> accountlist{get;set;}
	
	@RemoteAction
	global static list<String> getStringData(){
		
		stringlist = new list<String>();
		stringlist.add('amol'); 
		stringlist.add('bmol'); 
		stringlist.add('cmol');
		stringlist.add('dmol');
		return stringlist;
	}

	@RemoteAction
	global static list<Account> getAccountData(){
		
		accountlist = new list<Account>();
		accountlist = [Select Name From Account limit 10];
		return accountlist;
	}
	
	
}