import 'package:flutter/foundation.dart';

class DummyData {
  List<User> get dummyUsers => List.generate(
      fNames.length,
      (index) => User(
            threadId: index,
            fName: fNames[index],
            lName: lNames[index],
            age: age[index],
            hasAcceptedMe: hasAcceptedMe[index],
            isAcceptedByMe: isAcceptedByMe[index],
            profileImg:
                'https://i.pravatar.cc/150?u=${fNames[index]}${lNames[index]}',
            bio: biographies[index],
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
  final hasAcceptedMe = [
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

  final isAcceptedByMe = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
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
  final biographies = [
    'Evil entrepreneur. Passionate tv expert. Infuriatingly humble social media fanatic. Food maven.',
    'Analyst. Hipster-friendly introvert. Devoted beer scholar. Internet expert. Music aficionado.',
    'Coffee junkie. Writer. Avid travel advocate. Wannabe introvert. Reader. Bacon nerd. Beer maven.',
    'Student. Music advocate. Prone to fits of apathy. Introvert. Tv specialist. Zombie nerd.',
    'Coffee trailblazer. Typical reader. Certified bacon fanatic. Pop culture buff. Total introvert.',
    'General twitter evangelist. Gamer. Award-winning alcohol specialist. Hardcore social media maven.',
    'Thinker. Student. Zombie buff. Analyst. Friendly communicator. Introvert. Subtly charming bacon practitioner. Coffee fan. Extreme foodaholic. Explorer.',
    'Student. Evil bacon fanatic. Music maven. Incurable beer aficionado. Web trailblazer. Thinker. Tv fan.',
    'Entrepreneur. Extreme explorer. Food trailblazer. Friendly student. Infuriatingly humble music guru. Bacon scholar. Professional gamer.',
    'Twitteraholic. Reader. Entrepreneur. Total introvert. Social media maven. Prone to fits of apathy.',
  ];

  List<User> get initAcceptedUsers => dummyUsers
      .where((element) => element.isAcceptedByMe && element.hasAcceptedMe)
      .toList();

  List<MessageThread> get dummyThreads {
    return List.generate(
        dummyUsers.length, (index) => dummyThread(dummyUsers[index], index));
  }
}

MessageThread dummyThread(User user, int index) {
  return MessageThread(
      threadID: index,
      sender: user,
      userActive: true,
      messages: dummyMessages(user));
}

List<Message> dummyMessages(User sender) => [
      Message(
        sender: sender.fullName,
        text: 'Hej med dig',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 8),
        ),
      ),
      Message(
        sender: sender.fullName,
        text: 'Jeg er en ny udvilker',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 7),
        ),
      ),
      Message(
        sender: sender.fullName,
        text: 'Min email er ${sender.fName}@${sender.lName}.com',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 5),
        ),
      ),
    ];

class User {
  final int threadId;
  final String fName;
  final String lName;
  final int age;
  final String profileImg;
  final String offering;
  final String seeking;
  final String bio;
  final bool hasAcceptedMe;
  bool isAcceptedByMe;
  User({
    this.threadId,
    this.fName,
    this.lName,
    this.age,
    this.hasAcceptedMe = false,
    this.profileImg,
    this.isAcceptedByMe = false,
    this.offering,
    this.seeking,
    this.bio,
  });

  void accept() => isAcceptedByMe = true;

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

class MessageThread {
  final int threadID;
  final User sender;
  final bool userActive;
  final List<Message> messages;
  const MessageThread({
    @required this.threadID,
    @required this.sender,
    @required this.messages,
    @required this.userActive,
  });
  Message get lastMessage => messages.last;

  @override
  String toString() {
    return '''
MessageThread(
  threadID: $threadID
  sender: $sender
  messages: messages
  userActive: $userActive
)''';
  }
}

class Message {
  final DateTime timestamp;
  final String sender;
  final String text;

  const Message({
    @required this.sender,
    @required this.text,
    @required this.timestamp,
  });

  @override
  String toString() {
    return '''
MessageThread(
  sender: $sender
  text: $text
  timestamp: $timestamp
)''';
  }
}
