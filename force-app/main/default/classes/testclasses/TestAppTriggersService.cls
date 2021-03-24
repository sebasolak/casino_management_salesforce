@isTest
public with sharing class TestAppTriggersService {
  @IsTest
  static void testOnePlayerAndGameUpdateOnBet() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      1,
      1,
      200
    );
    TestDataFactory.changeBetStatus(bets, 'Lost');

    //when
    Test.startTest();
    Database.SaveResult updateResult = Database.update(bets[0], false);
    Test.stopTest();

    //then
    System.assert(updateResult.isSuccess());
  }

  @IsTest
  static void testBulkUpdateOnBet() {
    //given
    //numPlayers, numBetsPerPlayer, moneyPerBet
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      100,
      2,
      200
    );
    //100 players * 2 bets
    TestDataFactory.changeBetStatus(bets, 'Lost');
    // TestDataFactory.changeBetAmount(bets, null);

    //when
    Test.startTest();
    Database.SaveResult[] updateResult = Database.update(bets, false);
    Test.stopTest();

    //then
    for (Database.SaveResult upRes : updateResult) {
      System.assert(upRes.isSuccess());
    }
  }
  @IsTest
  static void testBulkUpdateOnBetWhenBetIsInvalid() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      200,
      1,
      200
    );
    //200 players * 1 bets
    TestDataFactory.changeBetWinRate(bets, null);

    //when
    Test.startTest();
    Database.SaveResult[] updateResult = Database.update(bets, false);
    Test.stopTest();

    //then
    for (Database.SaveResult upRes : updateResult) {
      System.assert(!upRes.isSuccess());
      System.assert(upRes.getErrors().size() > 0);
    }
  }

  @IsTest
  static void testUpdateOnBetWhenBetIsInvalid() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      1,
      1,
      200
    );
    TestDataFactory.changeBetWinRate(bets, null);

    //when
    Test.startTest();
    Database.SaveResult updateResult = Database.update(bets[0], false);
    Test.stopTest();

    //then
    System.assert(!updateResult.isSuccess());
    System.assert(updateResult.getErrors().size() > 0);
  }

  @IsTest
  static void testUpdateOnOneGame() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(1, 1, 200);

    //when
    Test.startTest();
    Database.SaveResult updateResult = Database.update(games[0], false);
    Test.stopTest();

    //then
    System.assert(updateResult.isSuccess());
  }
  @IsTest
  static void testUpdateOnOneGameWhenGameIsInvalid() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(1, 1, 200);
    TestDataFactory.changeGameType(games, null);
    //when
    Test.startTest();
    Database.SaveResult updateResult = Database.update(games[0], false);
    Test.stopTest();

    //then
    System.assert(!updateResult.isSuccess());
    System.assert(updateResult.getErrors().size() > 0);
  }

  @IsTest
  static void testUpdateBulkGames() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(200, 1, 168);

    //when
    Test.startTest();
    Database.SaveResult[] updateResult = Database.update(games, false);
    Test.stopTest();

    //then
    for (Database.SaveResult upRes : updateResult) {
      System.assert(upRes.isSuccess());
    }
  }

  @IsTest
  static void testUpdateBulkGamesWhenGamesInvalid() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(200, 1, 168);
    TestDataFactory.changeGameType(games, null);

    //when
    Test.startTest();
    Database.SaveResult[] updateResult = Database.update(games, false);
    Test.stopTest();

    //then
    for (Database.SaveResult upRes : updateResult) {
      System.assert(!upRes.isSuccess());
      System.assert(upRes.getErrors().size() > 0);
    }
  }
}
