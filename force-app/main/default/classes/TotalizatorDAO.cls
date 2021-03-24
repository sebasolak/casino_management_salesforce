public inherited sharing class TotalizatorDAO {
  public static List<Player__c> getPlayers(Integer lmit, Integer offset) {
    return [
      SELECT Name, Name__c, Email__c, Risk_Level__c
      FROM Player__c
      WHERE Is_Black_List__c = FALSE
      LIMIT :lmit
      OFFSET :offset
    ];
  }

  // for (Player__c play : TotalizatorDAO.getPlayers(3,0)) {
  //     System.debug(play);
  // }

  public static List<AggregateResult> getGamesCount() {
    return [SELECT count(Name) FROM Game__c];
  }

  public static Map<Id, Decimal> getTotalMoneyWon(Set<Id> playersIds) {
    List<AggregateResult> aggregRes = [
      SELECT Player__c, sum(Expected_Win_Amount__c) sumAmount
      FROM Bet__c
      WHERE Player__c IN :playersIds
      GROUP BY Player__c
    ];

    Map<Id, Decimal> resultMap = new Map<Id, Decimal>();
    for (AggregateResult res : aggregRes) {
      Decimal value = (Decimal) res.get('sumAmount');
      resultMap.put((Id) res.get('Player__c'), value);
    }

    return resultMap;
  }
  // Set<Id> playersIds = new Set<Id>{
  //   'a0409000002XY5rAAG',
  //   'a0409000002XY5wAAG',
  //   'a0409000002XY6fAAG',
  //   'a0409000002Xd2kAAC',
  //   'a0409000002YVGgAAO'
  // };
  // System.debug(TotalizatorDAO.getTotalMoneyWon(playersIds));

  public static List<Player__c> getTopPlayers(Integer lmit, Integer offset) {
    return [
      SELECT
        Name__c,
        Risk_Level__c,
        Total_Money_Won__c,
        Total_Bets_Amount__c,
        Email__c,
        Is_Black_List__c
      FROM Player__c
      ORDER BY Total_Money_Won__c DESC
      LIMIT :lmit
      OFFSET :offset
    ];
  }

  // for (Player__c play : TotalizatorDAO.getTopPlayers(5,0)) {
  //     System.debug(play);
  // }

  public static Map<Id, Integer> getMostPopularGames() {
    Map<Id, Integer> resultMap = new Map<Id, Integer>();
    List<AggregateResult> aggregRes = [
      SELECT Game__c, count(Id) betCount
      FROM Bet__c
      GROUP BY Game__c
    ];

    for (AggregateResult res : aggregRes) {
      Integer value = (Integer) res.get('betCount');
      resultMap.put((Id) res.get('Game__c'), value);
    }
    return resultMap;
  }
  //   System.debug(TotalizatorDAO.getMostPopularGames());

  ////////////////////////////////////////////////////////////////////////////////////////

  public static void createPlayer(String playerName, String playerEmail) {
    Player__c play = new Player__c(
      Name__c = playerName,
      Email__c = playerEmail
    );
    Database.SaveResult insertRes = Database.insert(play, false);

    if (insertRes.isSuccess()) {
      System.debug(
        'Successfully inserted player. Player ID: ' + insertRes.getId()
      );
    } else {
      for (Database.Error err : insertRes.getErrors()) {
        System.debug('The following error has occurred.');
        System.debug(err.getStatusCode() + ': ' + err.getMessage());
        System.debug(
          'Player fields that affected this error: ' + err.getFields()
        );
      }
    }
  }
  // TotalizatorDAO.createPlayer('Tonni Mazzeo','tonni@xyz.it');

  public static void updateBet(Id betId, Decimal amount, Decimal percent) {
    if (amount == null || percent == null) {
      System.debug('Cannot update: amount or percent is null');
      return;
    }
    Bet__c betToUpdate = [
      SELECT Bet__c.Amount__c, Bet__c.Win_Rate__c
      FROM Bet__c
      WHERE id = :betId
    ];

    betToUpdate.Amount__c = amount;
    betToUpdate.Win_Rate__c = percent;

    Database.SaveResult updateRes = Database.update(betToUpdate, false);

    if (updateRes.isSuccess()) {
      System.debug('Successfully updated bet. Bet ID: ' + updateRes.getId());
    } else {
      for (Database.Error err : updateRes.getErrors()) {
        System.debug('The following error has occurred.');
        System.debug(err.getStatusCode() + ': ' + err.getMessage());
        System.debug('Bet fields that affected this error: ' + err.getFields());
      }
    }
  }
  // TotalizatorDAO.updateBet('a0609000001tLtIAAU',1818.0,230);
  public static void deleteBets(List<Id> betIds) {
    List<Bet__c> betsToDelete = [
      SELECT Bet__c.Name
      FROM Bet__c
      WHERE Id IN :betIds
    ];

    Database.DeleteResult[] deleteResList = Database.delete(
      betsToDelete,
      false
    );

    for (Database.DeleteResult deleteRes : deleteResList) {
      if (deleteRes.isSuccess()) {
        System.debug('Successfully delete bet. Bet ID: ' + deleteRes.getId());
      } else {
        for (Database.Error err : deleteRes.getErrors()) {
          System.debug('The following error has occurred.');
          System.debug(err.getStatusCode() + ': ' + err.getMessage());
          System.debug(
            'Bet fields that affected this error: ' + err.getFields()
          );
        }
      }
    }
  }
  // TotalizatorDAO.deleteBets(List<Id>{'a0609000001tBF2AAM','a0609000001tLLyAAM'});

  public static void createBet(
    Id gameId,
    Id playerId,
    Decimal amount,
    Decimal winRate
  ) {
    Bet__c newBet = new Bet__c(
      Game__c = gameId,
      Player__c = playerId,
      Amount__c = amount,
      Win_Rate__c = winRate,
      Status__c = 'Pending'
    );

    Database.SaveResult insertRes = Database.insert(newBet, false);

    if (insertRes.isSuccess()) {
      System.debug('Successfully inserted bet. Bet ID: ' + insertRes.getId());
    } else {
      for (Database.Error err : insertRes.getErrors()) {
        System.debug('The following error has occurred.');
        System.debug(err.getStatusCode() + ': ' + err.getMessage());
        System.debug('Bet fields that affected this error: ' + err.getFields());
      }
    }
  }

  // TotalizatorDAO.createBet('a03090000027VVXAA2','a0409000002YeGNAA0',2020,177);
}
