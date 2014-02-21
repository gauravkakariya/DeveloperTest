public with sharing class deleteaccount 
{

        public void deleteaccount()
        {
            
            
        }
        
        
        public void onBeforeInsert(set<ID> setNewAccountID)
        {
            //Account objacc=New Account();
            /* for(Account objacc: lstAcc)          
            {
                for(Account objAcc1: [select Id,Name from Account])
                {
                    if (objacc.Name==objAcc1.Name)
                    {
                     delete objAcc;
                    }
                }
            
            }*/
            if(setNewAccountID!=null){
                List<Account> lstAccount=new List<Account>();
                lstAccount=[select Id, Name from Account where Id Not In : setNewAccountID];
                delete lstAccount;
            }
        }

}