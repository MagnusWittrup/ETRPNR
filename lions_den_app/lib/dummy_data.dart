class DummyData {
  List<User> get dummyUsers => List.generate(
      fNames.length,
      (index) => User(
            fName: fNames[index],
            lName: lNames[index],
            age: age[index],
            hasAcceptedMe: accepted[index],
            profileImg:
                'https://i.pravatar.cc/150?u=${fNames[index]}${lNames[index]}',
            offering: offering[index],
            seeking: seeking[index],
          ));

  final fNames = [
    'Noble',
    'Jalen',
    'Stephan',
    'Selena',
    'Aglae',
    'Jacklyn',
    'Lucie',
    'Bonita',
    'Polly',
    'Ilene'
  ];
  final lNames = [
    'Schamberger',
    'Morar',
    'Keeling',
    'Howell',
    'Block',
    'Yundt',
    'Will',
    'Grady',
    'Ferry',
    'Jaskolski',
  ];
  final age = [
    42,
    68,
    28,
    99,
    34,
    75,
    61,
    83,
    27,
    20,
  ];
  final accepted = [
    false,
    false,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    true,
  ];
  final profileImg = [
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
    'http://lorempixel.com/640/480/people',
  ];
  final seeking = [
    'Implemented human-resource challenge',
    'Monitored client-server adapter',
    'Intuitive reciprocal encoding',
    'Integrated 4th generation groupware',
    'Optional national paradigm',
    'Up-sized contextually-based attitude',
    'Persistent regional monitoring',
    'Proactive radical encoding',
    'Re-engineered uniform moratorium',
    'Vision-oriented zero tolerance flexibility',
  ];
  final offering = [
    'User-friendly scalable collaboration',
    'Re-contextualized dedicated toolset',
    'Versatile well-modulated array',
    'Integrated logistical analyzer',
    'Pre-emptive context-sensitive hierarchy',
    'Configurable upward-trending flexibility',
    'Progressive eco-centric pricing structure',
    'Multi-lateral bifurcated success',
    'Team-oriented multi-tasking throughput',
    'Reverse-engineered uniform open architecture',
  ];
}

class User {
  final String fName;
  final String lName;
  final int age;
  final String profileImg;
  final String offering;
  final String seeking;
  bool hasAcceptedMe;
  bool isAcceptedByMe;
  User({
    this.fName,
    this.lName,
    this.age,
    this.hasAcceptedMe,
    this.profileImg,
    this.isAcceptedByMe,
    this.offering,
    this.seeking,
  });

  String get fullName => '$fName $lName';

  @override
  String toString() {
    return '''
User(
  fName: $fName,
  lName: $lName,
  age: $age,
  hasAcceptedMe: $hasAcceptedMe,
  isAcceptedByMe: $isAcceptedByMe,
  profileImg: $profileImg,
)''';
  }
}
