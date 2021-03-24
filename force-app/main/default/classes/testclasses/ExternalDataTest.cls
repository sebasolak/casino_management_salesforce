@isTest
public with sharing class ExternalDataTest {
  @isTest
  static void itShouldFetchAllBetsFromExternalApiTest() {
    //given
    Test.setMock(HttpCalloutMock.class, new ExternalDataMock());

    //when
    List<Object> results = ExternalDataCTRL.fetchDataFromExternalApi();

    //then
    System.assertEquals(results.size(), 3);

    String jsonBody =
      '[{ "amount": 1444, "gameName": "Super Game 1", "lot": "4" ,"playerName" : "Tom","status" : "Won","winRate" : 9},' +
      '{ "amount": 950, "gameName": "Super Game 2", "lot": "7" ,"playerName" : "John","status" : "Lost","winRate" : 56},' +
      '{ "amount": 3500, "gameName": "Super Game 3", "lot": "23" ,"playerName" : "Anna","status" : "Pending","winRate" : 150}]';

    List<Object> bets = (List<Object>) JSON.deserializeUntyped(jsonBody);

    System.assertEquals(bets, results);
  }
}
