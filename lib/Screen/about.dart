import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        elevation: 0,
      ),
      body: AboutView(),
    );
  }
}

class AboutView extends StatelessWidget {
  AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: Column(
          children: [
            Text("\n"),
            Text(
                """Yesu Ahuriire Catholic Covenant Community, is a Community of Catholic faithful born within the Catholic Charismatic Renewal in the Archdiocese of Mbarara under the authority of its Local Ordinary, and committed to New Evangelization and salvation of humanity.

Our Mission
Called to embrace, live and proclaim the truth that ‘Jesus is alive’ (‘Yesu Ahuriire’) both in the Church and the World.

Our Vision
To be at the forefront in the Mission of New Evangelization using effective, creative, and modern methods of education and communication for the local and the Universal Church.
Read more about us"""),
          ],
        ),
      ),
    );
  }
}
