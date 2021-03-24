@isTest
public with sharing class TestGameTableCTRL {
  @isTest
  static void itShouldGetAllGamesThisWeek() {
    //given
    List<Game__c> gamesThisWeek = TestDataFactory.createGameWithGivenDate(
      10,
      DateTime.Now(),
      9500
    );
    List<Game__c> gamesNotThisWeek = TestDataFactory.createGameWithGivenDate(
      5,
      DateTime.Now().addMonths(1),
      500
    );

    //then
    Test.startTest();
    List<Game__c> resultGames = GameTableCTRL.getGameList();
    Test.stopTest();

    //when
    System.assertEquals(resultGames.size(), 10);
    for (Game__c game : resultGames) {
      System.assertEquals(game.get('Total_Income__c'), 9500);
    }
  }
}
