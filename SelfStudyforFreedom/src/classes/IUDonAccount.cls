public with sharing class IUDonAccount {
	

	/* I set the Account and Case Objects
	here for use through out the code*/
	public Account acct { get; private set;}
	public Case[] caseItems { get; private set; }
	private ApexPages.StandardController controller;
	
	// constructor, loads the Account and
	// any cases associated with it
	
	void caseItems(id id) {
	acct = [SELECT Id, Name, Type, AccountNumber, Site,
	      (SELECT Id, CaseNumber, Status, Reason,Origin,
	      Subject FROM Cases) FROM Account
	      where id = :id limit 1];
	//Hook caseItems to the query above
	 caseItems = acct.Cases;
	}
	
	//Define the id
	id accountid;
	
	/* A List Method to delete the Cases assigned*/
	public list<Case> todelete = new list<Case>();

	public IUDonAccount (ApexPages.StandardController c)
	{
	/* this will kickoff you main page */
	controller = c;
	/* to get this current Account Id*/
	accountid = c.getRecord().id;
	/*kick off the init() function*/
	init();
	}
	
	
	public IUDonAccount () {
	accountid =
	ApexPages.CurrentPage().getParameters().get('id');
	init();
	
	}

	void init() {
	/* load up Cases
	basically we defined caseitems up on top, so
	when the page loads then caseItems(accountId)
	will go through the query and list out the
	Items assoicated with it */
	caseItems(accountid);  
	}
	
	public PageReference save() {
	try {
			upsert caseItems;
		if ( todelete.size() > 0 ) {           
			delete todelete;   
		}
		caseItems(acct.id);
	}
	catch ( DmlException exc) {
	      ApexPages.addMessages(exc);
	      return null;
	}
	return null;
	}
	
	
	/* your Delete functionality*/
	public PageReference del() {
	
	string delname = ApexPages.CurrentPage().getParameters().get('delname');
	system.assert( delname != null );
	integer gone = -1;
	integer i = 0; 
	
	for ( i=0; i< caseItems.size(); i++ ) { 
	if (caseItems[i].CaseNumber== delname) { 
	gone = i;
	} 
	}
	if ( gone >= 0) { 
	todelete.add(caseItems.remove(gone) ); 
	}
	return null;
		
	}
	public PageReference add() {
	// insert a new line, after user clicks Add
	Case cs =  new Case(
	AccountId = acct.id,
	Subject = 'hello', Status = 'Low',
	Reason = 'Other',Origin='Low'
	);
	caseItems.add ( cs );
	return null;
	 }


}