@isTest
public class TestDataFactory {
  public static List<Player__c> createPlayersWithUniqeNamesAndHalfUniqueEmails(
    Integer numberOfPlayers
  ) {
    List<Player__c> players = new List<Player__c>();
    Integer x = 0;
    for (Integer i = 0; i < numberOfPlayers; i++) {
      if (math.mod(i, 2) == 0) {
        x++;
      }
      Player__c player = new Player__c(
        Name__c = 'testName ' + i,
        Email__c = 'test' + x + '@email.com'
      );
      players.add(player);
    }
    insert players;
    return players;
  }

  public static List<Player__c> createPlayersWithUniqeNamesAndUniqueEmails(
    Integer numberOfPlayers
  ) {
    List<Player__c> players = new List<Player__c>();

    for (Integer i = 0; i < numberOfPlayers; i++) {
      Player__c player = new Player__c(
        Name__c = 'testName ' + i,
        Email__c = 'test' + i + '@email.com'
      );
      players.add(player);
    }
    insert players;
    return players;
  }

  public static List<Game__c> createGameWithBets(
    Integer numGames,
    Integer numBetsPerGame,
    Integer moneyPerBet
  ) {
    // if (math.mod(i, 2) == 0)
    List<Game__c> games = new List<Game__c>();
    List<Player__c> players = new List<Player__c>();
    for (Integer i = 0; i < numGames; i++) {
      //new game
      Integer moduler = math.mod(i, 3);
      String gameType = moduler == 0
        ? 'Horses'
        : moduler == 1 ? 'Bullfights' : 'Cars';
      DateTime dt = DateTime.Now().addMonths(3);
      Game__c game = new Game__c(Type__c = gameType, Start_Date__c = dt);
      games.add(game);
      //new player
      Player__c player = new Player__c(
        Name__c = 'testName ' + i,
        Email__c = 'testMail' + i + '@xyz.com'
      );
      players.add(player);
    }
    insert games;
    insert players;

    List<Bet__c> bets = new List<Bet__c>();
    for (Integer i = 0; i < numGames; i++) {
      Game__c game = games[i];
      Player__c player = players[i];
      for (Integer j = 0; j < numBetsPerGame; j++) {
        Bet__c bet = new Bet__c(
          Amount__c = moneyPerBet,
          Game__c = game.Id,
          Win_Rate__c = 250,
          Player__c = player.Id
        );
        bets.add(bet);
      }
    }
    insert bets;
    return games;
  }

  public static List<Bet__c> createBetsWithGamesAndPlayers(
    Integer numPlayers,
    Integer numBetsPerPlayer,
    Integer moneyPerBet
  ) {
    // if (math.mod(i, 2) == 0)
    List<Game__c> games = new List<Game__c>();
    List<Player__c> players = new List<Player__c>();
    for (Integer i = 0; i < numPlayers; i++) {
      //new game
      Integer moduler = math.mod(i, 3);
      String gameType = moduler == 0
        ? 'Horses'
        : moduler == 1 ? 'Bullfights' : 'Cars';
      DateTime dt = DateTime.Now().addMonths(3);
      Game__c game = new Game__c(Type__c = gameType, Start_Date__c = dt);
      games.add(game);
      //new player
      Player__c player = new Player__c(
        Name__c = 'testName ' + i,
        Email__c = 'testMail' + i + '@xyz.com'
      );
      players.add(player);
    }
    insert players;
    insert games;

    List<Bet__c> bets = new List<Bet__c>();
    for (Integer i = 0; i < numPlayers; i++) {
      Game__c game = games[i];
      Player__c player = players[i];
      for (Integer j = 0; j < numBetsPerPlayer; j++) {
        if (game.Id != null && player.Id != null) {
          Bet__c bet = new Bet__c(
            Game__c = game.Id,
            Amount__c = moneyPerBet,
            Player__c = player.Id,
            Status__c = 'Won',
            Win_Rate__c = 250
          );
          bets.add(bet);
        }
      }
    }

    insert bets;
    return bets;
  }

  public static List<Player__c> creatPlayersWithAscedingTotalMoneyWon(
    Integer numPlayers,
    Integer startAmount
  ) {
    List<Player__c> players = new List<Player__c>();
    for (Integer i = 0; i < numPlayers; i++) {
      Player__c player = new Player__c(
        Name__c = 'testName ' + i,
        Email__c = 'testMail' + i + '@xyz.com',
        Total_Money_Won_2__c = startAmount + (10 * i)
      );
      players.add(player);
    }
    insert players;
    return players;
  }

  public static Bet__c createSingleBet(Decimal amount, Decimal percent) {
    Game__c game = new Game__c(
      Type__c = 'Cars',
      Start_Date__c = DateTime.Now().addMonths(3)
    );
    insert game;

    Player__c player = new Player__c(
      Name__c = 'testName',
      Email__c = 'testMail@xyz.com'
    );
    insert player;

    Bet__c bet = new Bet__c(
      Game__c = game.Id,
      Player__c = player.Id,
      Win_Rate__c = percent,
      Amount__c = amount
    );

    insert bet;
    return bet;
  }

  public static Game__c createSingleGame(String type) {
    Game__c game = new Game__c(
      Type__c = type,
      Start_Date__c = DateTime.Now().addMonths(3)
    );
    insert game;
    return game;
  }
  public static Player__c createSinglePlayer() {
    Player__c player = new Player__c(
      Name__c = 'testName',
      Email__c = 'testMail@xyz.com'
    );
    insert player;
    return player;
  }

  public static void changeBetStatus(List<Bet__c> bets, String status) {
    for (Bet__c bet : bets) {
      bet.Status__c = status;
    }    
  }
  public static void changeBetAmount(List<Bet__c> bets, Decimal amount) {
    for (Bet__c bet : bets) {
      bet.Amount__c = amount;
    }    
  }
  public static void changeBetWinRate(List<Bet__c> bets, Decimal winRate) {
    for (Bet__c bet : bets) {
      bet.Win_Rate__c = winRate;
    }
  }
  public static void changeGameType(List<Game__c> games, String type) {
    for (Game__c game : games) {
      game.Type__c = type;
    }
  }
  public static List<Game__c> createGameWithGivenDate(
    Integer numGame,
    DateTime gameDate,
    Decimal totalIncome
  ) {
    List<Game__c> games = new List<Game__c>();
    for (Integer i = 0; i < numGame; i++) {
      Integer moduler = math.mod(i, 3);
      String gameType = moduler == 0
        ? 'Horses'
        : moduler == 1 ? 'Bullfights' : 'Cars';
      Game__c game = new Game__c(
        Type__c = gameType,
        Start_Date__c = gameDate,
        Total_Income__c = totalIncome
      );
      games.add(game);
    }
    insert games;
    return games;
  }
}
