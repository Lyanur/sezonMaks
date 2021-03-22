class CheckData {
  CheckData({
    this.date = '',
    this.sum = '',
    this.bonus = '',
  });

  String date;
  String sum;
  String bonus;

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'sum': sum,
      'bonus': bonus,
    };
  }
 }