import '/models/member.dart';

class Group {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final List<GroupMember> memberList;

  Group({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.memberList,
  });

  factory Group.fromJSON(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      memberList: json['members'] != null
          ? List.generate(
              json['members'].length,
              (index) => GroupMember.fromJSON(json['members'][index]),
            )
          : [],
    );
  }
}
