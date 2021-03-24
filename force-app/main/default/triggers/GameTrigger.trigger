trigger GameTrigger on Game__c(after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      AppTriggersService.calculateGameRating(Trigger.new, Trigger.oldMap);
    }
  }
}
