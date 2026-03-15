class User {
  final String? id;
  final String? email;
  final String? username;
  final String? baseCurrency;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.baseCurrency // LKR or USD

      });


  // ===========================================================================
  //  this handle DTOs work too , you can seprate this too when application become complex and larger(data layer / model
  //  ), for now we use both inside this
  // ===========================================================================

  /*
  write to database
  this converts dart objects into map that sqlite can save
  */
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "username": username,
      "base_currency": baseCurrency
    };
  }

  /*
    Read from database
  */

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        email: map['email'] as String,
        username: map['username'] as String,
        baseCurrency: map['base_currency'] as String);
  }

  User copyWith(
      {String? id, String? email, String? username, String? baseCurrency}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        baseCurrency: baseCurrency ?? this.baseCurrency);
  }
}
