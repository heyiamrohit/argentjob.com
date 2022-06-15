import 'package:flutter/material.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/screens/old_ui/homescreen.dart';
import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

class ContactPage extends StatelessWidget {
  final emailController = TextEditingController();
  final queryController = TextEditingController();
  final String loremIpsem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla sollicitudin massa, id maximus dui sollicitudin ut. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce diam arcu, tempus at iaculis nec, venenatis suscipit dui. Etiam lobortis, tellus in congue vestibulum, augue leo semper enim, quis porttitor velit tellus sit amet arcu. Vestibulum vestibulum sapien quis ante laoreet vestibulum. Praesent id euismod odio, nec feugiat orci. Quisque cursus justo quis lacus venenatis pellentesque. Cras nisl massa, volutpat sit amet mauris at, ultrices imperdiet quam. Duis volutpat lacus turpis, quis mattis risus rutrum a.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Tatkal Jobs'),
                Text(loremIpsem),
                
              ]),
        ),
      ),
    );
  }
}
