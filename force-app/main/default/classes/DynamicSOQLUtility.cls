public with sharing class DynamicSOQLUtility {
    
    @AuraEnabled
    public static List<SObject> executeDynamicSOQL(String objectName, List<String> fields, Map<String, String> filters) {
        try {
            // Validate input
            if (String.isEmpty(objectName) || fields.isEmpty()) {
                throw new IllegalArgumentException('Object name and fields cannot be empty.');
            }

            // Build the SELECT clause
            String soqlQuery = 'SELECT ' + String.join(fields, ', ') + ' FROM ' + objectName;

            // Build the WHERE clause dynamically based on user-provided filters
            List<String> whereConditions = new List<String>();
            for (String field : filters.keySet()) {
                String value = filters.get(field);
                whereConditions.add(field + ' = \'' + value + '\'');
            }

            if (!whereConditions.isEmpty()) {
                soqlQuery += ' WHERE ' + String.join(whereConditions, ' AND ');
            }

            System.debug('Generated SOQL: ' + soqlQuery);

            // Execute the dynamic SOQL query
            return Database.query(soqlQuery);

        } catch (Exception e) {
            throw new AuraHandledException('Error executing dynamic SOQL: ' + e.getMessage());
        }
    }
}