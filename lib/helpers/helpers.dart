class Helper {
  double bmiCalculator(double height, double weight) {
    /*  ----- Units -----
     * > weight: kg
     * > height: m
     * > bmi: kg/m²
     * ------------------*/
    double heightInMeters, bmi;
    heightInMeters = height / 100;
    bmi = weight / (heightInMeters * heightInMeters);
    return bmi;
  }

  int ageCalculator(String birthdate) {
    List<String> parts = birthdate.split('/');
    DateTime now = DateTime.now();
    int currentYear = now.year;
    String yearOfBirth = parts[2];
    int age = currentYear - int.parse(yearOfBirth);
    return age;
  }
}
