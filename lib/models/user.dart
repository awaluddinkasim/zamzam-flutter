class User {
  String id;
  String nama;
  String email;
  String alamat;
  String noHP;

  User(this.id, this.nama, this.email, this.alamat, this.noHP);

  User.fromJson(Map json)
      : id = json['id'].toString(),
        nama = json['nama'],
        email = json['email'],
        alamat = json['alamat'],
        noHP = json['no_hp'].toString();
}
