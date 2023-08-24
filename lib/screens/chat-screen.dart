import 'package:flutter/material.dart';
import '../components/chatbubble.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(
          kCreatedAt, descending: true
        ).snapshots(),
        builder: (context, snapshot) {
         if(snapshot.hasData){
           List<Message> messagesList = [];
           for(int i = 0 ; i<snapshot.data!.docs.length; i++){
             messagesList.add(Message.fromJson(snapshot.data!.docs[i]));

           }

           return Scaffold(
           appBar: AppBar(
             title: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [Image.asset(width: 55, kLogo), Text('Chat')],
             ),
             backgroundColor: kPrimaryColor,
           ),
           body: Column(
             children: [
               Expanded(
                 flex: 8,
                 child: ListView.builder(
                   reverse: true,
                   controller: _controller,
                   itemCount: messagesList.length,
                   itemBuilder: (context, index) {
                     return messagesList[index].id == email ? chatBubble(message: messagesList[index]):
                         chatBubbleForAnotherUser(message: messagesList[index]);
                   },
                 ),
               ),
               Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       controller: controller,
                       onFieldSubmitted: (data){
                         messages.add({
                           kMessage : data,
                           kCreatedAt : DateTime.now(),
                           'id' : email
                         });
                         controller.clear();
                         _controller.animateTo(
                           _controller.position.minScrollExtent,
                           duration: Duration(seconds: 1),
                           curve: Curves.fastOutSlowIn,
                         );
                       },
                       style: TextStyle(color: kPrimaryColor),
                       decoration: InputDecoration(
                           suffixIcon: IconButton(
                             onPressed: () {

                             },
                             icon: Icon(Icons.send),),
                           suffixIconColor: kPrimaryColor,
                           hintText: 'type a message...',
                           hintStyle: TextStyle(color: Colors.grey),
                           enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(33),
                               borderSide: BorderSide(color: kPrimaryColor)),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(33),
                               borderSide:
                               BorderSide(width: 3, color: kPrimaryColor))),
                     ),
                   ))
             ],
           ),
         );}
         else{
           return Text('Loading...');
         }
        });
  }
}
