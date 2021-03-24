@isTest
private class TrainingClassTest {
  static testMethod void itShouldReturnWaterLevel() {
    //given
    String result1 = TrainingClass.waterLevel('empty');
    String result2 = TrainingClass.waterLevel('half');
    String result3 = TrainingClass.waterLevel('anything');
    //then
    System.assertEquals('Was empty is full', result1);
    System.assertEquals('Was half is full', result2);
    System.assertEquals('The tea kettle is full', result3);
  }

  @isTest
  static void testMultiplyNegative() {
    Boolean wasExceptionThrown = false;
    Integer result = 0;
    try {
      result = Calculator.multiply(0, 0);
    } catch (Calculator.CalculatorException e) {
      if (
        e.getMessage.equalsIgnoreCase(
          'It doesn\'t make sense to multiply by zero'
        )
      ) {
        wasExceptionThrown = true;
      }
    }
    System.assert(wasExceptionThrown);
  }

  @isTest
  static void testDivideByNegativeValueNegative() {
    Decimal result = 0;
    Boolean divideByNegativeValue = false;

    try {
      result = Calculator.divide(-10, 5);
    } catch (Calculator.CalculatorException e) {
      if (
        e.getMessage()
          .equalsIgnoreCase('Division returned a negative value.' + result)
      ) {
        divideByNegativeValue = true;
      }
    }
    System.assert(divideByNegativeValue);
  }
}
