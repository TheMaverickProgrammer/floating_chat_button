import 'package:example/dismissible_bottom_sheet_view.dart';
import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Chat Button Demo',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabBarIndex = 0;
  final GlobalKey<FloatingChatButtonState> _page2Key = GlobalKey();

  Future<void> _showBottomSheet(BuildContext bContext) async {
    return showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: bContext,
      builder: (context) => DismissibleBottomSheetView(
        childView: Container(
            width: double.infinity,
            color: Colors.white,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Imagine this is a chat UI",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ),
            )),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return FloatingChatButton(
          background: ListView.builder(
            itemCount: 100,
            padding: const EdgeInsets.all(4),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                      color: Colors.green,
                      child: ListTile(
                        title: Text("Random title ${index + 1}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                        subtitle: Text("Random content ${index + 1}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index % 3 == 0)
                              const Icon(Icons.label, color: Colors.white),
                            if (index % 3 == 1)
                              const Icon(Icons.map, color: Colors.white),
                            if (index % 3 == 2)
                              const Icon(Icons.create_outlined,
                                  color: Colors.white)
                          ],
                        ),
                        trailing: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
          onTap: (_) {
            _showBottomSheet(context);
          },
          chatIconBorderColor: Colors.white,
          messageBorderWidth: 2,
          messageText: "You've received a message!",
          showMessageParameters: ShowMessageParameters(
              delayDuration: const Duration(seconds: 2),
              durationToShowMessage: const Duration(seconds: 5)),
        );
      case 1:
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Click to receive a message",
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center),
                      TextButton(
                        child: const Text("Click me",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          _page2Key.currentState?.showMessage(
                              messageText: "What do you want?",
                              duration: const Duration(seconds: 4));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              FloatingChatButton(
                key: _page2Key,
                onTap: (_) {
                  _showBottomSheet(context);
                },
                chatIconWidget: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
                messageBackgroundColor: Colors.green,
                chatIconBorderColor: Colors.green,
                chatIconBackgroundColor: Colors.white,
              )
            ],
          );
        });
      case 2:
        return FloatingChatButton(
            background: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Shows a message 50% of the time it's instantiated",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center),
              ),
            ),
            onTap: (_) {
              _showBottomSheet(context);
            },
            messageBackgroundColor: Colors.red,
            chatIconBorderColor: Colors.red,
            chatIconBackgroundColor: Colors.white,
            chatIconWidget: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(Icons.flag, color: Colors.red, size: 40),
            ),
            messageText: "It's 50% of the time!",
            showMessageParameters: ShowMessageParameters(
                delayDuration: const Duration(seconds: 1),
                showMessageFrequency: 0.5));
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _getPage(tabBarIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabBarIndex,
        onTap: (index) => setState(() => tabBarIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pool),
            label: "Example 1",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.power_outlined),
            label: "Example 2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: "Example 3",
          )
        ],
      ),
    );
  }
}
