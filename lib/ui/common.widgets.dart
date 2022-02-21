import 'package:flutter/material.dart';
import 'package:hksz/model/models.dart';

class PropertyWidget extends StatelessWidget {
  final String name;
  final dynamic value;
  const PropertyWidget({Key? key, required this.name, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    child = Row(
      children: [
        Text('$name:'),
        Text('$value'),
      ],
    );
    return child;
  }
}

class RoomItem extends StatelessWidget {
  final RoomInfo roomInfo;

  const RoomItem({Key? key, required this.roomInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PropertyWidget(name: 'id', value: roomInfo.id),
        PropertyWidget(
            name: 'count', value: '${roomInfo.count}/${roomInfo.total}'),
        PropertyWidget(name: 'date', value: roomInfo.date),
        // PropertyWidget(name: 'sign', value: roomInfo.sign),
        // PropertyWidget(name: 'timespan', value: roomInfo.timespan),
      ],
    );
    return child;
  }
}

class AccountItem extends StatelessWidget {
  final UserAccount account;

  const AccountItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Row(
      children: [
        Text('${account.certificate?.name}'),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text('${account.certType} / ${account.certNo} / ${account.pwd}'),
          flex: 1,
        ),
        // Expanded(
        //   child: Text('${account.certNo}'),
        //   flex: 2,
        // ),
        // Expanded(
        //   child: Text('${account.pwd}'),
        //   flex: 2,
        // ),
      ],
    );

    return child;
  }
}
