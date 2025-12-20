class PaymentHistoryModel {
  String date;
  String bookName;
  String kindOfBook;
  String price;
  String bankOfOrigin;
  String status;
  String purchaseID;
  int discount;

  PaymentHistoryModel({
    required this.date,
    required this.bookName,
    required this.kindOfBook,
    required this.price,
    required this.bankOfOrigin,
    required this.status,
    required this.purchaseID,
    required this.discount,
  });
}

List<PaymentHistoryModel> fakePaymentHistoryList = [
  PaymentHistoryModel(
      date: '1403/08/21',
      bookName: 'دنیای سوفی',
      kindOfBook: 'کتاب صوتی',
      price: '12000',
      bankOfOrigin: 'بانک ملت',
      status: 'موفق',
      purchaseID: '256893',
      discount: 70),
  PaymentHistoryModel(
      date: '1403/08/19',
      bookName: 'خرده عادت ها',
      kindOfBook: 'کتاب متنی',
      price: '18000',
      bankOfOrigin: 'بانک ملت',
      status: 'موفق',
      purchaseID: '256982',
      discount: 15),
];
