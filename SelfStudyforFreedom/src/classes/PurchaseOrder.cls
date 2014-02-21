public with sharing class PurchaseOrder 
{
	public ApexPages.StandardSetController con{get; set;}
	public  PurchaseOrder(ApexPages.StandardController controller){}
	public PageReference Search()
	{
	 	if(prodView!=null)
	 	{
			if(prodView=='AllOpportunity')
        		{
        			con = new ApexPages.StandardSetController(Database.getQueryLocator([Select o.Name,  o.Description, o.CloseDate, o.Amount From Opportunity o ]));
        		}
		 	else
        		{
        			con=null;
        		}
	 	}
       
        
        	return null ;
	}


	
	 //constructor
	public PurchaseOrder()
	{
		
		
	}
	
	
	
	public String prodView{get;set;}
	
	
	//Getting records
	 public List<Opportunity> lstProduct
    {
        get
        {
            if(con != null)
                return (List<Opportunity>)con.getRecords();
            else
                return null ;
        }
        set;
        
    }
}//end of  class