class User {
  int userID = 0;
  String userRole = '';
  String name = '';
  String surname = '';
  String phone = '';
  String email = '';
  String birthday = '';

  User(int userID, String userRole, String name, String surname, String phone,
      String email, String birthday) {
    this.userID = userID;
    this.userRole = userRole;
    this.name = name;
    this.surname = surname;
    this.phone = phone;
    this.email = email;
    this.birthday = birthday;
  }
}
