class Message {
  final String fullName;
  final String idUser;
  final String urlAvatar;
  final String username;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.fullName,
    required this.idUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });
}
