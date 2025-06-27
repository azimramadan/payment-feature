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
  stripeCustomerId: 'ephkey_1RejN3IpK535XZH4D3W47jSi',
  phone: '01206263723',
  name: 'Abdelazim Ramadan',
  email: 'eng.abdelazim3@gmail.com',
);
