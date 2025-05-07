public class YT_WeatherApi {
@AuraEnabled
    public static WeatherDetailsWrapper getWeatherDetails(String cityName){
        //Frame the Endpoint URL
        String apiKey ='3f6c61dc4cf822d2bb377ce8e2ce9550';
        String endpoint = 'http://api.openweathermap.org/data/2.5/weather';
        endpoint += '?q='+cityName;
        endpoint += '&units=metric';
        endpoint += '&APPID='+apiKey;
        system.debug('endPoint URL '+endpoint);
        
        //Callout to Weather API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        system.debug('res '+res+ ' body '+JSON.deserializeUntyped(res.getBody()));
        
        //return the weather details in wrapper form
       WeatherDetailsWrapper weatherDet = new WeatherDetailsWrapper();
        if(res.getStatusCode() == 200){
            Map<String,object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            weatherDet.city = String.valueOf(result.get('name'));
            Map<String,object> mainResult = (Map<String,object>)(result.get('main'));
            weatherDet.temperature = String.valueOf(mainResult.get('temp'));
            weatherDet.pressure = String.valueOf(mainResult.get('pressure'));
            weatherDet.humidity = String.valueOf(mainResult.get('humidity'));
            weatherDet.feelsLike = String.valueOf(mainResult.get('feels_like'));
            weatherDet.tempMin = String.valueOf(mainResult.get('temp_min'));
            weatherDet.tempMax = String.valueOf(mainResult.get('temp_max'));
        }
        system.debug('weatherDet '+weatherDet);
        return weatherDet;
    }
    
    //Wrapper class to store weather details in serial manner
    public class WeatherDetailsWrapper{
        @AuraEnabled public String city {get;set;}
        @AuraEnabled public String temperature {get;set;}
        @AuraEnabled public String pressure {get;set;}
        @AuraEnabled public String humidity {get;set;}
        @AuraEnabled public String feelsLike {get;set;}
        @AuraEnabled public String tempMin {get;set;}
        @AuraEnabled public String tempMax {get;set;}
    }
}