import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/task/create_task_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [];
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.purple,
      ),
      Container(
        color: Colors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _pages.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF8687E7),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Image.asset(
                "assets/images/home_2.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              activeIcon: Image.asset(
                "assets/images/home_2.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
                color: const Color(0xFF8687E7),
              ),
              label: "Index"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Image.asset(
                "assets/images/calendar.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              activeIcon: Image.asset(
                "assets/images/calendar.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
                color: const Color(0xFF8687E7),
              ),
              label: "Calendar"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Container(),
              label: ""),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Image.asset(
                "assets/images/clock.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              activeIcon: Image.asset(
                "assets/images/clock.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
                color: const Color(0xFF8687E7),
              ),
              label: "Focuse"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Image.asset(
                "assets/images/user.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              activeIcon: Image.asset(
                "assets/images/user.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
                color: const Color(0xFF8687E7),
              ),
              label: "Profile")
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: const Color(0xFF8687E7),
            borderRadius: BorderRadius.circular(32)),
        child: IconButton(
          onPressed: () {
            _onShowCreateTask.call();
          },
          icon: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onShowCreateTask() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const CreateTaskPage());
        });
  }
}
