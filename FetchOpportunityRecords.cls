public without sharing class FetchOpportunityRecords {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Phone,AnnualRevenue FROM Account
            order by lastModifiedDate desc LIMIT 10
        ];
    }
    @AuraEnabled
    public static void updateRecords(List<Account> updatedRecords) {
        try {
            update updatedRecords;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}