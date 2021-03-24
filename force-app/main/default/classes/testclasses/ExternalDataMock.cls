@isTest
global with sharing class ExternalDataMock implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest request) {
    // Create a fake response
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    response.setBody(
      '[{ "amount": 1444, "gameName": "Super Game 1", "lot": "4" ,"playerName" : "Tom","status" : "Won","winRate" : 9},' +
      '{ "amount": 950, "gameName": "Super Game 2", "lot": "7" ,"playerName" : "John","status" : "Lost","winRate" : 56},' +
      '{ "amount": 3500, "gameName": "Super Game 3", "lot": "23" ,"playerName" : "Anna","status" : "Pending","winRate" : 150}]'
    );
    response.setStatusCode(200);
    return response;
  }
}
