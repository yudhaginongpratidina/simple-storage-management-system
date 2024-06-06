import 'package:flutter/material.dart';

class HeaderDetailMenu extends StatefulWidget {
  final String menuTitle;
  final Icon icon;
  final bool backToHome;
  final Function()? onPressed;

  const HeaderDetailMenu({
    super.key,
    required this.menuTitle,
    required this.icon,
    required this.backToHome,
    this.onPressed,
  });

  @override
  State<HeaderDetailMenu> createState() => _HeaderDetailMenuState();
}

class _HeaderDetailMenuState extends State<HeaderDetailMenu> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(),
      height: height * 0.30,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon.icon, size: 100, color: Colors.white),
          Text(
            widget.menuTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.onPressed != null)
                TextButton(
                  onPressed: widget.onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(widget.icon.icon),
                      Text('Add ${widget.menuTitle}'),
                    ],
                  ),
                ),
              const SizedBox(width: 20),
              if (widget.backToHome)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.home), Text("Back to Home")],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
