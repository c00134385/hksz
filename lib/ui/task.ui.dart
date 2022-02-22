import 'package:flutter/material.dart';
import 'package:hksz/ui/grab.ui.dart';

class TaskUI extends StatefulWidget {
  final TimerTask timerTask;

  const TaskUI({Key? key, required this.timerTask}) : super(key: key);

  @override
  _TaskUIState createState() => _TaskUIState();
}

class _TaskUIState extends State<TaskUI> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() {}),
                child: const Text('refresh'),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
          ),
        ),
      ],
    );

    child = Column(
      children: [
        ElevatedButton(
          onPressed: () => setState(() {}),
          child: const Text('refresh'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Text(widget.timerTask.output),
          ),
        ),
      ],
    );

    child = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );

    child = SafeArea(child: child);

    child = Scaffold(
      appBar: AppBar(
        title: const Text('Grab Page'),
      ),
      body: child,
    );
    return child;
  }
}
