@isTest
public class LeadRestAPITest {

    @isTest
    static void testCreateLead() {
        // Set up the test data
        String firstName = 'John';
        String lastName = 'Doe';
        String email = 'johndoe@example.com';
        
        // Create a mock REST request with the given data
        RestRequest req = new RestRequest();
        req.addHeader('Content-Type', 'application/json');
        
        // Create a JSON string for the body
        String requestBody = '{"firstName": "' + firstName + '", "lastName": "' + lastName + '", "email": "' + email + '"}';
        
        // Salesforce doesn't allow setting the body using `setBody()` directly in the test, 
        // so we assign the body via the constructor of the request.
        req.requestBody = Blob.valueOf(requestBody);
        
        // Set the RestRequest in the context
        RestContext.request = req;
        
        // Create a mock HTTP response
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Start the test context
        Test.startTest();
        
        // Call the REST API method
        String result = LeadRestAPI.createLead(firstName, lastName, email);
        
        // Assert the expected outcome
        System.assertEquals('Lead Created Successfully!', result);
        
        // Verify that the lead was created in Salesforce
        Lead createdLead = [SELECT FirstName, LastName, Email FROM Lead WHERE Email = :email LIMIT 1];
        System.assertNotEquals(null, createdLead);
        System.assertEquals(firstName, createdLead.FirstName);
        System.assertEquals(lastName, createdLead.LastName);
        System.assertEquals(email, createdLead.Email);
        
        // End the test context
        Test.stopTest();
    }
}