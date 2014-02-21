global with sharing class justcheck {
 
      public Department__c pos{get;set;}
      public List<Department__c> title{get;set;}
      public List<Department__c> positions{get;set;}
 
      public justcheck() {
 
         pos = [select Name,Department_Name__c,Description__c from Department__c Limit 1];
      }
       /**
      * Method that creates the select option dynamically.
      **/
 
      public List<SelectOption> getOptions() {
 
          List<SelectOption> options = new List<SelectOption>();
          title = [select Name from Department__c];
         //Creating an NULL option.
         options.add(new SelectOption('none','--Select--'));
         for( Department__c a :title ){
            options.add(new SelectOption(a.Name,a.Name));
         }
         return options;
      }
 
      /**
      * Remote action involved with Javascript remoting and is made global
      **/
 
      @RemoteAction
      global static Department__c[] getPositionDetails(String pos) {
          return [select Name,Department_Name__c,Description__c from Department__c WHERE Department_Name__c =: pos Limit 1];
 
      }
 
}