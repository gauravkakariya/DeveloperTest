public with sharing class CmPaging 
{
	
	
	public CmPaging(ApexPages.StandardController controller){}
	
    public List<Campaign> Allview
    {
        get
        {
            if(con != null)
                return (List<Campaign>)con.getRecords();
            else
                return null ;
        }
        set;}
    
    public Campaign view {get; set;}
    
    //Controller
    public CmPaging()
    {
        Allview = new List<Campaign>() ;
        view = new Campaign();
        view.Name= 'RecentlyModified';
        
    }
    
     public PageReference Search()
    {   
        if(view.Name != null)
        {
        if(view.Name=='RecentlyModified')
        {
        	con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Name,Status,Type,Startdate from Campaign order by LastModifiedDate desc]));
        }
        else if(view.Name=='AllCampaigns')
        {
        	con = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,Status,Type,Startdate from Campaign order by startdate desc]));
        }
      	else if(view.Name=='AllActiveCampaigns')
        {
         		con = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,Status,Type,Startdate from Campaign where IsActive = TRUE order by startdate desc]));
        }
        else if(view.Name=='MyactiveCampaigns')
        {
        	 		con = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,Status,Type,Startdate,OwnerId from Campaign where IsActive = TRUE and Owner.Id=:UserInfo.getUserId() order by startdate desc]));
        }
        else if(view.Name=='InactiveCampaigns')
        {
        	 		con = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,Status,Type,Startdate from Campaign where IsActive = FALSE order by startdate desc]));
        }
        else
        {
        	con=null;
        }
        	if(con!=null){
                   con.setPageSize(3);
        	}
        }
        
        return null ;
    }
    
    //Instantiate the StandardSetController
    public ApexPages.StandardSetController con{get; set;}
    
    //Boolean to check if there are more records after the present displaying records
    public Boolean hasNext
    {
        get
        {
            return con.getHasNext();
        }
        set;
    }
 
    //Boolean to check if there are more records before the present displaying records
    public Boolean hasPrevious
    {
        get
        {
            return con.getHasPrevious();
        }
        set;
    }
 
    //Page number of the current displaying records
    public Integer pageNumber
    {
        get
        {
            return con.getPageNumber();
        }
        set;
    }

    //Returns the previous page of records
    public void previous()
    {
        con.previous();
    }
 
    //Returns the next page of records
    public void next()
    {
        con.next();
    }
    
    
     public void first() {
       con.first();
    }
 
    public void last() {
        con.last();
    }
}