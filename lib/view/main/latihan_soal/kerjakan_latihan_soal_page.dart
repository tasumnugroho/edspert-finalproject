import 'package:edspert_finalproject/models/kerjakan_soal_list.dart';
import 'package:edspert_finalproject/models/network_response.dart';
import 'package:edspert_finalproject/repository/latihan_soal_api.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {
  KerjakanSoalList? soalList;
  getQuestionList() async {
    final result = await LatihanSoalApi().postQuestionList(widget.id);
    if (result.status == Status.success) {
      soalList = KerjakanSoalList.fromJson(result.data!);
      _controller = TabController(length: soalList!.data!.length, vsync: this);
      setState(() {});
    }
  }

  TabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Soal"),
      ),
      //tombol selanjutnya atau submit
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Selanjutnya"))
          ],
        ),
      ),
      body: soalList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                //TabBar no soal
                Container(
                  child: TabBar(
                    controller: _controller,
                    tabs: List.generate(
                      soalList!.data!.length,
                      (index) => Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                //TabBarView soal dan pilihan jawaban
                Expanded(
                    child: Container(
                  child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        soalList!.data!.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Soal no ${index + 1}"),
                            if (soalList!.data![index].questionTitle != null)
                              Text(soalList!.data![index].questionTitle!),
                            if (soalList!.data![index].questionTitleImg != null)
                              Image.network(
                                  soalList!.data![index].questionTitleImg!),
                            _buildOption(
                              "A.",
                              soalList!.data![index].optionA,
                              soalList!.data![index].optionAImg,
                            ),
                            _buildOption(
                              "B.",
                              soalList!.data![index].optionB,
                              soalList!.data![index].optionBImg,
                            ),
                            _buildOption(
                              "C.",
                              soalList!.data![index].optionC,
                              soalList!.data![index].optionCImg,
                            ),
                            _buildOption(
                              "D.",
                              soalList!.data![index].optionD,
                              soalList!.data![index].optionDImg,
                            ),
                            _buildOption(
                              "E.",
                              soalList!.data![index].optionE,
                              soalList!.data![index].optionEImg,
                            ),
                          ],
                        ),
                      ).toList()),
                ))
              ],
            ),
    );
  }

  Container _buildOption(
    String option,
    String? answer,
    String? answerImg,
  ) {
    return Container(
      child: Row(
        children: [
          Text(option),
          if (answer != null) Text(answer),
          if (answerImg != null) Image.network(answerImg),
        ],
      ),
    );
  }
}
