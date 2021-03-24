@isTest
private class TemperatureConverterTest {
  @isTest
  static void testWarmTemp() {
    Decimal celcius = TemperatureConverter.fahrenheitToCelsius(70);
    system.assertEquals(21.11, celcius);
  }

  @isTest
  static void testFreezingPoint() {
    Decimal celcius = TemperatureConverter.fahrenheitToCelsius(32);
    system.assertEquals(0, celcius);
  }

  @isTest
  static void testBoilingPoint() {
    Decimal celcius = TemperatureConverter.fahrenheitToCelsius(212);

    System.assertEquals(
      0,
      celcius,
      'Boiling point temperature is not expected.'
    );
  }

  @isTest
  static void testNegativeTemp() {
    Decimal celsius = TemperatureConverter.fahrenheitToCelsius(-10);
    System.assertEquals(-23.33, celsius);
  }
}
