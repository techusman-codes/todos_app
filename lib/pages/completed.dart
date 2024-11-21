import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todostate_app/models/todo.dart';
import 'package:todostate_app/providers/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);

    List<Todo> completedTodos = todos
        .where(
          (todos) => todos.completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Todo App",
        )),
      ),
      body: ListView.builder(
          itemCount: completedTodos.length,
          itemBuilder: (context, index) {
            if (index == completedTodos.length) {}
            return Slidable(
                startActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .deleteTodo(completedTodos[index].todoId),
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    icon: Icons.delete,
                  )
                ]),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                      title: Text(
                    completedTodos[index].content,
                  )),
                ));
          }),
    );
  }
}
