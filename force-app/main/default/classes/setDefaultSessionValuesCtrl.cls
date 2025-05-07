public class setDefaultSessionValuesCtrl{
    /*@AuraEnabled
public static Session_Time__c sessionDefaultDetails()
{
Id currentUserId = UserInfo.getUserId();
Product2 prd = [select id from Product2 where Id='01tNS000007vvlXYAQ'];
RecordType recType = [select id ,name from RecordType where id='012NS000002rLQ9YAM'];
Date Todaydate = system.today();
Session_Time__c sessionRecord = [select Id,Agent__c,Date__c,Product__c from Session_Time__c ];
sessionRecord.Agent__c=  currentUserId;
sessionRecord.Date__c = system.today();
sessionRecord.Product__c=prd.id;
sessionRecord.RecordTypeId=recType.id;
return sessionRecord;
}*/
    @AuraEnabled
    public static Product2 getProduct() {
        // Query to get a product ID
        Product2 product = [SELECT Id FROM Product2 where Id='01tNS000007vvlXYAQ' LIMIT 1];
        return product;
        
    }
}