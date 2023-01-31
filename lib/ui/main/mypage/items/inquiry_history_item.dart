class InquiryHistoryItem {
  final String title;
  final String content;
  final List<String>? imgUrls;
  final String? answer;
  final String dateCreated;

  InquiryHistoryItem({
    required this.title,
    required this.content,
    required this.dateCreated,
    this.imgUrls,
    this.answer,
  });
}
