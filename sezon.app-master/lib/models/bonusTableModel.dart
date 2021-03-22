class BonusTableModel {
  BonusTableModel({
    this.name = '',
    this.percent = '',
    this.sum = '',
  });

  String name;
  String percent;
  String sum;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'percent': percent,
      'sum': sum,
    };
  }
  String toString() {
    return
      'name '+ name+ ' percent '+ percent+ ' sum '+ sum;
  }
}