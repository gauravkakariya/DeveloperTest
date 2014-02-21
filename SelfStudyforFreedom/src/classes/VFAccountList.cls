public with sharing class VFAccountList
 {

    public String getAccounts() {
        return null;
    }


    public String Accounts { get; set; }
    public VFAccountList()
    {
        
        
    }

    public ApexPages.Standardsetcontroller setCon
    {
        get
        {
            if(setCon==null)
            {
                setCon=new ApexPages.Standardsetcontroller(Database.getQueryLocator([select Name,Full_Name__c,Id,Email__c,Phone from Account Limit 5]));
            }
            return setCon;
        }
        
        set;
    }

public List<Account> getAccount()
{
    return (List<Account>) setCon.getRecords();
    
}

}