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
          logger.t(state.isValid, error: 'e');
          return Container(
            height: size.height - 100, //TODO better scrollable form
            padding: defaultPagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _ImagePicker(),
                FormTextField(
                  labelText: 'Product Name',
                  hintText: 'Enter product name',
                  errorText: "",
                  onChanged: (name) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(name: name)),
                ),
                FormTextField(
                  labelText: 'Category',
                  hintText: 'Enter product category',
                  errorText: "",
                  onChanged: (category) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(category: category)),
                ),
                FormTextField(
                  labelText: 'Dimension',
                  hintText: 'Enter product dimension',
                  errorText: "",
                  onChanged: (dimension) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(dimension: dimension)),
                ),
                FormTextField(
                  labelText: 'Weight',
                  hintText: 'Enter product weight',
                  errorText: "",
                  onChanged: (weight) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(weight: weight)),
                ),
                FormTextField(
                  labelText: 'Buying Price',
                  hintText: 'Enter product buying price',
                  errorText: "",
                  onChanged: (price) => context
                      .read<AddOrEditProductBloc>()
                      .add(OnInformationChangeProduct(price: price)),
                ),
                SizedBox(height: size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: !state.status.isInProgress,
                      child: PrimaryButton(
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

    return GestureDetector(
      onTap: onBrowseImagePressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.height * .1,
            height: size.height * .1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Browse image",
            style: textTheme.bodyMedium?.copyWith(
              color: colorTheme.onBackground,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  void onBrowseImagePressed() async {
    var picked = await FilePicker.platform.pickFiles();
    //TODO : file picker
  }
}
