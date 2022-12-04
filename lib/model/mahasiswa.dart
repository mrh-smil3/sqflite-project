class Mahasiswa {
  int? id;
  String? nama;
  String? nim;
  String? email;
  String? prodi;

  Mahasiswa({this.id, this.nama, this.nim, this.email, this.prodi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['nim'] = nim;
    map['email'] = email;
    map['prodi'] = prodi;

    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.id = map['nama'];
    this.id = map['nim'];
    this.id = map['email'];
    this.id = map['prodi'];
  }
}
