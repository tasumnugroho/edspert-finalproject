import 'package:edspert_finalproject/models/mappel_list.dart';
import 'package:edspert_finalproject/view/main/latihan_soal/home_page.dart';
import 'package:edspert_finalproject/view/main/latihan_soal/paket_soal_page.dart';
import 'package:flutter/material.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key, required this.mapel}) : super(key: key);
  static String route = "mapel_page";

  final MappelList mapel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: ListView.builder(
            itemCount: mapel.data!.length,
            itemBuilder: (context, index) {
              final currentMapel = mapel.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(PaketSoalPage.route);
                },
                child: MapelWidget(
                  title: currentMapel.courseName!,
                  totalPacket: currentMapel.jumlahMateri!,
                  totalDone: currentMapel.jumlahDone!,
                ),
              );
            }),
      ),
    );
  }
}
