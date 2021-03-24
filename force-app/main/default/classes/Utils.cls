public inherited sharing class Utils {
  public static Map<String, List<sObject>> groupRecordsByField(
    List<sObject> recordsToBeGrouped,
    String groupByField
  ) {
    Map<String, List<sObject>> resultMap = new Map<String, List<sObject>>();

    for (sObject obj : recordsToBeGrouped) {
      String key = String.valueOf(obj.get(groupByField));
      if (resultMap.containsKey(key)) {
        resultMap.get(key).add(obj);
      } else {
        resultMap.put(
          String.valueOf(obj.get(groupByField)),
          new List<SObject>{ obj }
        );
      }
    }
    return resultMap;
  }
  // List<Contact> contactList = [SELECT name, email FROM Contact];
  // Map<String,List<sObject>> m = Utils.groupRecordsByField(contactList,'email');
  // for (String key : m.keySet()) {
  //       System.debug(key + ' : ' + m.get(key));
  //     }

  public static List<sObject> filterRecords(
    List<sObject> dataList,
    String fieldApiName,
    Set<String> validValues
  ) {
    List<sObject> resultList = new List<SObject>();

    for (sObject obj : dataList) {
      String value = String.valueOf(obj.get(fieldApiName));
      if (validValues.contains(value)) {
        resultList.add(obj);
      }
    }
    return resultList;
  }

  //   List<Contact> contactList = [SELECT name, email FROM Contact];
  // Set<String>validValues=new Set<String>{'abc@xyz.com','agreen@uog.com','efrank@genepoint.com'};
  // List<SObject>lst=Utils.filterRecords(contactList,'email',validValues);
  // for (sObject obj : lst) {
  //       System.debug(obj);
  //   }
}
