@isTest
public with sharing class TestPlayerManager {
  @isTest
  static void testGetTopPlayers() {
    //given
    //i = 0, 10 players, 1000 + (10 * i++) total money won
    List<Player__c> mockPlayers = TestDataFactory.creatPlayersWithAscedingTotalMoneyWon(
      10,
      1000
    );
    RestRequest request = new RestRequest();
    request.requestUri = 'https://sebastian-dev-ed.my.salesforce.com/services/apexrest/topPlayers/5';
    request.httpMethod = 'GET';
    RestContext.request = request;

    //when
    Test.startTest();
    List<Player__c> resultPlayers = PlayerManager.getTopPlayers();
    Test.stopTest();

    //then
    System.assert(resultPlayers.size() == 5);
    System.assertEquals(1090, resultPlayers[0].get('Total_Money_Won_2__c'));
    System.assertEquals('testName 9', resultPlayers[0].get('Name__c'));
    // System.assertEquals(expected, actual)
  }
}
