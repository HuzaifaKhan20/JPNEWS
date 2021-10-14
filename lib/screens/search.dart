import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpnews/categories/topstories.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: Colors.lightBlue[400],
            title: Center(child: Text("Jawan Pakistan News")),
          )),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0),
                        ),
                        primary: Colors.lightBlue[400],
                        padding: EdgeInsets.fromLTRB(100, 20, 100, 20)),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                    child: Text(
                      "Search",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final news = [
    "AMC theaters will accept cryptocurrencies beyond Bitcoin",
    "Twitter will let users send and receive Bitcoin tips",
    "Hitting the Books: How Bitcoin is somehow worth more than the paper it's printed on",
    "Bitcoin protests in El Salvador against cryptocurrency as legal tender",
    "Twitter will allow people to tip their favorite content creators with bitcoin",
    "Bitcoin Bros and Nuclear Bros Have Found Common Cause",
    "Bitcoin drops below 43,000 on El Salvador's first day using it",
    "Tesla CEO Elon Musk says U.S. government should avoid regulating crypto",
    "Old coal plant is now mining bitcoin for a utility company",
    "JPMorgan CEO Says Bitcoin Has No Intrinsic Value After Claiming That Its Price Could Rise 10X",
    "As Debt Ceiling Vote Looms, Democrats Reconsider Filibuster - The New York Times",
    "Boris Johnson Pledges Transformed Economy for U.K. - The New York Times",
    "Get Up reacts to the Cowboys releasing Jaylon Smith - ESPN",
    "L.A. poised to enact one of nation’s strictest COVID vaccine mandates - KTLA Los Angeles",
    "Nintendo Switch - OLED Model Review - IGN",
    "Start 'Em, Sit 'Em Fantasy Football Week 5: Running Backs - Fades, Sleepers, Matchups, DFS Bargains - Sports Illustrated",
    "Michigan, Purdue headline official unofficial Big Ten basketball media poll, plus my picks for 2021-22 - The Athletic",
    "Adidas is making Xbox sneakers - The Verge",
    "Nintendo Switch - OLED Model Review - IGN",
  ];

  final recent = [
    "AMC theaters will accept cryptocurrencies beyond Bitcoin",
    "Twitter will let users send and receive Bitcoin tips",
    "Hitting the Books: How Bitcoin is somehow worth more than the paper it's printed on",
    "Bitcoin protests in El Salvador against cryptocurrency as legal tender",
    "Twitter will allow people to tip their favorite content creators with bitcoin",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggest = query.isEmpty
        ? recent
        : news.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (contex, index) => ListTile(
        onTap: () {
          showResults(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Topstories()));
        },
        leading: Icon(Icons.search),
        title: RichText(
          text: TextSpan(
              text: suggest[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggest[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggest.length,
    );
  }
}
