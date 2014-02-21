public with sharing class CampaignPagination
 {
 	
 	public CampaignPagination(){}
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 5;
                string queryString = 'Select c.Type, c.Status, c.Name  From Campaign c order by c.LastModifiedDate desc ';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    
    public CampaignPagination(ApexPages.StandardController controller){}
   
    
   
   /* 
    Public List<Campaign> getcampaigns(){
        List<Campaign> campList = new List<Campaign>();
        for(Campaign a : (List<Campaign>)setCon.getRecords())
            campList.add(a);
        return campList;
    }
    */
    public pageReference refresh() 
    {
        setCon = null;
        
       setCon.setPageNumber(1);
        return null;
    }
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
 
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
 
    public void first() {
        setCon.first();
    }
 
    public void last() {
        setCon.last();
    }
 
    public void previous() {
        setCon.previous();
    }
 
    public void next() {
        setCon.next();
    }
}