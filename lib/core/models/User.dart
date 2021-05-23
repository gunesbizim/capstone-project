class User {
  final String fullName;
  final String email;
  final String id;

  get getFullName => this.fullName;

  get getEmail => this.email;

  get getId => this.id;

  User(this.fullName, this.email, this.id);
}
