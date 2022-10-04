import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edspert_finalproject/constants/r.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference chat = FirebaseFirestore.instance
        .collection("room")
        .doc("kimia")
        .collection("chat");
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskusi soal"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama User",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff5200ff),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xffffdcdc),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          child: Text("Pesan"),
                        ),
                        Text(
                          "Waktu Kirim",
                          style: TextStyle(
                            fontSize: 10,
                            color: R.colors.greySubtitleHome,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25),
                  )
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              child: TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {},
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Tulis pesan disini..",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        return;
                      }
                      print(textController.text);
                      final user = FirebaseAuth.instance.currentUser!;

                      final chatContent = {
                        "nama": user.displayName,
                        "uid": user.uid,
                        "content": textController.text,
                        "email": user.email,
                        "photo": user.photoURL,
                        "time": FieldValue.serverTimestamp()
                      };
                      chat.add(chatContent);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
