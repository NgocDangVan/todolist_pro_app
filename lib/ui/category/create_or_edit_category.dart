import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateOrEditCategory extends StatefulWidget {
  const CreateOrEditCategory({super.key});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  final List<Color> _colorDataSource = [];
  Color? colorSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _colorDataSource.addAll([
      Color(0xFFC9CC41),
      Color(0xFF66CC41),
      Color(0xFF41CCA7),
      Color(0xFF4181CC),
      Color(0xFF41A2CC),
      Color(0xFFCC8441),
      Color(0xFF9741CC),
      Color(0xFFCC4173),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text("Create_category_page_title",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
            .tr(),
      ),
      body: _buildBodyPageScreen(),
    );
  }

  Widget _buildBodyPageScreen() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryNameField(),
              _buildCategoryChooseIconField(),
              _buildCategoryChooseBackgroundField(),
            ],
          )),
          _buildCancelOrEditCategoryButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Create_category_form_category_name_label".tr()),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                  hintText:
                      "Create_category_form_category_name_placeholder".tr(),
                  hintStyle: TextStyle(fontSize: 16, color: Color(0XFFAFAFAF)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF979797)))),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Create_category_form_category_icon_label".tr()),
          //GestureDetector để sử dụng sự kiện trong container
          GestureDetector(
            onTap: () {
              print("Hello: Chọn Icon từ 1 màn hình khác");
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFFFFFFFF).withOpacity(0.21)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text(
                        "Create_category_form_category_icon_placeholder",
                        style: TextStyle(fontSize: 12, color: Colors.white))
                    .tr(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle(
              "Create_category_form_category_background_color_label".tr()),
          //GestureDetector để sử dụng sự kiện trong container
          Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 36,
            //Một cách khác thay vì dùng row để hiển thị theo chiều ngang thì dùng ListView
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final color = _colorDataSource.elementAt(index);
                  final isSelected = colorSelected == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        colorSelected = color;
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36 / 2),
                          color: color),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                },
                itemCount: _colorDataSource.length),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldTitle(String titleLable) {
    return Text(titleLable,
        style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.87)));
  }

  Widget _buildCancelOrEditCategoryButton() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 24).copyWith(top: 20, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
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
                _onHandlerCreateCategory();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Text(
                "Create_category_create_button",
                style: TextStyle(
                    fontSize: 16, fontFamily: "Lato", color: Colors.white),
              ).tr())
        ],
      ),
    );
  }

  void _onHandlerCreateCategory() {
    final categoryName = _nameCategoryTextController.text;
    print(categoryName);
  }
}
