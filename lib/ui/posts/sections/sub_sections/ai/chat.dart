import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class VirtualAssistant extends StatefulWidget {
  const VirtualAssistant({Key? key}) : super(key: key);

  @override
  _VirtualAssistantState createState() => _VirtualAssistantState();
}

class _VirtualAssistantState extends State<VirtualAssistant> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Virtual Assistant', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: MessagesScreen(
                messages: messages,
                scrollController: _scrollController,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your message...',
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      // Add the user message immediately to the screen
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      // Scroll immediately after user message
      _scrollToBottom();

      // Request the chatbot's response
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      // Add the chatbot's reply once received
      if (response.message != null) {
        setState(() {
          addMessage(response.message!);
        });

        // Scroll again after chatbot's reply
        _scrollToBottom();
      }
    }
  }


  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

}

class MessagesScreen extends StatefulWidget {
  final List messages;
  final ScrollController scrollController;
  const MessagesScreen({Key? key, required this.messages, required this.scrollController})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      controller: widget.scrollController,  // Attach the scroll controller here
      padding: EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: widget.messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.messages[index]['isUserMessage'] ? 20 : 0),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(widget.messages[index]['isUserMessage'] ? 0 : 20),
                  ),
                  color: widget.messages[index]['isUserMessage']
                      ? Colors.indigo
                      : Colors.blue.shade800,
                ),
                constraints: BoxConstraints(maxWidth: w * 0.75),
                child: Text(
                  widget.messages[index]['message'].text.text[0],
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => SizedBox(height: 10),
      itemCount: widget.messages.length,
    );
  }
}
