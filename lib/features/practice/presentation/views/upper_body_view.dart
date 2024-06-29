import 'package:flutter/material.dart';
import 'package:jefit/core/styles/app_text_styles.dart';

class UpperBodyView extends StatelessWidget {
  const UpperBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upper Body',
          style: AppTextStyles.designe20MediumPrimary(context),
        ),
      ),
      body:const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upper Body',
            ),
          ],
        ),
      ),
    );
  }
}
