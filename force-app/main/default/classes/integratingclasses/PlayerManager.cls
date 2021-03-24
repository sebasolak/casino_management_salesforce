@RestResource(urlMapping='/topPlayers/*')
global with sharing class PlayerManager {
  @HttpGet
  global static List<Player__c> getTopPlayers() {
    RestRequest request = RestContext.request;

    String numOfPlayers = request.requestURI.substring(
      request.requestURI.lastIndexOf('/') + 1
    );
    Integer lmit = Integer.valueOf(numOfPlayers);

    return [
      SELECT Name, Name__c, Risk_Level__c, Total_Money_Won_2__c
      FROM Player__c
      ORDER BY Total_Money_Won_2__c DESC
      LIMIT :lmit
    ];
  }
}
