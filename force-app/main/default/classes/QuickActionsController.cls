public class QuickActionsController {
   
    @AuraEnabled
    public static Map<String, Object> getDefaultValues() {
        Map<String, Object> defaultValues = new Map<String, Object>();
        
        // Fetch the user (Agent)
        User agent = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        defaultValues.put('Agent__c', agent.Id);
        
        // Set the date to today
        defaultValues.put('Date__c', Date.today());
        
        // Fetch the product from the lookup (replace 'Estimation_Product__c' with your actual field name)
        Product2 record = [SELECT Id FROM Product2 WHERE Id = '01tNS000007vvlXYAQ' LIMIT 1];
        defaultValues.put('Product__c', record.id);
        system.debug('defaultValues : '+defaultValues);
        return defaultValues;
    }
}