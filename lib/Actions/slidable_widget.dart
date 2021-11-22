import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableActions { delete }

class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final Function(SlidableActions action) onDismissed;

  const SlidableWidget({
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: child,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.40,
      secondaryActions: <Widget>[
        IconSlideAction(
          iconWidget: Container(
            width: 300,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.only(left: 5, bottom: 20),
            child: Text(
              "Удалить",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => onDismissed(SlidableActions.delete),
        )
      ],
    );
  }
}
