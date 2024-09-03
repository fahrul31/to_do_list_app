import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/provider/checklist_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do-List"),
      ),
      body: Consumer<ChecklistProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const CircularProgressIndicator();
          } else if (state.state == ResultState.hasData) {
            final checklist = state.checklistResult;
            return ListView.builder(
              itemCount: checklist.length,
              itemBuilder: (context, index) {
                final data = checklist[index];
                return ExpansionTile(
                  title: Row(
                    children: [
                      Checkbox(
                        value: data.checklistCompletionStatus,
                        onChanged: (bool? newValue) {
                          // Implementasikan fungsi perubahan status checklist di sini
                        },
                      ),
                      Text(data.name),
                    ],
                  ),
                  children: data.items.map<Widget>((item) {
                    return ListTile(
                      leading: Checkbox(
                        value: item.itemCompletionStatus,
                        onChanged: (bool? newValue) {
                          // Implementasikan fungsi perubahan status item di sini
                        },
                      ),
                      title: Text(item.name),
                    );
                  }).toList(),
                );
              },
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}
