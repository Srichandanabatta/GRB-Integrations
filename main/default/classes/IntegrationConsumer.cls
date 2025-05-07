public class IntegrationConsumer {

    public static void Callout(){
        Http http = new Http();
        //Sending request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');//method should be get as we are getting data from the another system
        req.setEndpoint('Callout:Sf_target_org_credential/services/apexrest/DataAvailable');//from which url
        req.setHeader('Content-Type', 'application/json'); // Adding Content-Type header

        HttpResponse res = http.send(req);
        system.debug('Status Code is '+res.getStatusCode());
        if(res.getStatusCode() == 200)
        {
            system.debug('This is data '+res.getBody());
        }
    }
}