import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animated List Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  void _addItem() {
    setState(() {
      items.insert(0, 'Item ${items.length + 1}');
      _listKey.currentState?.insertItem(0);
    });
  }

  void _removeItem() {
    if (items.isEmpty) return;
    int index = items.length - 1;
    String removedItem = items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(removedItem, animation),
    );
  }

  Widget _buildRemovedItem(String item, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Card(
        child: ListTile(
          title: Text(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList Example'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) {
          return ScaleTransition(
            scale: animation,
            child: Card(
              child: ListTile(
                title: Text(items[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _addItem,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _removeItem,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
