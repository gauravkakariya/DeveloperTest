public with sharing class SalesforceSearchController
{
 public String searchText;
 List<Lead> results_lead; 
 List<Contact> results_contact;
 List<Opportunity> results_opportunity;
 List<Account> results_account;
 
 
 Map<string,List<SObject>> mapSobj=new Map<string,List<SObject>>();
 
 public String getSearchText() 
 {
  return searchText;
 } 
 
 public void setSearchText(String s) 
 {
 		
  		searchText = s;
      
 }
 
 public List<Lead> getResults_lead() 
 {
  return results_lead;
 }
 

 public List<Contact> getResults_contact() 
 {
  return results_contact;
 }
 
 
 public List<Account> getResults_account() 
 {
  return results_account;
 }
 
 
 public List<Opportunity> getResults_opportunity() 
 {
  return results_opportunity;
 }


 
  public PageReference doSearch()
  {
  	
		
  	
  	 //Pattern MyPattern=Pattern.compile(digit);
     // Pattern textFormat = Pattern.Compile(notDigit);  
     // Matcher mymatcher=textFormat.matcher(searchText);
     
     	if(searchText.contains('!')||searchText.contains('*') ||searchText.contains('@')||searchText.contains('#')||searchText.contains('$')||searchText.contains('%')||searchText.contains('^')||searchText.contains('&')||searchText.contains('(')||searchText.contains(')')||searchText.contains('-')||searchText.contains(' ')||searchText.length()<=1)	   
      {	 
      	 searchText=null;
      	 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Coorect String'));	
      	 
      }
      else
      {  
      	if(searchText!=null)
      	{
  		  String findString=searchText+'*';
   	
		   List<List<SObject>> searchList = [FIND :findString IN NAME FIELDS RETURNING Account (Id, Name,First_Name__c,Last_Name__c), Contact(Id, Name,FirstName,LastName), Opportunity(Id, Name,Last_Name__c,First_Name__c), Lead(Id, Name,FirstName,LastName)];  
		   
		   results_account = ((List<Account>)searchList[0]);
		   results_contact = ((List<Contact>)searchList[1]);
		   results_opportunity = ((List<Opportunity>)searchList[2]);
		   results_lead = ((List<Lead>)searchList[3]); 
      	}
		  //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Coorect Data'));
      }
      
      return null;
  }

}