public with sharing class GameTableCTRL {
  @AuraEnabled
  public static List<Game__c> getGameList() {
    List<Game__c> gameList = [
      SELECT
        Id,
        Name,
        Type__c,
        Game_Rating__c,
        Start_Date__c,
        Total_Money_Bet__c,
        Total_Income__c
      FROM Game__c
      WHERE Start_Date__c = THIS_WEEK
    ];
    return gameList;
  }
}
