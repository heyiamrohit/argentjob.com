import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/black_list.dart';

class BlackListScreen extends StatelessWidget {
  static const routeName = '/BlackListScreen';
  @override
  Widget build(BuildContext context) {
    var blacklist = Provider.of<BlackListProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blacklist'),
        ),
        body: FutureBuilder(
          future: blacklist.fetchblacklist(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: blacklist.black_list.length,
                  itemBuilder: (ctx, index) => BlackList_Widget(
                      (index + 1).toString(),
                      // blacklist.blacklist_list[index].date,
                      blacklist.black_list[index].id,
                      blacklist.black_list[index].discription,
                      blacklist.black_list[index].fine_amount));
            }
            return Container();
          },
        ));
  }
}

class BlackList_Widget extends StatelessWidget {
  // const BlackList_Widget({ Key? key }) : super(key: key);
  String index;
  String id;
  String discription;
  String fine_amount;

  BlackList_Widget(this.index, this.id, this.discription, this.fine_amount);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      child: Card(
        elevation: 1,
        child: ExpansionTile(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 10, bottom: 10),
              child: Text(
                discription,
              ),
            ),
          ],
          title: ListTile(
            leading: CircleAvatar(child: Text(index)),
            title: Text(
              id,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('fine amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).errorColor,
                      )),
                  Text(
                    ('\ $fine_amount'),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),

            // selected: true,
          ),
        ),
      ),
    );
  }
}
