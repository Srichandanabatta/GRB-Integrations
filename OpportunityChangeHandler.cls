public class OpportunityChangeHandler {

    public static void processOpportunities(List<OpportunityChangeEvent> events) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://external-api.example.com/opportunity/update'); // Change to your API endpoint
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');

        List<Map<String, String>> opportunityUpdates = new List<Map<String, String>>();

        for (OpportunityChangeEvent event : events) {
            Map<String, String> data = new Map<String, String>();
            data.put('opportunityId', event.Id);
            data.put('stage', event.StageName);
            opportunityUpdates.add(data);
        }

        // Convert List to JSON
        String jsonBody = JSON.serialize(opportunityUpdates);
        request.setBody(jsonBody);

        try {
            HttpResponse response = http.send(request);
            System.debug('API Response: ' + response.getBody());
        } catch (Exception e) {
            System.debug('Error in API callout: ' + e.getMessage());
        }
    }
}