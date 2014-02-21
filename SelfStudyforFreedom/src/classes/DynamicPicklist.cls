/* Creating Dynamic picklist of City */

public with sharing class DynamicPicklist {

	public String City{get; set;}
    public String newpicklistvalue{get; set;}
    
	public List<SelectOption> getcitynames()
	{
	  List<SelectOption> options = new List<SelectOption>();
	  List<Contact> citylist = new List<Contact>();
	  citylist = [Select Id, PicklistValue__c FROM Contact];
	  system.debug('***citylist'+citylist);
	  options.add(new SelectOption('--None--','--None--'));
	  for (Integer j=0;j<citylist.size();j++)
	  {	
	     options.add(new SelectOption(citylist[j].PicklistValue__c,citylist[j].PicklistValue__c));
	  }
	  system.debug('***options'+options);
	  return options;
	}
	
	
	
	public void saverec()
	{
	  Contact newrec = new Contact(PicklistValue__c=newpicklistvalue);
	  insert newrec;
	  newpicklistvalue=NULL;
	}

}