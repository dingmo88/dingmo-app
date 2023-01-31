abstract class ConsultingMessage {
  final String message;
  ConsultingMessage({required this.message});
}

class UserMessage extends ConsultingMessage {
  UserMessage({required super.message});
}

class CompMessage extends ConsultingMessage {
  CompMessage({required super.message});
}

class CompVerifyMessage extends ConsultingMessage {
  String? phoneNumber;

  CompVerifyMessage({required super.message});
}

class CompAskDateMessage extends ConsultingMessage {
  String? dateUserSelected;

  CompAskDateMessage({required super.message});
}
