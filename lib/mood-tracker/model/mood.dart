class Budget {
  static List<Budget> budgets = [];
  String judul;
  int nominal;
  String tipe;
  DateTime date;

  Budget({
    required this.judul,
    required this.nominal,
    required this.tipe,
    required this.date,
  });

  static void addBudget({
    required judul,
    required nominal,
    required tipe,
    required date,
  }) {
    budgets.add(Budget(
      judul: judul,
      nominal: nominal,
      tipe: tipe,
      date: date,
    ));
  }
}
