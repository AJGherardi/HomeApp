import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/components/title.dart';
import 'package:home/services/store.dart';
import 'package:provider/provider.dart';

class ActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _urlController = TextEditingController(
        text:
            "wss://" + Provider.of<ClientModel>(context).host + ":443/graphql");
    final TextEditingController _webKeyController =
        TextEditingController(text: Provider.of<ClientModel>(context).webKey);

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(child: TitleText(text: "Automate with\n Node Red")),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                "assets/node-red.svg",
                color: Theme.of(context).primaryColor,
                width: 300,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                15,
                30,
                15,
                15,
              ),
              child: Text(
                "Automate things in your smart home using node red.\n \n To get started just add these credentials to a config node.",
                style: Theme.of(context).textTheme.bodyText1,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                15,
                15,
                15,
                15,
              ),
              child: TextField(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _urlController.text));
                },
                controller: _urlController,
                readOnly: true,
                style: Theme.of(context).textTheme.caption,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                    ),
                    labelText: "URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    suffixIcon: Icon(Icons.copy)),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                15,
                0,
                15,
                15,
              ),
              child: TextField(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _urlController.text));
                },
                controller: _webKeyController,
                readOnly: true,
                style: Theme.of(context).textTheme.caption,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                    ),
                    labelText: "WebKey",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    suffixIcon: Icon(Icons.copy)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
