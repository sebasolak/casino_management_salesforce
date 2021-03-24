public class TemperatureConverter {
  public static Decimal fahrenheitToCelsius(Decimal fh) {
    Decimal cs = (fh - 32) * 5 / 9;
    return cs.setScale(2);
  }

  public static List<Contact> generateRandomContacts(
    Integer numContacts,
    String lastName
  ) {
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < numContacts; i++) {
      Contact con = new Contact(LastName = lastName + i);
      contacts.add(con);
    }
    return contacts;
  }
}
