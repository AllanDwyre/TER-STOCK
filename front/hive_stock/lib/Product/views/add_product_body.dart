import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/views/auth_button.dart';
import 'package:hive_stock/product/bloc/add_or_edit_product_bloc.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/utils/constants/colors.dart';
import 'package:hive_stock/utils/constants/padding.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:hive_stock/utils/widgets/buttons.dart';
import 'package:hive_stock/utils/widgets/form_text_field.dart';

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  String? productImageName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: BlocConsumer<AddOrEditProductBloc, AddOrEditProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: onListen,
        builder: (context, state) {
          return Container(
            height: size.height - 100,
            padding: defaultPagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _ImagePicker(),
                const SizedBox(height: 20),
                FormTextField(
                  labelText: 'Product Name',
                  hintText: 'Enter product name',
                  errorText: null,
                  onChanged: (name) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(name: name)),
                ),
                FormTextField(
                  labelText: 'Category',
                  hintText: 'Enter product category',
                  errorText: null,
                  onChanged: (category) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(category: category)),
                ),
                FormTextField(
                  labelText: 'Dimension',
                  hintText: 'Enter product dimension',
                  errorText: null,
                  onChanged: (dimension) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(dimension: dimension)),
                ),
                FormTextField(
                  labelText: 'Weight',
                  hintText: 'Enter product weight',
                  errorText: null,
                  onChanged: (weight) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(weight: weight)),
                ),
                FormTextField(
                  labelText: 'Buying Price',
                  hintText: 'Enter product buying price',
                  errorText: null,
                  onChanged: (price) {
                    context
                        .read<AddOrEditProductBloc>()
                        .add(OnInformationChangeProduct(price: price));
                  },
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: !state.status.isInProgress,
                      child: SecondaryButton(
                        text: 'Discard',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    StatefullButton(
                      text: 'Add Product',
                      onPressed: _onPressed(context, state),
                      isInProgress: state.status.isInProgress,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onListen(context, state) {
    if (state.status.isSuccess) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              backgroundColor: lightCustomColors.successContainer,
              content: Text(
                'Création produit réussite',
                style: TextStyle(color: lightCustomColors.onSuccessContainer),
              )),
        );
      Navigator.of(context)
          .pushReplacement(ProductPage.route(produitId: state.produitId));
    } else {
      ColorScheme colorTheme = Theme.of(context).colorScheme;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              backgroundColor: colorTheme.errorContainer,
              content: Text(
                'Création produit échoué',
                style: TextStyle(color: colorTheme.onErrorContainer),
              )),
        );
    }
  }

  VoidCallback? _onPressed(BuildContext context, AddOrEditProductState state) {
    if (!state.isValid) {
      return null;
    }
    return () => context.read<AddOrEditProductBloc>().add(OnSumbitProduct());
  }
}

class _ImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<AddOrEditProductBloc, AddOrEditProductState>(
      builder: (context, state) {
        logger.d(state.img);
        logger.d(state.pathImg);
        return GestureDetector(
          onTap: () => onBrowseImagePressed(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.pathImg == null
                  ? Container(
                      width: size.height * .1,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  : Container(
                      width: size.height * .1,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(
                              state.img!)), //AssetImage(state.pathImg!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              Text(
                state.titleImg ?? "Browse image",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorTheme.onBackground,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onBrowseImagePressed(BuildContext context) async {
    var picked =
        await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
    if (picked != null) {
      PlatformFile file = picked.files.first;
      logger.t(file.name);
      String base64img = base64Encode(file.bytes!); // Uint8List
      if (context.mounted) {
        context.read<AddOrEditProductBloc>().add(
            OnAddImg(img: base64img, pathImg: file.path, titleImg: file.name));
      }
    }
  }
}
