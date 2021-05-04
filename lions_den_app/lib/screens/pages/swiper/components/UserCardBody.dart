import 'package:flutter/material.dart';
import 'package:lions_den_app/screens/pages/swiper/components/UserCardHeader.dart';
import 'package:lions_den_app/theme/colors.dart';

import '../../../../dummy_data.dart';
import 'BorderedGradientTetx.dart';

class CardBody extends StatelessWidget {
  const CardBody({
    Key key,
    @required this.size,
    @required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 35,
        bottom: 24,
      ),
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.7,
        decoration: BoxDecoration(
            // border: const Border.fromBorderSide(
            //   BorderSide(
            //     color: gunMetal,
            //     width: 3,
            //   ),
            // ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: gunMetal,
                offset: Offset(6, 6),
              )
            ],
            color: Colors.white
            // color: const Color(0xffABD6CF),
            ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserCardHeader(user),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const GradientTextWithBorder(
                    text: 'Interesse områder',
                    fontSize: 20,
                  ),
                  Text(
                    user.seeking,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientTextWithBorder(
                    fontSize: 20,
                    text: 'Erfarings områder',
                  ),
                  Text(
                    user.offering,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientTextWithBorder(
                    fontSize: 20,
                    text: 'Biografi',
                  ),
                  Text(
                    user.bio,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCardBody extends StatelessWidget {
  const EmptyCardBody({
    Key key,
    @required this.size,
    this.color = Colors.white,
  }) : super(key: key);

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 35,
        bottom: 24,
      ),
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: gunMetal,
              offset: Offset(6, 6),
            )
          ],
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
