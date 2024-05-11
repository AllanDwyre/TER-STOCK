import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_stock/product/views/inventory_page.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/padding.dart';

import 'package:file_picker/file_picker.dart';
import 'package:hive_stock/utils/methods/string_extension.dart'; // https://pub.dev/packages/file_picker

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  String? productImageName;
  String defaultPathImage =
      "/Users/denilb/AndroidStudioProjects/TER-STOCK/front/hive_stock/assets/images(for_test)/image_not_rendering.png";
  AssetImage productImage = const AssetImage(
      "/Users/denilb/AndroidStudioProjects/TER-STOCK/front/hive_stock/assets/images(for_test)/image_not_rendering.png");

  final Map<String, TextEditingController> _controller = {
    "Product Name *": TextEditingController(),
    "Product ID *": TextEditingController(),
    "Supplier": TextEditingController(),
    "Category": TextEditingController(),
    "Quantity *": TextEditingController(),
    "Buying Price *": TextEditingController(),
  };

  final Map<String, bool> _validate = {
    "Product Name *": true,
    "Product ID *": true,
    "Supplier": true,
    "Category": true,
    "Quantity *": true,
    "Buying Price *": true,
  };

  @override
  void dispose() {
    _controller.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  Future<void> finishAdd(BuildContext context) async {
    // products.insert(
    //     0,
    //     Product(
    //       name: _controller["Product Name *"]!.text.capitalize(),
    //       sku: _controller["Product ID *"]!.text,
    //       image: "./assets/images(for_test)/${productImageName!}",
    //       category: _controller["Category"]?.text,
    //       price: double.parse(_controller["Buying Price *"]!.text),
    //       quantity: int.parse(_controller["Quantity *"]!.text),
    //     ),
    //     );
    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(
    //     const SnackBar(
    //         content: Center(child: Text('Product Added !')),
    //         backgroundColor: Color.fromARGB(255, 118, 177, 91)),
    //   );
    // await Future.delayed(const Duration(milliseconds: 1500), () async {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) => const InventoryPage()));
    // });
  }

  Container myInputField(myLabelText, myHintText) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Center(
        child: TextField(
          controller: _controller[myLabelText],
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 16),
            labelText: myLabelText,
            errorText: _validate[myLabelText]! ? null : "Value Can't Be Empty",
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: myHintText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SizedBox(
                height: size.width / 2,
                width: size.width / 2,
                child: TextButton(
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles();
                    if (picked != null) {
                      setState(() {
                        productImageName = picked.files.first.name;
                        productImage = AssetImage(
                            picked.files.first.path ?? defaultPathImage);
                      });
                    } else {
                      setState(() {
                        productImageName = null;
                      });
                    }
                  },
                  child: productImageName == null
                      ? DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          dashPattern: const [10, 10],
                          color: Colors.grey,
                          strokeWidth: 2,
                          child: Center(
                            child: Text(
                              productImageName ?? "Browse image",
                              style: textTheme.titleMedium
                                  ?.copyWith(color: colorTheme.onBackground),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          myInputField("Product Name *", "Enter product name"),
          myInputField("Product ID *", "Enter product id"),
          myInputField("Supplier", "Enter supplier name"),
          myInputField("Category", "Enter product category"),
          myInputField("Quantity *", "Enter product quantity"),
          myInputField("Buying Price *", "Enter product buying price"),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 2 * kDefaultPadding, vertical: kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: colorTheme.onPrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: colorTheme.primary)),
                      child: Center(
                          child: Text(
                        'Discard',
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.primary),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _controller.forEach((k, C) => _validate[k] =
                            (k[k.length - 1] != '*') || C.text.isNotEmpty);
                      });
                      if (!_validate.values.any((v) => !v)) {
                        finishAdd(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorTheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                          child: Text(
                        'Add Product',
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.onPrimary),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
