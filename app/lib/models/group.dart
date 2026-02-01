import '/models/member.dart';

class Group {
  final String groupId;
  final String name;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final List<GroupMember> memberList;

  Group({
    required this.groupId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.memberList,
  });
}
