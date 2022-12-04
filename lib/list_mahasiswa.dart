import 'package:flutter/material.dart';
import 'form_mahasiswa.dart';
import 'database/db_helper.dart';
import 'model/mahasiswa.dart';

class ListMahasiswaPage extends StatefulWidget {
  const ListMahasiswaPage({Key? key}) : super(key: key);

  @override
  _ListMahasiswaPageState createState() => _ListMahasiswaPageState();
}

class _ListMahasiswaPageState extends State<ListMahasiswaPage> {
  List<Mahasiswa> listMhs = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    // menjalankan fungsi get all mahasiswa pertama kali dimuat
    _getAllMhs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Daftar Mahasiswa")),
      ),
      body: ListView.builder(
          itemCount: listMhs.length,
          itemBuilder: (context, index) {
            Mahasiswa mhs = listMhs[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${mhs.nim}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nama : ${mhs.nama}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${mhs.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Prodi: ${mhs.prodi}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      //button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(mhs);
                          },
                          icon: Icon(Icons.edit)),

                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: Text('Information'),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Yakin ingin Menghapus Data ${mhs.nama}")
                                ],
                              ),
                            ),
                            // terdapat 2 button.
                            // jika ya maka jalankan _deleteMhs() dan tutup dialog
                            // jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteMhs(mhs, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ya')),
                              TextButton(
                                child: Text("Tidak"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      // membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

// mengambil semua data mahasiswa
  Future<void> _getAllMhs() async {
    // menampung data dari database
    var list = await db.getAllMhs();

    // ada perubahan state
    setState(() {
      // menghapus data pada listMhs
      listMhs.clear();

      // lakukan perulangan pada variable list
      list!.forEach((mhs) {
        //masukkan data ke listMhs
        listMhs.add(Mahasiswa.fromMap(mhs));
      });
    });
  }

// menghapus data mahasiswa
  Future<void> _deleteMhs(Mahasiswa mhs, int position) async {
    await db.deleteMhs(mhs.id!);
    setState(() {
      listMhs.removeAt(position);
    });
  }

// membuka halaman tambah mahasiswa
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMahasiswa()));
    if (result == 'save') {
      await _getAllMhs();
    }
  }

// membuka halaman edit mahasiswa
  Future<void> _openFormEdit(Mahasiswa mhs) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormMahasiswa(mhs: mhs)));
    if (result == 'save') {
      await _getAllMhs();
    }
  }
}
