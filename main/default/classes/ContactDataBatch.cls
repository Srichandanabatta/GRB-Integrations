global class ContactDataBatch implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email != NULL');
    }

    global void execute(Database.BatchableContext BC, List<Contact> contactsToUpdate) {
        if (contactsToUpdate.isEmpty()) {
            System.debug('No contacts found for update.');
            return;
        }

        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://randomuser.me/api/');
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> users = (List<Object>) result.get('results');

                if (!users.isEmpty()) {
                    Map<String, Object> userData = (Map<String, Object>) users[0];
                    Map<String, Object> nameData = (Map<String, Object>) userData.get('name');

                    for (Contact c : contactsToUpdate) {
                        c.FirstName = nameData.get('first') != null ? (String) nameData.get('first') : c.FirstName;
                        c.LastName = nameData.get('last') != null ? (String) nameData.get('last') : c.LastName;
                        c.Email = userData.get('email') != null ? (String) userData.get('email') : c.Email;
                        c.Phone = userData.get('phone') != null ? (String) userData.get('phone') : c.Phone;
                    }

                    update contactsToUpdate;
                }
            } else {
                System.debug('API callout failed: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception during Contact update: ' + e.getMessage());
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Batch processing completed.');
    }
}