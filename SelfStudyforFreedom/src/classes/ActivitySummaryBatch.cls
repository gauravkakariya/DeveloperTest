global class ActivitySummaryBatch implements Database.Batchable<SObject>,Database.Stateful
{
		
        	List<CampaignMember> ActionTodayListCount=new 	List<CampaignMember>();
			List<CampaignMember> Action91ListCount=new List<CampaignMember>();
			List<CampaignMember> Action181ListCount =new List<CampaignMember>();
			List<CampaignMember> Action366ListCount=new List<CampaignMember>();
			
			Map<Id,Integer> ActionYesterdayCount=new Map<Id,Integer>();
			Map<Id,Integer> Action91Count=new Map<Id,Integer>();
			Map<Id,Integer> Action181Count=new Map<Id,Integer>();
			Map<Id,Integer> Action366Count=new Map<Id,Integer>();
			Map<Id,Integer> LifeTimeActionCount=new Map<Id,Integer>();
	    


         global Database.Querylocator start(Database.BatchableContext ctx)
         {
         
         	
         		return Database.getQueryLocator([Select c.ContactId, c.CampaignId, c.Lastupdated_Date__c From CampaignMember c]);
                	
         }

			
		
	    
	     

		global void execute(Database.BatchableContext ctx, List<Sobject> scope)
		{
			List<CampaignMember> camp= (List<CampaignMember>)scope;
			
	
			
			
			
			Integer Count;
		
			for(CampaignMember objCampaignMember: camp)
			{ 
				// if(objCampaignMember.Lastupdated_Date__c==System.today().addDays(-1))
				 {
				 	  ActionTodayListCount.add(objCampaignMember);
				 	  
				 	 	// if (ActionYesterdayCount.containsKey(objCampaignMember.ContactId))
				 	 	 if(LifeTimeActionCount.containsKey(objCampaignMember.ContactId))
				 	     { 
				 	  			 Count=LifeTimeActionCount.get(objCampaignMember.ContactId)+1;
				 	  	
				 	  			//ActionYesterdayCount.put(objCampaignMember.ContactId,Count);
				 	  			LifeTimeActionCount.put(objCampaignMember.ContactId,Count);
				 	     }
				 	     
				 	      else
				 	      {
				 	    		//ActionYesterdayCount.put(objCampaignMember.ContactId,1);
				 	    		LifeTimeActionCount.put(objCampaignMember.ContactId,1);
				 	      }  
				 		
				 	
				 }
				
			/*	
				if(objCampaignMember.Lastupdated_Date__c<System.today().addDays(-90))
				{
					Action91ListCount.add(objCampaignMember);
					
					if ( Action91Count.containsKey(objCampaignMember.ContactId))
				 	     { 
				 	  			 Count= Action91Count.get(objCampaignMember.ContactId)+1;
				 	  	
				 	  			 Action91Count.put(objCampaignMember.ContactId,Count);
				 	     }
				 	      
				 	      else
				 	      {
				 	    		 Action91Count.put(objCampaignMember.ContactId,1);
				 	    		
				 	      }  
					
					
					
					
				}
				
				if(objCampaignMember.Lastupdated_Date__c>System.today().addDays(-91) && objCampaignMember.Lastupdated_Date__c<System.today().addDays(-180))
				{
					Action181ListCount.add(objCampaignMember);
					
					if ( Action181Count.containsKey(objCampaignMember.ContactId))
				 	     { 
				 	  			 Count= Action181Count.get(objCampaignMember.ContactId)+1;
				 	  	
				 	  			 Action181Count.put(objCampaignMember.ContactId,Count);
				 	     }
				 	      
				 	      else
				 	      {
				 	    		 Action181Count.put(objCampaignMember.ContactId,1);
				 	    		
				 	      }  
					
					
				}
				
				
				
				if(objCampaignMember.Lastupdated_Date__c>System.today().addDays(-181) && objCampaignMember.Lastupdated_Date__c<System.today().addDays(-365))
				{
					 Action366ListCount.add(objCampaignMember);
					 
					 if ( Action366Count.containsKey(objCampaignMember.ContactId))
				 	     { 
				 	  			 Count= Action366Count.get(objCampaignMember.ContactId)+1;
				 	  	
				 	  			Action366Count.put(objCampaignMember.ContactId,Count);
				 	  			
				 	     }
				 	      
				 	      else
				 	      {
				 	    		 Action366Count.put(objCampaignMember.ContactId,1);
				 	    		
				 	      } 
					
					
				}
				
				system.debug('YesterdayCount$$$$'+ActionTodayListCount.size());
				
				
				
				*/
				
			}//end of for loop
			
			List<Contact> lstContact=new List<Contact>();
    		//for(Contact objContact:[select Yesterdays_count__c,Id from Contact where Id IN: ActionYesterdayCount.keySet()])	
    		for(Contact objContact:[select Id from Contact where Id IN: LifeTimeActionCount.keySet()])	
    		{
    			//objContact.Yesterdays_count__c=ActionYesterdayCount.get(objContact.Id);
    			objContact.Last_Date__c=date.today();
    			objContact.Lifetime_Action_Count__c=LifeTimeActionCount.get(objContact.Id);
    			lstContact.add(objContact);
    			
    			
    		}
    		/*for(Contact objContact:[select Lifetime_Action_Count__c,Id from Contact where Id IN: LifeTimeActionCount.keySet()]){
    			objContact.Lifetime_Action_Count__c=LifeTimeActionCount.get(objContact.Id);
    			
    			lstContact.add(objContact);
    		
    		}
    		*/
    		upsert lstContact;
			
				//system.debug('Hello'+camp);
				
				
        }//end of execute method

    
    
    	global void finish(Database.BatchableContext ctx)
    	{
    		
    		
    		
    		
    		
    	}//end of finish method
    
		

}