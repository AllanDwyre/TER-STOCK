import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_stock/inventory/views/inventory_page.dart';
import 'package:hive_stock/utils/constants/padding.dart';

import 'package:file_picker/file_picker.dart';// https://pub.dev/packages/file_picker

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {

  String? productImageName;
  String defaultPathImage = "/Users/denilb/AndroidStudioProjects/TER-STOCK/front/hive_stock/assets/images(for_test)/image_not_rendering.png";
  AssetImage productImage = const AssetImage("/Users/denilb/AndroidStudioProjects/TER-STOCK/front/hive_stock/assets/images(for_test)/image_not_rendering.png");

  final _controllerProductName = TextEditingController();
  final _controllerProductId = TextEditingController();
  final _controllerBuyingPrice = TextEditingController();
  bool _validateProductName = false;
  bool _validateProductId = false;
  bool _validateBuyingPrice = false;

  @override
  void dispose() {
    _controllerProductName.dispose();
    _controllerProductId.dispose();
    _controllerBuyingPrice.dispose();
    super.dispose();
  }

  Future<void> finishAdd(BuildContext context, String productName, String productId, String productBuyingPrice) async {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Center(child: Text('Product Added !')),
        backgroundColor: Color.fromARGB(255, 118, 177, 91)
        ),
    );
    await Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const InventoryScreen()));
    });
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
                height: size.width/2,
                width: size.width/2,
                child: TextButton(
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles();
                    if (picked != null) {
                      setState(() {
                        productImageName = picked.files.first.name;
                        productImage = AssetImage(picked.files.first.path??defaultPathImage);
                      });
                    }
                    else{
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
                            productImageName??"Browse image",
                            style: textTheme
                                  .titleMedium
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
          myInputField(_controllerProductName, _validateProductName, "Product Name *", "Enter product name"),
          myInputField(_controllerProductId, _validateProductId, "Product ID *", "Enter product id"),
          myInputField(null, false, "Supplier", "Enter supplier name"),
          myInputField(null, false, "Category", "Enter product category"),
          myInputField(null, false, "Unit", "Enter product unit mesure"),
          myInputField(_controllerBuyingPrice, _validateBuyingPrice, "Buying price *", "Enter product buying price"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2*kDefaultPadding, vertical: kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorTheme.onPrimary,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: colorTheme.primary)
                      ),
                      child: Center(child: Text(
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
                        _validateProductName = _controllerProductName.text.isEmpty;
                        _validateProductId = _controllerProductId.text.isEmpty;
                        _validateBuyingPrice = _controllerBuyingPrice.text.isEmpty;
                      });
                      if(!(_validateProductName || _validateProductId || _validateBuyingPrice)){
                        finishAdd(context, _controllerProductName.text, _controllerProductId.text, _controllerBuyingPrice.text);
                      };
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorTheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(child: Text(
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

Container myInputField(myController, myValidate, myLabelText, myHintText){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
    child: Center(
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize:16),
          labelText: myLabelText,
          errorText: myValidate ? "Value Can't Be Empty" : null,
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: myHintText,
        ),
      ),
    ),
  );
}