public with sharing class ExternalDataCTRL {
  @AuraEnabled(cacheable=true)
  public static List<Object> fetchDataFromExternalApi() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();

    request.setEndpoint('https://avenga-school.herokuapp.com/retrieve-data');
    request.setMethod('GET');
    request.setHeader('projectName', 'Totalizator');

    HttpResponse response = http.send(request);

    List<Object> bets = new List<Object>();

    if (response.getStatusCode() == 200) {
      bets = (List<Object>) JSON.deserializeUntyped(response.getBody());
    }

    return bets;
  }
}
