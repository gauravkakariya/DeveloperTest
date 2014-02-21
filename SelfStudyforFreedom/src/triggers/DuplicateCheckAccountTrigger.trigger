trigger DuplicateCheckAccountTrigger on Account (before insert,before update, after update)
 {

    DuplicateChecker objDublicateChecker=new DuplicateChecker();
    
    
    
        //if Trigger is Before Insert
    if(trigger.isBefore && trigger.isInsert )
    {
        system.debug('@@@@@@@@@@');
        objDublicateChecker.onBeforeInsert(trigger.new);
        
    }//end of beforeInsert Trigger
    
   
    


 }