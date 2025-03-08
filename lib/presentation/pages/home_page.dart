import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/task.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_event.dart';
import '../bloc/category/category_state.dart';
import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';
import '../widgets/task_item.dart';
import '../widgets/weather_widget.dart';

/// Home page of the application
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedCategoryId;
  bool? _selectedCompletionStatus;

  @override
  void initState() {
    super.initState();
    // Initialize default categories and load tasks
    context.read<CategoryBloc>().add(const InitDefaultCategories());
    context.read<TaskBloc>().add(const LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do & Weather'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onFilterSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Tasks'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Completed Tasks'),
              ),
              const PopupMenuItem(
                value: 'incomplete',
                child: Text('Incomplete Tasks'),
              ),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Weather widget
          const WeatherWidget(),

          // Category filter
          _buildCategoryFilter(),

          // Task list
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build category filter chips
  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategoryId == null,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategoryId = null;
                        });
                        context.read<TaskBloc>().add(const LoadTasks());
                      }
                    },
                  ),
                ),
                ...state.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category.name),
                      selected: _selectedCategoryId == category.id,
                      backgroundColor: category.color.withOpacity(0.2),
                      selectedColor: category.color.withOpacity(0.6),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategoryId = selected ? category.id : null;
                        });
                        if (selected) {
                          context
                              .read<TaskBloc>()
                              .add(LoadTasksByCategory(category.id));
                        } else {
                          context.read<TaskBloc>().add(const LoadTasks());
                        }
                      },
                    ),
                  );
                }),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  /// Build task list
  Widget _buildTaskList() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found. Add some tasks!'),
            );
          }

          return BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              if (categoryState is CategoryLoaded) {
                final categories = categoryState.categories;

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final category = categories.firstWhere(
                      (c) => c.id == task.categoryId,
                      orElse: () => const Category(
                        id: 'unknown',
                        name: 'Unknown',
                        color: Colors.grey,
                      ),
                    );

                    return TaskItem(
                      task: task,
                      category: category,
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is TaskError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }

  /// Show dialog to add a new task
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategoryId = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoaded) {
                    final categories = state.categories;

                    if (selectedCategoryId.isEmpty && categories.isNotEmpty) {
                      selectedCategoryId = categories.first.id;
                    }

                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedCategoryId.isNotEmpty
                          ? selectedCategoryId
                          : null,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: category.color,
                                radius: 10,
                              ),
                              const SizedBox(width: 8),
                              Text(category.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedCategoryId = value;
                        }
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  selectedCategoryId.isNotEmpty) {
                final task = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: false,
                  categoryId: selectedCategoryId,
                  createdAt: DateTime.now(),
                );
                context.read<TaskBloc>().add(AddTask(task));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Handle filter selection
  void _onFilterSelected(String value) {
    setState(() {
      _selectedCategoryId = null;
    });

    switch (value) {
      case 'all':
        setState(() {
          _selectedCompletionStatus = null;
        });
        context.read<TaskBloc>().add(const LoadTasks());
        break;
      case 'completed':
        setState(() {
          _selectedCompletionStatus = true;
        });
        context.read<TaskBloc>().add(const LoadCompletedTasks());
        break;
      case 'incomplete':
        setState(() {
          _selectedCompletionStatus = false;
        });
        context.read<TaskBloc>().add(const LoadIncompleteTasks());
        break;
    }
  }
}
