/*
  - adicionar pacote de fontes
  - adicionar tema no app
  - corrigir estouro de lista
  - definir tamanho de acordo com orientação do telefone pegando dinamicamente o tamanho da tela
  - adaptar widgets possíveis para IOS
  - adicionar imagem quando não tiver nenhum item na lista
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import './models/task.dart';
import './widgets/new_task_dialog.dart';
import './widgets/task_list.dart';
import './widgets/empty_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.yellow,
          fontFamily: 'Permanent Marker',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 18,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 20,
                  ),
                ),
          )),
      title: 'My Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  var _listTask = [
    Task('Primeira tarefa',
        'Essa é uma descrição criada para a primeira tarefa', false),
    Task(
        'Segunda Tarefa Título',
        'Aqui vou descrever um pouco mais sobre minha segunda tarefa asddoasjd oajd oiasjd asijd ioasjd ioasjdio jsaiojdioasjd josaijdo isajd oisajd oisaji dojasoid jsaoijd oiasjd oiasjd oisajd oiasj doisaj iodjaso djosaj doisajd oisaj dsajd oasjd iosajd oja',
        false),
  ];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void updateCheckBox(value, index) {
    setState(() {
      _listTask[index].finished = value;
    });
  }

  void _saveTask(BuildContext ctx) {
    setState(() {
      _listTask
          .add(Task(_titleController.text, _descriptionController.text, false));
    });
    _titleController.clear();
    _descriptionController.clear();
    Navigator.of(ctx).pop();
  }

  void _deleteTask(index) {
    setState(() {
      _listTask.removeAt(index);
    });
  }

  void addTask(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (_) {
          return NewTaskDialog(
            this._titleController,
            this._descriptionController,
            this._saveTask,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final _mediaQuery = MediaQuery.of(context);
    final bool _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    final double _heightTwentyPercent = _mediaQuery.size.height * 0.2;
    final double _heightThirtyPercent = _mediaQuery.size.height * 0.3;
    final double _appBarHeight =
        _isPortrait ? (_heightTwentyPercent) : (_heightThirtyPercent);

    final _pageBody = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: _listTask.length == 0
          ? EmptyList()
          : TaskList(
              _listTask,
              this.updateCheckBox,
              this._deleteTask,
              _isPortrait,
            ),
    );

    final _appBar = PreferredSize(
      preferredSize: Size.fromHeight(_appBarHeight),
      child: AppBar(
        bottom: PreferredSize(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'My Tasks App',
                      style: TextStyle(
                        backgroundColor: Colors.white30,
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: TextStyle(
                          backgroundColor: Colors.white30,
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Righteous'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.add),
            textColor: Theme.of(context).accentColor,
            onPressed: () => this.addTask(context),
          ),
        ],
        flexibleSpace: Image(
          image: AssetImage('assets/images/task.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: Text('My Task App'),
              trailing: FlatButton(
                child: Text('Adicionar'),
                onPressed: () => this.addTask(context),
                textColor: Colors.white,
              ),
            ),
          )
        : Scaffold(
            appBar: _appBar,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => this.addTask(context),
            ),
            body: _pageBody,
          );
  }
}
