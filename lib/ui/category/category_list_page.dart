import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/models/category_model.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/ui/ultils/color_extension.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoriesListDataSources = [];
  bool isEditMode = false;
  @override
  void initState() {
    super.initState();
    // Hàm _getCategoryList() sẽ được gọi khi mọi thứ render ra màn hình, tương tự Document.ready, vì đây là hàm bất đồng bộ
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryList();
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
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),
            _buildCreateCategoryButton()
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      children: [
        Text(
          "Category_list_page_title",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold),
        ).tr(),
        const Divider(
          color: Color(0xFF979797),
        )
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            //Thuộc tính dùng để set chều cao và chiều rộng trong GridView
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          final isLastItem = index == categoriesListDataSources.length;
          if (isLastItem) {
            return _buildGridCategoryItemCreateNew();
          }
          final category = categoriesListDataSources[index];
          return _buildGridCategoryItem(category);
        },
        itemCount: categoriesListDataSources.length + 1);
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandlerCreateCategoryItem(category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: category.backgroundColorHex != null
                  ? HexColor(category.backgroundColorHex!)
                  : Colors.white,
              border: Border.all(
                  color: isEditMode ? Colors.orange : Colors.transparent,
                  width: isEditMode ? 2 : 0),
            ),
            // vì icon lưu vào cơ sở dữ liệu dưới dạng codepoint, nên cần hàm IconData để chuyển đổi
            child: category.iconCodePoint != null
                ? Icon(
                    IconData(category.iconCodePoint!,
                        fontFamily: "MaterialIcons"),
                    color: category.iconColorHex != null
                        ? HexColor(category.iconColorHex!)
                        : Colors.white,
                    size: 30)
                : null,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _goToCreateCategoryPage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF80FFD9),
            ),
            // vì icon lưu vào cơ sở dữ liệu dưới dạng codepoint, nên cần hàm IconData để chuyển đổi
            child: const Icon(Icons.add, color: Color(0xFF00A369), size: 30),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              "Create New",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107, bottom: 24),
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
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                isEditMode
                    ? "Cancel Edit"
                    : "Category_list_edit_category_button",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ).tr())
        ],
      ),
    );
    // return SizedBox(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //       onPressed: () {},
    //       style: ElevatedButton.styleFrom(
    //           backgroundColor: const Color(0xFF8875FF),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(4))),
    //       child: const Text(
    //         "Category_list_add_category_button",
    //         style: TextStyle(fontSize: 16, color: Colors.white),
    //       ).tr()),
    // );
  }

  Future<void> _getCategoryList() async {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);
    // RealmResult CategoryRealmEntity => List<CategoryRealmEntity>
    final categories = realm.all<CategoryRealmEntity>();
    List<CategoryModel> categoryModels = categories.map((e) {
      return CategoryModel(
          id: e.id.hexString,
          name: e.name,
          iconCodePoint: e.iconCodePoint,
          backgroundColorHex: e.backgroundColorHex,
          iconColorHex: e.iconColorHex);
    }).toList();
    setState(() {
      categoriesListDataSources = categoryModels;
    });
  }

  void _goToCreateCategoryPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateOrEditCategory()));
  }

  void _onHandlerCreateCategoryItem(CategoryModel category) {
    if (isEditMode) {
      //Đi đến màn edit
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateOrEditCategory(
                    categoryId: category.id,
                  )));
    } else {
      Navigator.pop(context, {
        "categoryId": category.id,
        "name": category.name,
        "iconCodePoint": category.iconCodePoint,
        "backgroundColorHex": category.backgroundColorHex,
        "iconColorHex": category.iconColorHex
      });
    }
  }
}
