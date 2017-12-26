@isTest
private class SaveResultMailerTest {

    private static string testRecipient = UserInfo.getUserEmail();
    
    private static List<Account> createTestData(integer numAccounts){
        
        List<Account> accountsToInsert = new List<Account>();
        for(integer i = 0; i < numAccounts; i++){
            
            Account acct = new Account();
            
            acct.Name = 'Test ' + (i+1);
            
            accountsToInsert.add(acct);

        }
        
        return accountsToInsert;
        
        
    }
    
    
    
    private static testMethod void testSuccessfulEmailInvocations(){
        final integer expectedInvocations = 1;      
        
        test.startTest();
        
        SaveResultMailer srm = new SaveResultMailer(database.insert(createTestData(100),false));
        srm.recipients.add(testRecipient);
        
        SaveResultMailer.send(new List<SaveResultMailer>{srm});
        
        system.assertEquals(expectedInvocations, Limits.getEmailInvocations(), 'getMailInvocations did not return the expected value of ' + expectedInvocations);
        
        test.stopTest();
                  
        
    }
    
}