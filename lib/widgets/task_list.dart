import 'dart:io';

import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  final _listTask;
  final Function updateCheckBox;
  final Function deleteTask;
  final bool _isPortrait;

  TaskList(
      this._listTask, this.updateCheckBox, this.deleteTask, this._isPortrait);

  void showTaskDetails(BuildContext context, Task task) {
    final status = task.finished ? 'FINALIZADO' : 'PENDENTE';
    showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '${task.title} $status',
                            style: TextStyle(
                              fontFamily: 'Permanent Marker',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(task.description,
                              style: TextStyle(
                                fontFamily: 'Righteous',
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final int descriptionMaxLength = _isPortrait ? 65 : 160;

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final _title = Text(
          _listTask[index].title,
          style: _listTask[index].finished
              ? TextStyle(
                  fontFamily: 'Permanent Marker',
                  decoration: TextDecoration.lineThrough,
                )
              : TextStyle(
                  fontFamily: 'Permanent Marker',
                ),
        );
        final _subtitle = _listTask[index].finished
            ? Text('')
            : Text(
                _listTask[index].description.length > descriptionMaxLength
                    ? '${_listTask[index].description.substring(0, descriptionMaxLength)}...'
                    : _listTask[index].description,
                style: TextStyle(
                  fontFamily: 'Righteous',
                ),
              );

        return Platform.isIOS
            ? Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Checkbox(
                              value: _listTask[index].finished,
                              onChanged: (val) =>
                                  this.updateCheckBox(val, index),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              _title,
                              _subtitle,
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => this.deleteTask(index),
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            : ListTile(
                onLongPress: () =>
                    this.showTaskDetails(context, _listTask[index]),
                leading: Checkbox(
                  value: _listTask[index].finished,
                  onChanged: (val) => this.updateCheckBox(val, index),
                ),
                trailing: IconButton(
                  onPressed: () => this.deleteTask(index),
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
                title: _title,
                subtitle: _subtitle,
              );
      },
      separatorBuilder: (BuildContext ctx, int index) => Divider(),
      itemCount: _listTask.length,
      shrinkWrap: true,
    );
  }
}
