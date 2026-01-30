enum Role {admin, member}

class GroupMember {
  final String username;
  final String email;
  final Role role;
  final DateTime joinedAt;

  GroupMember({
    required this.username,
    required this.email,
    required this.role,
    required this.joinedAt
  });

  static fromJSON(Map<String, dynamic> data) {
    Role role = Role.member;

    if(data['role'] == 'admin') role == Role.admin;

    return GroupMember(
      username: data['username'],
      email: data['email'],
      role: role,
      joinedAt: data['joined_at']
    );
  }
}