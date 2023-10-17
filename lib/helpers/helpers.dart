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
}
