import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/ui/ultils/color_extension.dart';

class CreateOrEditCategory extends StatefulWidget {
  const CreateOrEditCategory({super.key});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  final List<Color> _colorDataSource = [];
  Color colorSelected = const Color(0xFF0069A3);
  Color _iconColorSelected = Colors.white;
  IconData? _iconSelected;
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
              _onChooseIconAndTextColor(),
              _buildCategoryPreview()
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
              onChanged: (String? value) {
                setState(() {});
              },
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
            onTap: _chooseIcon,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFFFFFFFF).withOpacity(0.21)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _iconSelected != null
                    ? Icon(
                        _iconSelected,
                        color: Colors.white,
                        size: 26,
                      )
                    : const Text(
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
            child: GestureDetector(
              onTap: _onChooseCategoryBackgroundColor,
              child: Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36 / 2),
                    color: colorSelected),
              ),
            ),
          )
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   width: double.infinity,
          //   height: 36,
          //   //Một cách khác thay vì dùng row để hiển thị theo chiều ngang thì dùng ListView
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context, index) {
          //         final color = _colorDataSource.elementAt(index);
          //         final isSelected = colorSelected == color;
          //         return GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               colorSelected = color;
          //             });
          //           },
          //           child: Container(
          //             width: 36,
          //             height: 36,
          //             margin: EdgeInsets.only(right: 12),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(36 / 2),
          //                 color: color),
          //             child: isSelected
          //                 ? const Icon(
          //                     Icons.check,
          //                     color: Colors.white,
          //                     size: 20,
          //                   )
          //                 : null,
          //           ),
          //         );
          //       },
          //       itemCount: _colorDataSource.length),
          // ),
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

  void _onHandlerCreateCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        _showAlert("Validation", "Category name is required");
        return;
      }

      if (_iconColorSelected == null) {
        _showAlert("Validation", "Category Icon is required");
        return;
      }

      //Mở Realm để chuẩn bị lưu dữ liệu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      final backgroundColorHex = colorSelected.toHex();
      var category = CategoryRealmEntity(ObjectId(), categoryName,
          iconCodePoint: _iconSelected?.codePoint,
          backgroundColorHex: backgroundColorHex,
          iconColorHex: _iconColorSelected.toHex());
      await realm.writeAsync(() {
        realm.add(category);
      });

      var categories = realm.all<CategoryRealmEntity>();
      print(
          "My category is: ${categories[0].name} model: ${categories[0].backgroundColorHex}");

      _nameCategoryTextController.text = "";
      colorSelected = const Color(0xFF0069A3);
      _iconColorSelected = Colors.white;
      _iconSelected = null;
      setState(() {});
      //show alert lên người dùng
      _showAlert("Successfully", "Create Category success");
    } catch (e) {
      print(e);
      _showAlert("Failed", "Create Category failed");
    }
  }

  void _chooseIcon() async {
    const Map<String, IconData> myCustomIcons = {
      'threesixty': Icons.threesixty,
      'threed_rotation': Icons.threed_rotation,
      'four_k': Icons.four_k,
      'ac_unit': Icons.ac_unit,
      'access_alarm': Icons.access_alarm,
      'access_alarms': Icons.access_alarms,
      'access_time': Icons.access_time,
      'accessibility': Icons.accessibility,
      'accessibility_new': Icons.accessibility_new,
      'accessible': Icons.accessible,
      'accessible_forward': Icons.accessible_forward,
      'account_balance': Icons.account_balance,
      'account_balance_wallet': Icons.account_balance_wallet,
      'account_box': Icons.account_box,
      'account_circle': Icons.account_circle,
    };
    IconData? icon =
        await showIconPicker(context, customIconPack: myCustomIcons);
    setState(() {
      _iconSelected = icon;
    });
  }

  void _onChooseCategoryBackgroundColor() async {
    showDialog(
        context: context,
        builder: (context) {
          // Cách 1
          // return AlertDialog(
          //   content: SingleChildScrollView(
          //     child: ColorPicker(
          //         pickerColor: colorSelected,
          //         onColorChanged: (Color newColor) {
          //           setState(() {
          //             colorSelected = newColor;
          //           });
          //         }),
          //   ),
          // );
          //Cách 2:
          return AlertDialog(
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: colorSelected,
                enableLabel: true,
                onColorChanged: (Color newColor) {
                  setState(() {
                    colorSelected = newColor;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  void _onChooseCategoryIconTextColor() async {
    showDialog(
        context: context,
        builder: (context) {
          // Cách 1
          return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickerColor: _iconColorSelected,
                  onColorChanged: (Color newColor) {
                    setState(() {
                      _iconColorSelected = newColor;
                    });
                    Navigator.pop(context);
                  }),
            ),
          );
        });
  }

  Widget _onChooseIconAndTextColor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle(
              "Create_category_form_category_icon_text_color_label".tr()),
          //GestureDetector để sử dụng sự kiện trong container
          Container(
            margin: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryIconTextColor,
              child: Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36 / 2),
                    color: _iconColorSelected),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFieldTitle("Create_category_form_category_preview".tr()),
          Column(
            children: [
              Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorSelected,
                ),
                child: Icon(_iconSelected, color: _iconColorSelected, size: 30),
              ),
              Text(
                _nameCategoryTextController.text,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}
