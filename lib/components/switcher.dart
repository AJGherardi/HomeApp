import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:home/components/buttons.dart';

class PageSwitcher extends StatefulWidget {
  PageSwitcher(this.children, this.doneButton);
  final List<Widget> children;
  final Widget doneButton;

  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: widget.children[_currentPage],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 65,
        decoration: BoxDecoration(
          border: Border(
            top: (Theme.of(context).brightness != Brightness.dark)
                ? BorderSide(width: 2)
                : BorderSide.none,
          ),
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: [
            // Back Button
            AnimatedOpacity(
              opacity: (_currentPage != 0) ? 1.0 : 0.0,
              duration: Duration(milliseconds: 150),
              child: Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: (_currentPage != 0)
                      ? () {
                          setState(() {
                            _currentPage--;
                          });
                        }
                      : () {},
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Text(
                      "Back",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.children.length; i++)
                    if (i == _currentPage) Dot(true) else Dot(false)
                ],
              ),
            ),
            // If not last page show next button
            (_currentPage != widget.children.length - 1)
                ? Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "Next",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  )
                :
                // If last page show done button
                widget.doneButton
          ],
        ),
      ),
    );
  }
}
