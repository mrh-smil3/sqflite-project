import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database/db_helper.dart';
import 'model/mahasiswa.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa? mhs;

  FormMahasiswa({this.mhs});

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DbHelper db = DbHelper();

  TextEditingController? nama;
  TextEditingController? namaAkhir;
  TextEditingController? nim;
  TextEditingController? email;
  TextEditingController? prodi;

  @override
  void initState() {
    nama =
        TextEditingController(text: widget.mhs == null ? '' : widget.mhs!.nama);
    nim =
        TextEditingController(text: widget.mhs == null ? '' : widget.mhs!.nim);
    email = TextEditingController(
        text: widget.mhs == null ? '' : widget.mhs!.email);
    prodi = TextEditingController(
        text: widget.mhs == null ? '' : widget.mhs!.prodi);

    super.initState();
  }

  var _formkeyMhs = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form Mahasiswa'),
        ),
        body: Form(
          key: _formkeyMhs,
          child: ListView(
            padding: EdgeInsets.all(16.0),
          ),
        ));
  }
}
