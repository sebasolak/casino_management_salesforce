public inherited sharing class TrainingClass {
  public TrainingClass() {
    insertNewAccount();
    insertNewPlayer();
  }

  public static void insertNewAccount() {
    Account acct = new Account(
      Name = 'Acme',
      Phone = '(415)555-1212',
      NumberOfEmployees = 100
    );
    insert acct;
  }

  public static void insertNewPlayer() {
    SObject player = new Player__c(
      Name__c = 'Fredo Pepperoni',
      Email__c = 'tomase802@gmail.com'
    );
    insert player;
  }

  public static String waterLevel(String waterLevel) {
    String res;
    switch on waterLevel {
      when 'empty' {
        res = 'Was empty is full';
      }
      when 'half' {
        res = 'Was half is full';
      }
      when else {
        res = 'The tea kettle is full';
      }
    }
    return res;
  }

  public static void serveTea(
    Integer totalQuest,
    Integer totalAmountSugar,
    Integer totalAmountTea
  ) {
    while (totalQuest > 0) {
      System.debug('Guests Remaining ' + totalQuest);
      totalAmountSugar--;
      totalAmountTea--;
      if (totalAmountSugar <= 0 || totalAmountTea <= 0) {
        System.debug('Out of ingredients!');
        break;
      }
      totalQuest--;
    }
  }
  // public static void viewAnnualRevenue() {
  //   List<Account> accountList = [
  //     SELECT name, (SELECT name FROM Contact)
  //     FROM Account
  //   ];
  //   List<Contact> contactList = [SELECT name, email FROM Contact];

  //   for (Account acc : accountList) {
  //     String acctRev = acc.Name + ' : ' + acc.AnnualRevenue;
  //     System.debug(acctRev);
  //   }
  // }

  public static void bindSOQLVar(Integer value) {
    List<Bet__c> betsList = [
      SELECT name, amount__c, player__r.name__c
      FROM bet__c
      WHERE amount__c > :value
    ];

    for (Bet__c bet : betsList) {
      System.debug(bet);
    }
  }

  public static Account insertNewAccount(String accountName) {
    try {
      Account acct = new Account(Name = accountName);
      insert acct;
      return acct;
    } catch (DmlException e) {
      return null;
    }
  }
  public static String getAnimalNameById(Integer animalId) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'https://th-apex-http-callout.herokuapp.com/animals/' + animalId
    );
    request.setMethod('GET');
    HttpResponse response = http.send(request);

    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      response.getBody()
    );
    Map<String, Object> animals = (Map<String, Object>) results.get('animals');

    return (string) animals.get('name');
  }

  public static void tempMethod() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://avenga-school.herokuapp.com/retrieve-data');
    request.setMethod('GET');
    request.setHeader('projectName', 'Totalizator');
    HttpResponse response = new Http().send(request);
    System.debug(response.getStatus());
    System.debug(response.getBody());
  }

  static Id createTestRecord() {
    Case caseTest = new Case(
      Subject = 'Test record',
      Status = 'New',
      Origin = 'Phone',
      Priority = 'Medium'
    );
    insert caseTest;
    return caseTest.Id;
  }

  @isTest
  static void testDeleteCase() {
    Id recordId = createTestRecord();
    RestRequest request = new RestRequest();
    request.requestURI =
      'https://playful-impala-mxokkr-dev-ed.my.salesforce.com/' + recordId;
    request.httpMethod = 'GET';
    RestContext.request = request;
    CaseManager.deleteCase();
    List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
    system.assert(cases.size() == 0);
  }
}
