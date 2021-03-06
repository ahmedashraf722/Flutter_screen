import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marathon/chats/chat1/message_provider.dart';
import 'package:marathon/chats/chat1/tabs/groups.dart';
import 'package:marathon/chats/chat1/tabs/history.dart';
import 'package:marathon/chats/chat1/tabs/index.dart';
import 'package:marathon/chats/chat1/tabs/online.dart';
import 'package:marathon/chats/chat2/chat_screens.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      MessageProvider.getChats(),
                      "Ahmed Ashraf",
                    )));
      },
      child: Theme(
        data: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.grey[100],
            ),
            CustomPaint(
              painter: ChatBackGround(),
              size: Size(double.infinity, double.infinity),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "MESSAGES",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                centerTitle: true,
                bottom: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Color(0xfff76aa4),
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(),
                  tabs: [
                    Tab(
                      text: "Index",
                    ),
                    Tab(
                      text: "Groups",
                    ),
                    Tab(
                      text: "Online50",
                    ),
                    Tab(
                      text: "History",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  ConversionList(),
                  GroupsList(),
                  OnlineList(),
                  HistoryList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBackGround extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height * 0.65);
    Gradient gradient = LinearGradient(
      colors: [
        Color(0xFFef1385),
        Color(0xFFf12280),
        Color(0XFFf63d76),
        Color(0xFFf84f70),
      ],
      stops: [
        0.2,
        0.4,
        0.6,
        0.8,
      ],
    );
    Paint paint = Paint();
    Path path = Path();
    paint.shader = gradient.createShader(rect);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.65, 0, size.height * 0.3);
    path.lineTo(0, size.height * 0.3);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
