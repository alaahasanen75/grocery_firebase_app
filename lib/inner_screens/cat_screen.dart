import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geogrcy_firebase/models/products_model.dart';
import 'package:geogrcy_firebase/provider/products_provider.dart';
import 'package:geogrcy_firebase/widgets/empty_products_widget.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProviders = ref.watch(product);

    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productProviders.findByCategory(catName);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productByCat.isEmpty
          ? const EmptyProdWidget(
              text: 'No products belong to this category',
            )
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (valuee) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        hintText: "What's in your mind",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            _searchTextController!.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: _searchTextFocusNode.hasFocus
                                ? Colors.red
                                : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: size.width / (size.height * 0.59),
                  children: List.generate(productByCat.length, (index) {
                    return FeedsWidget(productModel: productByCat[index]);
                  }),
                ),
              ]),
            ),
    );
  }
}
