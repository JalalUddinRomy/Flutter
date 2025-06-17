import 'package:flutter/material.dart';
import 'package:todo_app/Data/Models/network_response.dart';
import 'package:todo_app/Data/Models/task_list_model.dart';
import 'package:todo_app/Data/Models/task_model.dart';
import 'package:todo_app/Data/Models/task_status_count.dart';
import 'package:todo_app/Data/Models/task_status_count_model.dart';
import 'package:todo_app/Data/Services/network_caller.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/screens/add_new_task_screen.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';
import 'package:todo_app/widgets/snackbar_message.dart';
import '../widgets/task_card.dart' show TaskCard;
import '../widgets/task_summary_card.dart' show TaskSummaryCard;

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getNewTaskItem();
    _getCountTaskItem();
  }
  bool _getNewTaskInProgress=false;
  bool _getCountTaskInProgress=false;
  List<TaskModel> _getTaskList=[];
  List<TaskCountModel> _getTaskCountList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTapFAB();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          _getNewTaskItem();
          _getCountTaskItem();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTaskInProgress,
                replacement: CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _getTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskModel: _getTaskList[index], onRefreshLIst:_getNewTaskItem);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: _getTaskSummaryCardList(),
        ),
      ),
    );
  }
  List<TaskSummaryCard> _getTaskSummaryCardList(){
    List<TaskSummaryCard> taskSummaryList=[];
    for(TaskCountModel t in _getTaskCountList){
      taskSummaryList.add(TaskSummaryCard(title:t.sId!, count: t.sum!));
    }
    return taskSummaryList;
  }
  Future<void> _getNewTaskItem() async{
    _getTaskList.clear();
    _getNewTaskInProgress=true;
    setState(() {});
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getNewTask);
    if(response.isSuccessful){
      final TaskListModel taskListModel=TaskListModel.fromJson(response.responseData);
      _getTaskList=taskListModel.taskList ?? [];
    }else{
      showSnackbarMessage(context, response.errorMessage,true);
    }
    _getNewTaskInProgress=false;
    setState(() {
    });
  }
  Future<void> _getCountTaskItem() async{
    _getTaskCountList.clear();
    _getCountTaskInProgress=true;
    setState(() {});
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.countTask);
    if(response.isSuccessful){
      final TaskStatusCount taskStatusCount=TaskStatusCount.fromJson(response.responseData);
      _getTaskCountList=taskStatusCount.taskStatusCountList ?? [];
    }else{
      showSnackbarMessage(context, response.errorMessage,true);
    }
    _getCountTaskInProgress=false;
    setState(() {
    });
  }

  void _onTapFAB() async{
    final bool? _shouldRefresh=await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
    if(_shouldRefresh==true){
      _getNewTaskItem();
    }
  }
}


