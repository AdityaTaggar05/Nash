enum Role { admin, member }

class GroupMember {
  final String userID;
  final String username;
  final String email;
  final Role role;
  final DateTime joinedAt;

  GroupMember({
    required this.userID,
    required this.username,
    required this.email,
    required this.role,
    required this.joinedAt,
  });

  static fromJSON(Map<String, dynamic> data) {
    Role role = Role.member;

    if (data['role'] == 'admin') role = Role.admin;

    return GroupMember(
      userID: data['user_id'],
      username: data['username'],
      email: data['email'],
      role: role,
      joinedAt: DateTime.parse(data['joined_at']),
    );
  }
}
