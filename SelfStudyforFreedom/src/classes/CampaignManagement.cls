public with sharing class CampaignManagement
 {

	string view='Recently Modified';
	
	public CampaignManagement()
	{
		
		
	}
	public CampaignManagement(ApexPages.StandardController controller){}
	
	public PageReference pagecheck()
	{
		return null;
	}
	
	public string getView()
	{
		//return [Select c.Type, c.Status, c.Name  From Campaign c order by c.LastModifiedDate  desc  ]; 
		return  view;		
		
	}
	
	
	public void setView(string view)
	{
		this.view=view;		
	}
	
	
	
	
	public List<Campaign> campaigns
	{
		get
		
		{
			if(view=='Recently Modified')
			{
				return [Select c.Type, c.Status, c.Name,c.StartDate  From Campaign c order by c.LastModifiedDate desc   ];
				
			}
			
			else if (view=='All Campaigns')
			{
				
				return [Select c.Type, c.Status, c.Name,c.StartDate  From Campaign c order by c.StartDate desc  ];
				
			}
			else if (view=='All Active Campaigns')
			{
				return [Select c.Type, c.Status, c.Name,c.StartDate,IsActive  From Campaign c where   c.IsActive=True  order by c.StartDate desc  ];
				
			}
			
			else if (view=='My Active Campaigns')
			{
				return [Select c.Type, c.Status, c.Name,c.StartDate,IsActive,OwnerId  From Campaign c where   c.IsActive=True and  c.OwnerId=:UserInfo.getUserId() order by c.StartDate desc  ];
				
			}
			
			else
			{
				return [Select c.Type, c.Status, c.Name,c.StartDate,IsActive  From Campaign c  where  c.IsActive=False order by c.StartDate desc  ];
				
			}
			
		}
		
		set;
		
	}
	
	
}