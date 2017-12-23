public class SaveResultMailer {

    private List<String> failed_ids = new List<String>();
    private List<String> success_ids = new List<String>();
    public List<String> recipients = new List<String>();
    public String display_name = 'SF Result Mailer';
    public String replyto;
    
    public SaveResultMailer(){}
    
    public SaveResultMailer(Database.SaveResult[] sr_list){
        
        for(Database.SaveResult sr : sr_list){                     
            if(!sr.isSuccess())
            {
                failed_ids.add(sr.getId());
            }
            else{
                success_ids.add(sr.getId());
            }
        }       
    }
    
    
          
    public static void send(List<SaveResultMailer> sr_msg_list){
        List<Messaging.SingleEmailMessage> mail_list = new List<Messaging.SingleEmailMessage>();
   
        for(SaveResultMailer sr_msg : sr_msg_list){      
        String failed_header = 'Id\n';
        String success_header = 'Id\n';
        if(sr_msg.failed_ids.size() > 0 || sr_msg.success_ids.size() > 0){       
     
        for(String s : sr_msg.failed_ids){
            failed_header += s + '\n';
        }
            for(String s : sr_msg.success_ids){
            success_header += s + '\n';
        }
            }
         
        
        Blob failedBlob = Blob.valueOf(failed_header);  
        Blob successBlob = Blob.valueOf(success_header);
        
        
        Messaging.EmailFileAttachment failedAttachment = new Messaging.EmailFileAttachment();
        Messaging.EmailFileAttachment successAttachment = new Messaging.EmailFileAttachment();
        
        failedAttachment.setBody(failedBlob);
        failedAttachment.setFileName('Failed Operation - ' + DateTime.now().format() + '.csv');
        
        successAttachment.setBody(successBlob);
        successAttachment.setFileName('Successful Operation - ' + DateTime.now().format() + '.csv');
        
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        if(sr_msg.replyto != null){
            mail.setReplyTo(sr_msg.replyto);
        }
        mail.setToAddresses(sr_msg.recipients);     
        mail.setSenderDisplayName(sr_msg.display_name);
        mail.setSubject('Operation has completed at ' + DateTime.now().format());
        mail.setHtmlBody('The results of the Apex operation are below: <br>'  + 'Successful Operations: ' + sr_msg.success_ids.size() + 
                         '<br>Failed Operations: ' + sr_msg.failed_ids.size());
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {failedAttachment,successAttachment});
        
        mail_list.add(mail);
        }
        Messaging.sendEmail(mail_list);
    }
    //Returns Map of successful IDs and failed IDs
    public Map<String,List<ID>> getIDResults(){ 
        
        Map<String, List<ID>> resultIDMap = new Map<String,List<ID>>();
        
        resultIDMap.put('successes', this.success_ids);
        resultIDMap.put('failures', this.failed_ids);
        
        return resultIDMap;
    }
        
        
    
}