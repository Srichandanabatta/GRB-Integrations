public class TestDataFactory {
public static Case createCase(String devName,String status,String origin)
{
    Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(devName).getRecordTypeId();
    return new Case(
    Subject ='Test Case',
    RecordTypeId =recordTypeId,
    Status = status,
    Origin = origin
    );
}
    public static Account createacc(String accname,String industry,String rating)
    {
        return new Account(
        Name = accname,
        Industry = industry,
        Rating = rating
        );            
    }
    }