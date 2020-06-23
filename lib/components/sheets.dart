import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/components/buttons.dart';

void showSetNameSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return AnimatedPadding(
        padding: EdgeInsets.all(24),
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Set Name",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w900,
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              cursorColor: Colors.yellow[400],
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow[400], width: 3),
                ),
                hintText: "Type name hear",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(height: 24),
            NextButton(
              "Add",
              () {},
            ),
          ],
        ),
      );
    },
  );
}
