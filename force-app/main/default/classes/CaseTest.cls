@isTest
public class CaseTest {
    @TestSetup
    public static void dummydata()
    {
        Test.startTest();
        Account acc = TestDataFactory.createacc('Test Account','Banking','Hot');
        insert acc;
        Account ac = TestDataFactory.createacc('New Account','Banking','Hot');
        insert ac;
        Test.stopTest();
    }
    @isTest
    public static void DMLInsertion()
    {
        Test.startTest();
        Account acc = [Select Id,Name,Industry,Rating from Account where Name ='Test Account'];
        Case customercase = TestDataFactory.createCase('Customer_Support_Cases', 'New', 'Phone');
        insert customercase;
        Case cse =[Select Id,AccountId,Status,Origin from Case where Id =: customercase.id];
        cse.AccountId = acc.Id;
        Update cse;
        Case salescase = TestDataFactory.createCase('Sales_Cases', 'New', 'Phone');
        insert salescase;
        Case slcse =[Select Id,AccountId,Status,Origin from Case where Id =: salescase.id];
        slcse.AccountId = acc.Id;
        Update slcse;
    }
   @isTest
    public static void DMLUpdation()
    {
        Test.startTest();
        Account acc = [Select Id,Name,Industry,Rating from Account where Name ='Test Account'];
        Account ac = [Select Id,Name,Industry,Rating from Account where Name ='New Account'];

        Case customercase = TestDataFactory.createCase('Customer_Support_Cases', 'New', 'Phone');
        insert customercase;
        Case cse =[Select Id,AccountId,Status,Origin from Case where Id =: customercase.id];
        cse.AccountId = acc.Id;
        Update cse;
      //  Case salescase = TestDataFactory.createCase('Sales_report', 'New', 'Phone');
        //insert salescase;
       Case slcse =[Select Id,AccountId,Status,Origin from Case where Id =: cse.id];
        slcse.AccountId = ac.Id;
        Update slcse;
        
        Case latestcase = [Select Id,RecordTypeId from Case where Id =:slcse.id];
        update latestcase;
        Test.stopTest();
    } 
    @isTest
    public static void DMLDeletion()
    {
        Test.startTest();
        Account acc = [Select Id,Name,Industry,Rating from Account where Name = 'Test Account'];
        Case customercase = TestDataFactory.createCase('Customer_Support_Cases', 'New', 'Phone');
        insert customercase;
        Case cse = [Select Id,AccountId,Status,Origin from Case where Id =: customercase.Id];
        cse.AccountId = acc.Id;
        Update cse;
        delete cse;
        Test.stopTest();
    }
    @isTest
    public static void DMLUndeletion()
    {
        Test.startTest();
        Account acc = [Select Id,Name,Industry,Rating from Account where Name = 'Test Account'];
        Case customercase = TestDataFactory.createCase('Customer_Support_Cases', 'New', 'Phone');
        insert customercase;
         Case cse = [Select Id,AccountId,Status,Origin from Case where Id =: customercase.Id];
        cse.AccountId = acc.Id;
        Update cse;
        delete cse;
        List<Case> deletedCases = [Select Id,IsDeleted From Case where Id =: cse.Id ALL ROWS];
        Undelete deletedCases;
        Test.stopTest();
    }
}