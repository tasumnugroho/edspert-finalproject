import 'package:edspert_finalproject/constants/r.dart';
import 'package:edspert_finalproject/models/network_response.dart';
import 'package:edspert_finalproject/models/paket_soal_list.dart';
import 'package:edspert_finalproject/repository/latihan_soal_api.dart';
import 'package:edspert_finalproject/view/main/latihan_soal/kerjakan_latihan_soal_page.dart';
import 'package:flutter/material.dart';

class PaketSoalPage extends StatefulWidget {
  const PaketSoalPage({Key? key, required this.id}) : super(key: key);
  static String route = "paket_soal_page";
  final String id;
  @override
  State<PaketSoalPage> createState() => _PaketSoalPageState();
}

class _PaketSoalPageState extends State<PaketSoalPage> {
  PaketSoalList? paketSoalList;
  getPaketSoal() async {
    final mapelREsult = await LatihanSoalApi().getPaketSoal(widget.id);
    if (mapelREsult.status == Status.success) {
      paketSoalList = PaketSoalList.fromJson(mapelREsult.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPaketSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: const Text("Paket Soal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Paket Soal",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: paketSoalList == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                            children: List.generate(paketSoalList!.data!.length,
                                (index) {
                          final currentPaketSoal = paketSoalList!.data![index];
                          return Container(
                            padding: const EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: PaketSoalWidget(data: currentPaketSoal),
                          );
                        }).toList()),
                      )

                // GridView.count(
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 10,
                //     crossAxisCount: 2,
                //     childAspectRatio: 4 / 3,
                //     children:

                //     // [
                //     //   PaketSoalWidget(),
                //     //   PaketSoalWidget(),
                //     //   PaketSoalWidget(),
                //     //   PaketSoalWidget(),
                //     // ],
                //     ),
                ),
          ],
        ),
      ),
    );
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PaketSoalData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KerjakanLatihanSoalPage(id: data.exerciseId!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        // margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                R.assets.icNote,
                width: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.exerciseTitle!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: R.colors.greySubtitleHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
