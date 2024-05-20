class User {
  int userId;
  String userName;
  String userEmail;
  String esAdmin;
  String estaAutorizado;
  String passProvisional;

  User(this.userId, this.userName, this.userEmail, this.esAdmin,
      this.estaAutorizado, this.passProvisional);

  factory User.fromJson(Map<String, dynamic> json) => User(
        0,
        json["Nombre_Usuario"],
        json["Email_Usuario"],
        json["Es_Admin_Usuario"].toString(),
        json["EstaAutorizado_Usuario"].toString(),
        json["Pass_Provisional"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'ID_Usuario_Pk':
            userId.toString(), // Guarda el ID como String en SharedPreferences
        'Nombre_Usuario': userName,
        'Email_Usuario': userEmail,

        'Es_Admin_Usuario': esAdmin,
        'EstaAutorizado_Usuario': estaAutorizado,
        "Pass_Provisional": passProvisional,
      };
}
