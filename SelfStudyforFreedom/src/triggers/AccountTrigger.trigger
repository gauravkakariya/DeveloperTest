trigger AccountTrigger on Account (after insert, after update)
{
    AccountTriggerHandler objAccountHandler = new AccountTriggerHandler();
    if(trigger.isAfter && trigger.isUpdate)
    {
        objAccountHandler.onAfterUpdate(trigger.new);      
    }
    
}