import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController TodoController =
      TextEditingController(); //controlador para pegar o texto

  final now = DateTime.now();

  List<Todo> todos = []; //Lista de Objeto todo
  Todo? deletedTodo; //nullable pq inicia-se com a variável vazia
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TodoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adcione uma Tarefa',
                          hintText: 'ex. Fazer um bolo',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = TodoController
                            .text; // leio o texto e add na variavel text
                        setState(() {
                          Todo newTodo = Todo(
                            // criando um Objeto todo e instanciar
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo); // adcionei na lista de tarefas
                        });
                        TodoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  //nao permite dar error na tela qnd o app completa tda a tela
                  child: ListView(
                    shrinkWrap: true,
                    //para que a lista seja da altura dos componentes
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          //Parametro para passar do Widget para o Widget pai.
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Voce possui ${todos.length} tarefas pendentes!!',
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Text('Limpar tudo'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} deletada com sucesso!!',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.green,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
