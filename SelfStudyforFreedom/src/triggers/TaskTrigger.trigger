trigger TaskTrigger on Task (before insert,after insert, after update, before update) 
{
	TaskTriggerHandler objTaskTriggerHandler = new TaskTriggerHandler();
	if(Trigger.isBefore && Trigger.isUpdate)
	objTaskTriggerHandler.onBeforeUpdate(Trigger.old, Trigger.new);
	
	//if(Trigger.isBefore && Trigger.isInsert)
	//objTaskTriggerHandler.onbeforeInsert(Trigger.new);
	
	if(Trigger.isAfter && Trigger.isUpdate)
	objTaskTriggerHandler.onAfterUpdate(Trigger.new);
	
	
}