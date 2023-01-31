class ConsultRoomItem {
  String profileUrl;
  String nickname;
  String lastMessage;
  String dateLastSent;
  bool hasNewMessage;

  ConsultRoomItem({
    required this.profileUrl,
    required this.nickname,
    required this.lastMessage,
    required this.dateLastSent,
    required this.hasNewMessage,
  });
}
