import 'package:bible_app/constant/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(this.onTap);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'OOPS SOMETING WENT WRONG',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColors.gray2,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            InkWell(
              onTap: () => onTap(),
              child: const Text(
                'PLEASE TRY AGAIN!',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: CustomColors.gray2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
