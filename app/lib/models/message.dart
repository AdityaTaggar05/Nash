class Message {
  String id;
  String username;
  String senderID;
  String content;
  DateTime createdAt;

  Message({
    required this.id,
    required this.username,
    required this.senderID,
    required this.content,
    required this.createdAt,
  });

  static Message fromJSON(Map<String, dynamic> data) {
    print("LOG: $data");

    return Message(
      id: data['id'],
      username: data['username'],
      senderID: data['sender_id'],
      content: data['content'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
