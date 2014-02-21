global class ActivitySummaryScheduler implements Schedulable 
{
       global void execute(SchedulableContext SC)
       
   {
       ActivitySummaryBatch M = new ActivitySummaryBatch(); 
       
    
      database.executebatch(M);
    
      
   }


}