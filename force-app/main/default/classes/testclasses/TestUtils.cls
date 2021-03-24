@isTest
private class TestUtils {
  @isTest
  static void testGroupRecordsByField() {
    //given
    List<Player__c> mockPlayers = TestDataFactory.createPlayersWithUniqeNamesAndHalfUniqueEmails(
      10
    );

    //when
    Test.startTest();

    Map<String, List<sObject>> resultByEmail = Utils.groupRecordsByField(
      mockPlayers,
      'Email__c'
    );

    Map<String, List<sObject>> resultByName = Utils.groupRecordsByField(
      mockPlayers,
      'Name__c'
    );

    Test.stopTest();

    //then
    System.assertEquals(5, resultByEmail.keySet().size());
    System.assertEquals(10, resultByName.keySet().size());
  }
  @isTest
  static void testFilterRecords() {
    //given
    List<Player__c> mockPlayersNotUniqueEmails = TestDataFactory.createPlayersWithUniqeNamesAndHalfUniqueEmails(
      10
    );
    List<Player__c> mockPlayersUniqueEmails = TestDataFactory.createPlayersWithUniqeNamesAndUniqueEmails(
      5
    );

    //when
    Test.startTest();

    List<sObject> filterByNotUniqeEmails = Utils.filterRecords(
      mockPlayersNotUniqueEmails,
      'Email__c',
      new Set<String>{ 'test1@email.com', 'test5@email.com' }
    );

    List<sObject> filterByUniqeEmails = Utils.filterRecords(
      mockPlayersUniqueEmails,
      'Email__c',
      new Set<String>{ 'test2@email.com', 'test3@email.com' }
    );

    Test.stopTest();

    //then
    System.assertEquals(4, filterByNotUniqeEmails.size());
    System.assertEquals(2, filterByUniqeEmails.size());
  }
}
