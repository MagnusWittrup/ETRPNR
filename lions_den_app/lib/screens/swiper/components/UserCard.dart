import 'package:flutter/material.dart';

import '../../../dummy_data.dart';

// ignore_for_file: prefer_const_constructors
//
final _shader = LinearGradient(
  // ignore_for_file: prefer_const_literals_to_create_immutables
  colors: [
    Color.fromRGBO(40, 175, 176, 1.0),
    Color.fromRGBO(166, 207, 173, 1.0),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class UserCard extends StatelessWidget {
  final User user;
  const UserCard(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 35),
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.7,
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(
                BorderSide(
                  color: Color(0xff252627),
                  width: 3,
                ),
              ),
              borderRadius: BorderRadius.circular(16.0),
              color: Color(0xffABD6CF),
              // Color.fromRGBO(
              //   171,
              //   214,
              //   207,
              //   1,
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      GradientTextWithBorder(
                        text: 'Interesse områder',
                      ),
                      Text(
                        user.seeking,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientTextWithBorder(
                        text: 'Erfarings områder',
                      ),
                      Text(
                        user.offering,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
        UserCardHeader(user),
      ],
    );
  }
}

class GradientTextWithBorder extends StatelessWidget {
  final String text;
  const GradientTextWithBorder({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Color(0xff252627)
              ..style = PaintingStyle.stroke,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => _shader,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class UserCardHeader extends StatelessWidget {
  final User user;
  const UserCardHeader(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 35,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(
                BorderSide(
                  color: Color(0xff252627),
                  width: 3,
                ),
              ),
              borderRadius: BorderRadius.circular(2.0),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(40, 175, 176, 1.0),
                  Color.fromRGBO(166, 207, 173, 1.0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 49,
                bottom: 5,
                top: 5,
                right: 10,
              ),
              child: SizedBox(
                width: size.width * 0.45,
                child: Text(
                  user.fullName,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff252627),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Color(0xff252627),
          radius: 39,
          child: CircleAvatar(
            radius: 36,
            backgroundColor: Color.fromRGBO(40, 175, 176, 1.0),
            foregroundImage: NetworkImage(user.profileImg),
          ),
        ),
      ],
    );
  }
}
