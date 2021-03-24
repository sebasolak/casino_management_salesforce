trigger BetTrigger on Bet__c(after insert, after update) {
  if (Trigger.isAfter) {
    AppTriggersService.calculateTotalMoneyWonByPlayer(Trigger.New);
    AppTriggersService.calculateTotalIncomeByCasino(Trigger.New);
  }
}
