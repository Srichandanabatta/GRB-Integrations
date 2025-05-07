@RestResource(urlMapping='/fetchUserData/*')
global with sharing class FetchDataForContact {

    // Wrapper class for request body
    public class ContactRequest {
        public String contactId;
    }

    /*@HttpPost
    global static void fetchUserData() {
        try {
            // ✅ Fix: Use RestContext.request.requestBody.toString() instead of getBody()
            String requestBody = RestContext.request.requestBody.toString();
            
            // Deserialize request JSON into Apex object
            ContactRequest requestData = (ContactRequest) JSON.deserialize(requestBody, ContactRequest.class);

            // ✅ Validate if contactId is provided
            if (String.isBlank(requestData.contactId)) {
                throw new CustomException('Contact Id is required');
            }

            // Make an API callout to fetch random user data
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://randomuser.me/api/');
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Parse JSON response
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> users = (List<Object>) result.get('results');

                if (!users.isEmpty()) {
                    Map<String, Object> userData = (Map<String, Object>) users[0];
                    Map<String, Object> nameData = (Map<String, Object>) userData.get('name');

                    // Extract Data
                    String firstName = (String) nameData.get('first');
                    String lastName = (String) nameData.get('last');
                    String email = (String) userData.get('email');
                    String phone = (String) userData.get('phone');

                    // Find and Update Contact Record
                    Contact contactToUpdate = [SELECT Id FROM Contact WHERE Id = :requestData.contactId LIMIT 1];
                    contactToUpdate.FirstName = firstName;
                    contactToUpdate.LastName = lastName;
                    contactToUpdate.Email = email;
                    contactToUpdate.Phone = phone;

                    update contactToUpdate;

                    // ✅ Send Success Response
                    RestContext.response.responseBody = Blob.valueOf('{"message": "Contact updated successfully", "contactId": "' + requestData.contactId + '"}');
                } else {
                    throw new CustomException('No user data found from API');
                }
            } else {
                throw new CustomException('API callout failed, Status Code: ' + response.getStatusCode());
            }
        } catch (CustomException ce) {
            RestContext.response.responseBody = Blob.valueOf('{"error":"' + ce.getMessage() + '"}');
        } catch (Exception e) {
            RestContext.response.responseBody = Blob.valueOf('{"error":"Exception: ' + e.getMessage() + '"}');
        }
    }*/

    // Custom Exception Class
    public class CustomException extends Exception {}
}