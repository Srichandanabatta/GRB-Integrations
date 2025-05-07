public with sharing class MassUpdateOpportunityController {
    @AuraEnabled
    public static void updateOpportunities(List<Id> opportunityIds) {
        if (opportunityIds.isEmpty()) {
            throw new AuraHandledException('No records selected!');
        }

        List<Opportunity> oppsToUpdate = [SELECT Id, StageName FROM Opportunity WHERE Id IN :opportunityIds];

        for (Opportunity opp : oppsToUpdate) {
            opp.StageName = 'Closed Won';
        }

        update oppsToUpdate;
    }
}