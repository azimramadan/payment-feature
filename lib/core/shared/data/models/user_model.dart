class UserModel {
  final String name;
  final String email;
  final String phone;
  String? stripeCustomerId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.stripeCustomerId,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}

UserModel userModel = UserModel(
  stripeCustomerId: 'cus_SYfBzyycl6Aa1t',
  phone: '01206263723',
  name: 'Abdelazim Ramadan',
  email: 'eng.abdelazim3@gmail.com',
);
