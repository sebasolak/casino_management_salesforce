@isTest
public with sharing class TestBetCTRLFinal {
  @isTest
  static void testItShouldGetAllBetsByPlayerId() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      1,
      5,
      150
    ); //1 player,5 bets, 150$ per bet

    List<Id> playersIds = new List<Id>();

    for (Bet__c bet : bets) {
      playersIds.add(bet.Player__c);
    }

    //when
    Test.startTest();
    List<Bet__c> resultBets = BetCTRLFinal.getBetsList(playersIds[0]);
    Test.stopTest();

    //then
    System.assertEquals(5, resultBets.size());
    for (Bet__c bet : resultBets) {
      System.assertEquals(bet.get('Amount__c'), 150);
      System.assertEquals(bet.get('Status__c'), 'Won');
      System.assertEquals(bet.get('Win_Rate__c'), 250);
    }
  }
}
