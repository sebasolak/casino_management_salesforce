@isTest
private class TestTotalizatorDAO {
  @isTest
  static void testGetPlayers() {
    //given
    List<Player__c> players = TestDataFactory.createPlayersWithUniqeNamesAndUniqueEmails(
      10
    );

    //when
    Test.startTest();

    List<Player__c> result = TotalizatorDAO.getPlayers(3, 5);
    List<Player__c> result2 = TotalizatorDAO.getPlayers(3, 11);
    List<Player__c> result3 = TotalizatorDAO.getPlayers(2, 0);

    Test.stopTest();

    //then
    System.assertEquals(3, result.size());
    System.assertEquals(0, result2.size());
    System.assertEquals(2, result3.size());
  }

  @isTest
  static void testGetGamesCount() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(15, 3, 100);

    //when
    Test.startTest();

    List<AggregateResult> result = TotalizatorDAO.getGamesCount();

    Test.stopTest();

    //then
    System.assertEquals(1, result.size());
    System.assertEquals(15, result[0].get('expr0'));
  }
  @isTest(SeeAllData=true)
  static void testGetTotalMoneyWon() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      5,
      3,
      200
    );

    Set<Id> playersIds = new Set<Id>();

    for (Bet__c bet : bets) {
      playersIds.add(bet.Player__c);
    }

    //when
    Test.startTest();

    Map<Id, Decimal> resultMap = TotalizatorDAO.getTotalMoneyWon(playersIds);

    Test.stopTest();

    //then
    System.assertEquals(5, resultMap.keySet().size(), 'Map size is incorrect');
    //2.5 * 200 * 3 = 1500
    for (Id key : resultMap.keySet()) {
      System.assertEquals(1500, resultMap.get(key), 'Map value is incorrect');
    }
  }
  @isTest
  static void testGetTopPlayers() {
    //given
    List<Player__c> players = TestDataFactory.creatPlayersWithAscedingTotalMoneyWon(
      10,
      1000
    );

    //when
    Test.startTest();
    Integer limit1 = 3, offset1 = 6;
    List<Player__c> result1 = TotalizatorDAO.getTopPlayers(limit1, offset1);
    Integer limit2 = 8, offset2 = 11;
    List<Player__c> result2 = TotalizatorDAO.getTopPlayers(8, 11);

    Test.stopTest();

    //then
    System.assertEquals(3, result1.size());
    List<Player__c> result1Check = [
      SELECT
        Name__c,
        Risk_Level__c,
        Total_Money_Won__c,
        Total_Bets_Amount__c,
        Email__c,
        Is_Black_List__c
      FROM Player__c
      ORDER BY Total_Money_Won__c DESC
      LIMIT :limit1
      OFFSET :offset1
    ];
    System.assertEquals(result1Check, result1);

    System.assertEquals(0, result2.size());
  }

  @isTest
  static void testGetMostPopularGames() {
    //given
    List<Game__c> games = TestDataFactory.createGameWithBets(5, 3, 350);

    //when
    Test.startTest();
    Map<Id, Integer> resultMap = TotalizatorDAO.getMostPopularGames();
    Test.stopTest();

    //then
    System.assertEquals(5, resultMap.keySet().size());
    for (Id key : resultMap.keySet()) {
      System.assertEquals(3, resultMap.get(key));
    }
  }

  @isTest
  static void testCreatePlayerPositive() {
    //when
    Test.startTest();
    TotalizatorDAO.createPlayer('Matteo De Luca', 'mateo@xyz.com');
    Test.stopTest();

    //then
    List<Player__c> players = [SELECT Name__c, Email__c FROM Player__c];
    System.assertEquals(1, players.size());
    System.assertEquals(players[0].get('Name__c'), 'Matteo De Luca');
    System.assertEquals(players[0].get('Email__c'), 'mateo@xyz.com');
  }
  @isTest
  static void testCreatePlayerNegative() {
    //when
    Test.startTest();
    TotalizatorDAO.createPlayer(null, 'mateo@xyz.com');
    Test.stopTest();

    //then
    List<Player__c> players = [SELECT Name__c, Email__c FROM Player__c];
    System.assertEquals(0, players.size());
  }

  @isTest
  static void testUpdateBetPositive() {
    //given
    Bet__c bet = TestDataFactory.createSingleBet(150, 180);

    //when
    Test.startTest();
    TotalizatorDAO.updateBet(bet.Id, 438, 120);
    Test.stopTest();

    //then
    List<Bet__c> bets = [SELECT Id, Amount__c FROM Bet__c];
    System.assertEquals(1, bets.size());
    System.assertEquals(bets[0].id, bet.id);
  }
  @isTest
  static void testUpdateBetNegative() {
    //given
    Bet__c bet = TestDataFactory.createSingleBet(150, 180);

    //when
    Test.startTest();
    TotalizatorDAO.updateBet(bet.Id, null, 120);
    Test.stopTest();

    //then
    List<Bet__c> bets2 = [
      SELECT Id, Win_Rate__c
      FROM Bet__c
      WHERE Id = :bet.Id
    ];
    System.assertNotEquals(120, bets2[0].get('Win_Rate__c'));
  }

  @IsTest
  static void testDeleteBetsPositive() {
    //given
    List<Bet__c> bets = TestDataFactory.createBetsWithGamesAndPlayers(
      8,
      3,
      168
    );
    //8 * 3 = 24 bets
    List<Id> betsIds = new List<Id>();
    for (Bet__c bet : bets) {
      betsIds.add(bet.Id);
    }

    //when
    Test.startTest();
    TotalizatorDAO.deleteBets(betsIds);
    Test.stopTest();

    //then
    List<Bet__c> checkBets = [SELECT Id, Amount__c FROM Bet__c];
    System.assertEquals(0, checkBets.size());
  }

  @isTest
  static void testCreateBet() {
    //given
    Game__c game = TestDataFactory.createSingleGame('Cars');
    Player__c player = TestDataFactory.createSinglePlayer();

    //when
    Test.startTest();
    TotalizatorDAO.createBet(game.Id, player.Id, 1240, 150);
    Test.stopTest();

    //then
    List<Bet__c> bets = [
      SELECT Game__c, Player__c, Amount__c, Win_Rate__c
      FROM Bet__c
    ];

    System.assertEquals(1, bets.size());
    System.assertEquals(game.Id, bets[0].get('Game__c'));
    System.assertEquals(player.Id, bets[0].get('Player__c'));
    System.assertEquals(1240, bets[0].get('Amount__c'));
    System.assertEquals(150, bets[0].get('Win_Rate__c'));
  }

  @isTest
  static void testCreateBetNegative() {
    //when
    Test.startTest();
    TotalizatorDAO.createBet(null, null, 1240, 150);
    Test.stopTest();

    //then
    List<Bet__c> bets = [
      SELECT Game__c, Player__c, Amount__c, Win_Rate__c
      FROM Bet__c
    ];
    System.assertEquals(0, bets.size());
  }
}
