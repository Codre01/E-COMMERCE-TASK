import 'package:flutter/material.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/src/products/controllers/product_notifier.dart';
import 'package:provider/provider.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, textAlign: TextAlign.justify,
        maxLines: context.watch<ProductNotifier>().textExpanded ? 3 : 100,
        style: appStyle(13, Kolors.kGray, FontWeight.normal),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                context.read<ProductNotifier>().setTextExpanded();
              },
              child: Text(
                !context.watch<ProductNotifier>().textExpanded ? "Read More" : "Show Less",
                style: appStyle(11, Kolors.kPrimaryLight, FontWeight.normal),
              ),
            )
          ],
          )
      ],
    );
  }
}