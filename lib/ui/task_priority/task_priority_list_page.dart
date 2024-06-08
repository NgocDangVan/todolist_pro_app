import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/models/category_model.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/ui/ultils/color_extension.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<TaskPriorityListPage> {
  List<int> priorityListDataSources = [];
  int? _selectPriority;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        priorityListDataSources = List.generate(10, (index) => index + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildBodyPage());
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFF363636)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChoosePriorityTitle(),
            _buildGridPriorityList(),
            _buildCreatePriorityButton()
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      children: [
        Text(
          "Task Priority",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Color(0xFF979797),
        )
      ],
    );
  }

  Widget _buildGridPriorityList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            //Thuộc tính dùng để set chều cao và chiều rộng trong GridView
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          final priority = priorityListDataSources[index];
          return _buildGridPriorityItem(priority);
        },
        itemCount: priorityListDataSources.length);
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = priority == _selectPriority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectPriority = priority;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected == true
                ? const Color(0xFF8687E7)
                : const Color(0xFF272727),
          ),
          // vì icon lưu vào cơ sở dữ liệu dưới dạng codepoint, nên cần hàm IconData để chuyển đổi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/flag.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Text(
                priority.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "common_cancel",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              ).tr()),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {"priority": _selectPriority});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Text(
                "Save",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ).tr())
        ],
      ),
    );
  }
}
