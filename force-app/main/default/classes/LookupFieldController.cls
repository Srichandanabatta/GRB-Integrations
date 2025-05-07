/**
* @File Name : LookupFieldController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : April 19, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | April 19, 2025 |   | Initial Version
**/

public with sharing class LookupFieldController {

    /**
     * Fetches a list of Contacts related to a given Account Id.
     * 
     * @param accountId The Id of the Account.
     * @return List<Contact> A list of Contact records with Id and Name.
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(Id accountId) {
        System.debug('### [START] getContactsByAccountId called');
        System.debug('### Provided Account Id: ' + accountId);

        // Input validation
        if (String.isBlank(accountId)) {
            System.debug('### Invalid Account Id detected');
            throw new AuraHandledException('Invalid Account Id provided.');
        }

        List<Contact> contactList = new List<Contact>();

        try {
            // SOQL query for related contacts
            contactList = [
                SELECT Id, Name 
                FROM Contact 
                WHERE AccountId = :accountId 
                ORDER BY Name 
                LIMIT 100
            ];
            System.debug('### Retrieved ' + contactList.size() + ' contact(s)');

        } catch (Exception ex) {
            System.debug('### Exception occurred while retrieving contacts: ' + ex.getMessage());
            throw new AuraHandledException('Error retrieving contacts: ' + ex.getMessage());
        }

        System.debug('### [END] getContactsByAccountId');
        return contactList;
    }
}