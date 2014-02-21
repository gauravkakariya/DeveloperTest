trigger AccountDeleteTrigger on Account (After insert) 
{
        deleteaccount objdelete=new deleteaccount();
        public set<ID> setNewAccountID = trigger.newMap.keyset();
        if(trigger.isAfter && trigger.isInsert)
        { 
            system.debug('@@@@@@@@@Print the text');
                objdelete.onBeforeInsert(setNewAccountID );
                
            
        }
        

}