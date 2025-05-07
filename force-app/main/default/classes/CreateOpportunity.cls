/*@RestResource(urlMapping='/Opportunity/*')
global class CreateOpportunity {

// This method will handle the HTTP POST request to create an opportunity
@HttpPost
global static String createOpportunity(String opportunityName, String stageName, Date closeDate, Decimal amount, String accountId) {

// Debugging: Log the incoming request data
System.debug('Incoming request data:');
System.debug('Opportunity Name: ' + opportunityName);
System.debug('Stage Name: ' + stageName);
System.debug('Close Date: ' + closeDate);
System.debug('Amount: ' + amount);
System.debug('Account ID: ' + accountId);

// Check if all required parameters are provided
if (String.isEmpty(opportunityName) || String.isEmpty(stageName) || closeDate == null || amount == null || String.isEmpty(accountId)) {
// Debugging: Log the missing parameters
System.debug('Error: Missing required parameters');
throw new AuraHandledException('Missing required parameters');
}

// Create a new Opportunity object
Opportunity newOpportunity = new Opportunity();
newOpportunity.Name = opportunityName;
newOpportunity.StageName = stageName;
newOpportunity.CloseDate = closeDate;
newOpportunity.Amount = amount;
newOpportunity.AccountId = accountId;

// Debugging: Log the Opportunity details before insert
System.debug('Creating Opportunity with the following details:');
System.debug('Opportunity Name: ' + newOpportunity.Name);
System.debug('Stage Name: ' + newOpportunity.StageName);
System.debug('Close Date: ' + newOpportunity.CloseDate);
System.debug('Amount: ' + newOpportunity.Amount);
System.debug('Account ID: ' + newOpportunity.AccountId);

try {
// Insert the Opportunity record
insert newOpportunity;

// Debugging: Log successful creation
System.debug('Opportunity successfully created with ID: ' + newOpportunity.Id);

// Return the ID of the created opportunity as the response
return newOpportunity.Id;
} catch (DmlException e) {
// Debugging: Log error message if the insert fails
System.debug('DML Error: ' + e.getMessage());
throw new AuraHandledException('Error creating Opportunity: ' + e.getMessage());
}
}
}*/
@RestResource(urlMapping='/Opportunity/*')
global class CreateOpportunity {
    
    // Wrapper class to handle incoming JSON request data
    public class OpportunityWrapper {
        public String opportunityName;
        public String stageName;
        public Date closeDate;
        public Decimal amount;
        public String accountId;
    }
    
    @HttpPost
    global static String createOpportunity() {
        try {
            // Retrieve JSON request body as a string
            String requestBody = RestContext.request.requestBody.toString();
            system.debug('requestBody = '+requestBody);
            // Deserialize JSON into the OpportunityWrapper class
            OpportunityWrapper oppData = (OpportunityWrapper) JSON.deserialize(requestBody, OpportunityWrapper.class);
            
            // Debugging: Log the incoming request data
            System.debug('Incoming request data: ' + JSON.serializePretty(oppData));
            
            // Validate required fields
            if (String.isEmpty(oppData.opportunityName) || 
                String.isEmpty(oppData.stageName) || 
                oppData.closeDate == null || 
                oppData.amount == null || 
                String.isEmpty(oppData.accountId)) {
                    throw new AuraHandledException('Missing required parameters');
                }
            
            // Create and insert the Opportunity record
            Opportunity newOpportunity = new Opportunity(
                Name = oppData.opportunityName,
                StageName = oppData.stageName,
                CloseDate = oppData.closeDate,
                Amount = oppData.amount,
                AccountId = oppData.accountId
            );
            
            insert newOpportunity;
            
            // Debugging: Log successful creation
            System.debug('Opportunity successfully created with ID: ' + newOpportunity.Id);
            
            // Return JSON response
            Map<String, String> responseMap = new Map<String, String>();
            responseMap.put('message', 'Successfully created Opportunity');
            responseMap.put('opportunityId', newOpportunity.Id);
            
            return JSON.serialize(responseMap);
            
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            throw new AuraHandledException('Error creating Opportunity: ' + e.getMessage());
        }
    }
}