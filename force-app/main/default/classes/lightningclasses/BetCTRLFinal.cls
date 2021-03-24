public with sharing class BetCTRLFinal {
   @AuraEnabled(cacheable=true)
    public static List<Bet__c> getBetsList(Id playerId){        
        return  [SELECT Id, Name, Amount__c, Status__c, Win_Rate__c
                FROM Bet__c
                WHERE Player__c = :playerId
                AND Status__c = 'Won'];
    }
}


