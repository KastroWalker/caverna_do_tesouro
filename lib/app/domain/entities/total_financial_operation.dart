class TotalFinancialOperations {
  final double totalEntry;
  final double totalExpense;
  late final double totalBalance;

  TotalFinancialOperations({
    required this.totalEntry,
    required this.totalExpense,
  }) {
    totalBalance = totalEntry - totalExpense;
  }
}