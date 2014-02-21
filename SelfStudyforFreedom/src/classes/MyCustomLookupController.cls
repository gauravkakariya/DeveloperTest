public with sharing class MyCustomLookupController {

	
    public MyCustomLookupController(ApexPages.StandardController controller) {
		  account = new Account();
    }

 
  public Account Account {get;set;}
  
  public MyCustomLookupController() {
    account = new Account();
   
  }
 
  // save the new account record
  public PageReference saveAccount() {
    insert account;
    // reset the account
    
    PageReference accountPage = new PageReference('/'+account.Id+'/e?RecordType='+ApexPages.currentPage().getParameters().get('RecordType'));
    accountPage.setRedirect(true);
    return accountPage;
  }	
 
}