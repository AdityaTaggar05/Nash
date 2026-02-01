class User {
  final String username;
  final String email;
  final int? balance;
  final String? refferalCode;

  User({
    required this.username,
    required this.email,
    this.balance,
    this.refferalCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json['username'],
    email: json['email'],
    balance: json['balance']?.parseInt(), 
  );
}