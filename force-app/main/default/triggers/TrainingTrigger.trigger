trigger TrainingTrigger on Account(after insert, after update) {
  List<Opportunity> oppList = [
    SELECT Id, Name
    FROM Opportunity
    WHERE StageName LIKE 'Closed Won'
  ];

  List<Task> taskList = new List<Task>();

  for (Opportunity opp : oppList) {
    Task tsk = new Task(
      Subject = 'Follow Up Test Task',
      opportunityId = opp.Id
    );
    taskList.add(tsk);
  }
  if (taskList > 0) {
    insert taskList;
  }
}
