class SolveSetting {
  int acc50;
  int acc100;
  int cc50;
  int cc100;
  int maxSp;

  SolveSetting();

  Map toJson() => {
        'acc50': acc50,
        'acc100': acc100,
        'cc50': cc50,
        'cc100': cc100,
        'maxSp': maxSp,
      };
}
