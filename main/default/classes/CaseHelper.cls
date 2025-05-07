public class CaseHelper {
    @future
    public static void CaseLogic(set<Id> accids)
    {
        List<Account> acclist = new List<Account>();
        Map<Id,String> casemap = new Map<Id,String>();
        List<String> devNames = system.Label.Case_record_types.split(',');
        System.debug('devNames Size: '+devNames.size());
        System.debug('devNames 1 : '+devNames[0]);
        System.debug('devNames 2 : '+devNames[1]);
        List<RecordType> rctyplist = [Select id,DeveloperName from RecordType where SobjectType ='Case' And DeveloperName IN :devNames];
        for(RecordType rctyp : rctyplist )
        {
            casemap.put(rctyp.Id , rctyp.DeveloperName);
        }
        if(!accids.isEmpty())
        {
            acclist = [Select Id,Customer_Support_Cases__c,Sales_Cases__c,(Select Id,AccountId,RecordTypeId From Cases) From Account where Id IN : accids];
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Account a : acclist)
        {
            system.debug('accountsToUpdate : '+a.id);
            Integer customerCases = 0;
            Integer salesCases = 0;
            for(Case cs : a.Cases){
                system.debug('Case RecordTypeId : '+cs.RecordTypeId);
                
                if(casemap.containskey(cs.RecordTypeId))
                {
                    string devName = casemap.get(cs.RecordTypeId);
                    if(devName == System.Label.Customer_Support_Team)
                    {
                        customerCases++;
                    }
                    else if(devName == System.Label.Sales_Support_Team)
                    {
                        salesCases++;
                    }
                }
            }
            a.Customer_Support_Cases__c =customerCases;
            a.Sales_Cases__c =salesCases;
            accountsToUpdate.add(a);
        }
        
        
        
        if(!accountsToUpdate.isEmpty())
        {
            update accountsToUpdate;
        }
        
    }   
}