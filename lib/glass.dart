import 'package:flutter/material.dart';
//import '../widget/detailscreen.dart';
import 'dart:ui';

class GlassCard extends StatelessWidget {
  const GlassCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              // color: ,
              color: Colors.black54,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20.0,
                sigmaY: 20.0,
              ),
              child: Container(
                  width: 360,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SemiKolan',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 40)),
                            Icon(
                              Icons.credit_card_sharp,
                              color: Colors.white.withOpacity(0.75),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TL Templates',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.75))),
                            Text('07/25',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.75))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('5555 5555 5555 4444',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.75))),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
