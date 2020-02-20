import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTaskDialog extends StatelessWidget {
  final _titleController;
  final _descriptionController;
  final Function _saveTask;

  NewTaskDialog(
      this._titleController, this._descriptionController, this._saveTask);

  @override
  Widget build(BuildContext context) {
    final _bottomButtons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Platform.isIOS
            ? CupertinoButton(
                child: Text('Save'),
                onPressed: () => this._saveTask(context),
              )
            : RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _saveTask(context),
              ),
      ],
    );
    final _content = Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Platform.isIOS
              ? CupertinoTextField(
                  placeholder: 'Title',
                  controller: _titleController,
                )
              : TextField(
                  decoration: InputDecoration(
                      labelText: 'Title', contentPadding: EdgeInsets.all(10)),
                  controller: _titleController,
                ),
          Platform.isIOS
              ? CupertinoTextField(
                  placeholder: 'Description',
                  minLines: 5,
                  maxLines: 15,
                  controller: _descriptionController,
                )
              : TextField(
                  minLines: 5,
                  maxLines: 15,
                  decoration: InputDecoration(
                    labelText: 'Type a description',
                    contentPadding: EdgeInsets.all(10),
                  ),
                  controller: _descriptionController,
                ),
          Platform.isIOS ? Text('') : _bottomButtons
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text('Add new task'),
            content: _content,
            actions: <Widget>[
              _bottomButtons,
            ],
          )
        : SimpleDialog(
            title: Text('Add new task'),
            children: <Widget>[
              _content,
            ],
          );
  }
}
