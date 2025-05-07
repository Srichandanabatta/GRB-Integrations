public class CaseHandler {
    public static void CaseInsertion(List<Case> cslist)
    {
     set<Id> accids = new set<Id>();
        if(!cslist.isEmpty())
        {
            for(Case cs : cslist)
            {
                if(cs.AccountId != null)
                {
                    accids.add(cs.AccountId);
                }
            }
        }
        system.debug('Account Ids :  '+ accids);
        CaseHelper.CaseLogic(accids);
    }
    public static void CaseUpdation(List<Case> cslist, Map<Id,Case> oldmap )
    {
        set<Id> accids = new set<Id>();
        if(!cslist.isEmpty())
        {
            for(Case cs : cslist)
            {
                Case oldcs = oldmap.get(cs.id);
                if(cs.AccountId != null && cs.AccountId !=oldcs.AccountId || cs.RecordTypeId != oldcs.RecordTypeId )
                {
                   accids.add(cs.AccountId);
                   accids.add(oldcs.AccountId);
                }
            }
        }
        CaseHelper.CaseLogic(accids);
    }
    public static void CaseDeletion(List<Case> oldcaselist)
    {
        set<Id> accids = new set<Id>();
        if(!oldcaselist.isEmpty())
        {
            for(Case cs : oldcaselist)
            {
                if(cs.AccountId != null)
                {
                 accids.add(cs.AccountId);   
                }
            }
        }
                CaseHelper.CaseLogic(accids);
    }
    public static void CaseUndeletion(List<Case> cslist)
    {
        set<Id> accids = new set<Id>();
        if(!cslist.isEmpty())
        {
            for(Case cs : cslist)
            {
                if(cs.AccountId != null)
                {
                 accids.add(cs.AccountId);                       
                }
            }
        }
            CaseHelper.CaseLogic(accids);
    }
}