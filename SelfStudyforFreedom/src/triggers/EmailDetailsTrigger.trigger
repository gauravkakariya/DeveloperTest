trigger EmailDetailsTrigger on Email_Detail__c (after insert, after update, before insert, 
											    before update)
{
	EmailDetailsHandler objEmailDetailsHandler = new EmailDetailsHandler();
	
	if(Trigger.isAfter && Trigger.isInsert)
	objEmailDetailsHandler.SendEmailToPartner(Trigger.new);
	
}