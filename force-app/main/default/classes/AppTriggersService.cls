public inherited sharing class AppTriggersService {
  public static void calculateTotalMoneyWonByPlayer(List<Bet__c> newList) {
    Id playerId = newList[0].Player__c;

    AggregateResult[] playerBets = [
      SELECT sum(Amount__c) betsSum
      FROM Bet__c
      WHERE Player__c = :playerId
    ];

    Decimal sumAll = (Decimal) playerBets[0].get('betsSum');

    Player__c playerToUpdate = [
      SELECT Total_Money_Won_2__c
      FROM Player__c
      WHERE Id = :playerId
    ];

    playerToUpdate.Total_Money_Won_2__c = sumAll;

    update playerToUpdate;
  }
  //////////////////////////////////////////
  public static void calculateGameRating(
    List<Game__c> newList,
    Map<Id, Game__c> oldMap
  ) {
    Boolean reculculate = false;

    for (Game__c game : newList) {
      if (game.Total_Money_Bet__c != oldMap.get(game.Id).Total_Money_Bet__c) {
        reculculate = true;
      }
    }

    if (!reculculate) {
      return;
    }

    List<Game__c> allGames = [
      SELECT Game_Rating__c, Total_Money_Bet__c
      FROM Game__c
      ORDER BY Total_Money_Bet__c DESC
    ];

    for (Integer i = 0; i < allGames.size(); i++) {
      if (i + 1 > 10) {
        allGames[i].Game_Rating__c = null;
      } else {
        allGames[i].Game_Rating__c = i + 1;
      }
    }
    update allGames;
  }
  ////////////////////////////////////////////
  public static void calculateTotalIncomeByCasino(List<Bet__c> newList) {
    Id gameId = newList[0].Game__c;
    AggregateResult[] gameBets = [
      SELECT sum(Amount__c) betsSum
      FROM Bet__c
      WHERE Game__c = :gameId AND Status__c = 'LOST'
    ];

    Decimal sumAllLostBets = (Decimal) gameBets[0].get('betsSum');

    Game__c gameToUpdate = [
      SELECT Total_Income__c
      FROM Game__c
      WHERE Id = :gameId
    ];

    gameToUpdate.Total_Income__c = sumAllLostBets;

    update gameToUpdate;
  }
}
//////////////////////////////////////////////////////

//   public static void calculateTotalIncomeByCasino(List<Bet__c> newList) {
//     Bet__c[] bets = [SELECT Game__c FROM Bet__c WHERE Id IN :newList];

//     Set<Id> gamesId = new Set<Id>();

//     for (Bet__c bet : bets) {
//       gamesId.add(bet.Game__c);
//     }

//     Bet__c[] gamesBets = [
//       SELECT Game__r.Id, Amount__c, Status__c
//       FROM Bet__c
//       WHERE Game__r.Id IN :gamesId
//     ];

//     Map<Id, Decimal> gameMap = new Map<Id, Decimal>();

//     for (Bet__c bet : gamesBets) {
//       if (bet.Status__c == 'Lost') {
//         Id key = bet.Game__r.Id;
//         Decimal value = bet.Amount__c;
//         if (!gameMap.containsKey(bet.Game__r.Id)) {
//           gameMap.put(key, value);
//         } else {
//           value += gameMap.get(key);
//           gameMap.put(key, value);
//         }
//       }
//     }

//     Game__c[] games = [
//       SELECT Total_Income__c
//       FROM Game__c
//       WHERE Id IN :gamesId
//     ];

//     List<Game__c> gamesToUpdate = new List<Game__c>();

//     for (Game__c game : games) {
//       game.Total_Income__c = gameMap.get(game.Id);
//       gamesToUpdate.add(game);
//     }

//     if (gamesToUpdate.size() > 0) {
//       update gamesToUpdate;
//     }
//   }
// }

///////////////////////////////////////////////////////////////////////////////////

/*  public static void calculateTotalMoneyWonByPlayer(List<Bet__c> newList) {
    Bet__c[] bets = [SELECT Player__c FROM Bet__c WHERE id IN :newList];

    Set<Id> playersId = new Set<Id>();

    for (Bet__c bet : bets) {
      playersId.add(bet.Player__c);
    }

    Bet__c[] playersBets = [
      SELECT Player__r.Id, Amount__c
      FROM Bet__c
      WHERE Player__r.Id IN :playersId
    ];

    Map<Id, Decimal> playerMap = new Map<Id, Decimal>();

    for (Bet__c bet : playersBets) {
      Id key = bet.Player__r.Id;
      Decimal value = bet.Amount__c;
      if (value == null) {
        value = 0;
      }
      if (!playerMap.containsKey(bet.Player__r.Id)) {
        playerMap.put(key, value);
      } else {
        value += playerMap.get(key);
        playerMap.put(key, value);
      }
    }
    Player__c[] players = [
      SELECT Total_Money_Won_2__c
      FROM Player__c
      WHERE Id IN :playersId
    ];
    List<Player__c> playersToUpdate = new List<Player__c>();
    for (Player__c player : players) {
      player.Total_Money_Won_2__c = playerMap.get(player.Id);
      playersToUpdate.add(player);
    }

    if (playersToUpdate.size() > 0) {
      update playersToUpdate;
    }
  } */
