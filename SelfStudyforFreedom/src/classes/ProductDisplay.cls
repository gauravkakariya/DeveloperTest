public with sharing class ProductDisplay 
{
	public List<Product2> products {get; set;}
	 
	 //constructor
	public ProductDisplay()
	{
		List<Product2> lstProduct=new List<Product2>();
		
		products = new List<Product2>();
        	products.add(new Product2(Name=''));
		
	}

	 public void addrow()
	{
	 
	// if(test.isRunningTest()){	
       // products.add(new Product2(Name='Product Name'));
	// }else{
	 	products.add(new Product2(Name=''));
	// }
        
	}
	
	 public void delRow()
	{ 
		Integer i=products.size();
	      products.remove(i-1);
        
	}
	
	//on save button click  insert into database
	 public PageReference save()
    {
        insert products;
        PageReference home = new PageReference('/apex/ProductDetails');
        home.setRedirect(true);
        return home;
    }
	
	//Delete records
     public PageReference del()
    {
        delete products;
        PageReference home = new PageReference('/apex/ProductDetails');
        home.setRedirect(true);
        return home;
    }	
	
	public Product2 view
	{
		get;
		set;
		
	}
	public String prodView{get;set;}
	
	
	public ApexPages.StandardSetController con{get; set;}
	public  ProductDisplay(ApexPages.StandardController controller){}
	
	//Geeting records
	public PageReference Search()
	{
		
		
	 	if(prodView!=null)
	 	{
			if(prodView=='RecentlyModified')
        		{
        			con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Name,Description,ProductCode,IsActive,Family from Product2   ]));
        		}
		 	else
        		{
        			con=null;
        		}
	 	}
       
        
        	return null ;
	}
	
	public String getLink()
     {
       String url=system.URL.getSalesForceBaseUrl().toExternalForm();
       
       
       return URL;
     }
	
	//Getting records
	 public List<Product2> lstProduct
    {
        get
        {
            if(con != null)
                return (List<Product2>)con.getRecords();
            else
                return null ;
        }
        set;
        
    }

}//end of class