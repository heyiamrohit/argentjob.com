// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tatkal_jobs_app/providers/notification.dart';

// ///import '../widget/detailscreen.dart';

// class NotificatonScreen extends StatefulWidget {
//   static const routeName = '/NotificatonScreen';

//   @override
//   _NotificatonScreenState createState() => _NotificatonScreenState();
// }

// class _NotificatonScreenState extends State<NotificatonScreen> {
//   bool isloading = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     Provider.of<Notification_Provider>(context,listen: false)
//         .fetchNotifications();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // setState(() {

//     // });
//                isloading= Provider.of<Notification_Provider>(context).loading;
//             final data = Provider.of<Notification_Provider>(context)
//         .notifications_list;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: Provider.of<Notification_Provider>(context).loading
//           ?Center(child: CircularProgressIndicator()): ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (ctx, index) => Notification_Widget(
//               (index + 1).toString(),
//               data[index].date,
//               data[index].title,
//               data[index].discription)),
//     );
//   }
// }

// class Notification_Widget extends StatelessWidget {
//   String index;
//   String title;
//   String date;
//   String subtitle;
//   Notification_Widget(this.index, this.date, this.title, this.subtitle);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1,
//       child: ListTile(
//         leading: CircleAvatar(
//             child: Text(
//           index,
//         )),
//         title: Text(
//           title,
//           style: TextStyle(
//               fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
//           // textScaleFactor: 1.5,
//         ),
//         trailing: Text(
//           // DateFormat('yyyy-MM-dd').format(date.),
//           date,
//           style: TextStyle(color: Colors.black),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
//         ),
//         selected: true,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/notification.dart';

///import '../widget/detailscreen.dart';
class NotificatonScreen extends StatefulWidget {
  static const routeName = '/NotificatonScreen';

  @override
  _NotificatonScreenState createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  @override
  void initState() {
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notifications = Provider.of<NotificationProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: FutureBuilder(
          future: notifications.fetchNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: notifications.notifications_list.length,
                  itemBuilder: (ctx, index) => Notification_Widget(
                      (index + 1).toString(),
                      notifications.notifications_list[index].date,
                      notifications.notifications_list[index].title,
                      notifications.notifications_list[index].subtitle,
                      notifications.notifications_list[index].discription));
            }
            return Container();
          },
        ));
  }
}

class Notification_Widget extends StatelessWidget {
  String index;
  String title;
  String date;
  String subtitle;
  String discription;
  Notification_Widget(this.index, this.date, this.title, this.subtitle,this.discription);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ExpansionTile(
        children: [Padding(
          padding: const EdgeInsets.only(left: 50,right: 10,bottom: 10),
          child: Text(discription),
        )],
        title: ListTile(
          leading: CircleAvatar(
              child: Text(
            index,
          )),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            // textScaleFactor: 1.5,
          ),
          trailing: Text(
            // DateFormat('yyyy-MM-dd').format(date.),
            date,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            subtitle,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          selected: true,
        ),
      ),
    );
  }
}
