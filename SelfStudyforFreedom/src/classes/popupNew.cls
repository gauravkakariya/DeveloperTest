public with sharing class popupNew {
    
    
    public popupNew(){}

public popupNew(ApexPages.StandardController std)
{}
 
public List<Opportunity> opportunity
{

    get {

      if(opportunity != null)
       {

        return opportunity;

       }
      else 
      {

        opportunity = [select Name,Type,Description,Id from Opportunity];

        return opportunity;

      }
    }
    set;
    

}

 public String getLink()
  {
   String Url = System.URL.getSalesforceBaseUrl().toExternalForm();
   return Url;

    }

  public boolean displayPopup
    {
    get;set;
    }
  
  public void closePopup() 
  {        
        displayPopup = false;
         quotes=null;
         //quotesitem=null;
    } 
        
    public void showPopup() 
    {        
        displayPopup = true;
       
    }

    public PageReference doNothing()
    {
        displayPopup = true;
        
        return null;
    }
    
    
    public List<Quote> quotes
    {

    get {

      if(quotes != null)
       {

        return quotes;

       }
      else 
      {
        
        //System.debug('Opprtunity ID in ****************======================================================#####################' + ApexPages.currentPage().getParameters().get('myparm1'));
        quotes = [Select q.Status, q.QuoteNumber, q.Phone, q.Name, q.Email,q.Id From Quote q where q.OpportunityId=:ApexPages.currentPage().getParameters().get('paramOppid') ];
        
        
        return null;

      }
    }
    set;
    

}

    
    
}