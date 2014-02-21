Global class SaveOverrideDepartmentController{ 
    private final Departments__c dept;
    private ApexPages.StandardController stdController;

    public SaveOverrideDepartmentController(ApexPages.StandardController stdController) { 
        this.dept = (Departments__c )stdController.getRecord(); 
        this.stdController = stdController;
    } 

    webservice static void save(Boolean isValue) { 
        // Put my own stuff here
        system.debug('Helloooooo');
        // Do the standard save action  
        
    }
}