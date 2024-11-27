import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fasttrack_web/shared/shared.dart';
import 'all_icons.dart';

class FindIconUtility extends StatefulWidget {
  const FindIconUtility({super.key});

  @override
  State<FindIconUtility> createState() => _FindIconUtilityState();
}

class _FindIconUtilityState extends State<FindIconUtility> {
  var search = '';
  final shade = Colors.grey.withOpacity(0.2);

  Map<String, IconData> _filter(Map<String, IconData> data, String search) {
    var result = <String, IconData>{};
    for (var MapEntry(:key, :value) in data.entries) {
      if (key.toLowerCase().contains(search.toLowerCase())) {
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = [];
    List<IconData> values = [];
    if (search.isNotEmpty) {
      final res = _filter(allIcons, search);
      keys = res.keys.toList();
      values = res.values.toList();
    } else {
      keys = allIcons.keys.toList();
      values = allIcons.values.toList();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                    pinned: true,
                    title: Container(
                      child: TextField(
                        onChanged: (val) => setState(() => search = val),
                      ),
                    )),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Scaffold.of(context).showBottomSheet(
                                (_) => _IconName(
                                    data: values[index], name: keys[index]),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: shade,
                              child: HugeIcon(
                                  icon: values[index],
                                  color: Colors.black,
                                  size: 30),
                            ),
                          );
                        });
                      },
                      childCount: values.length,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _IconName extends StatelessWidget {
  const _IconName({required this.data, required this.name});
  final IconData data;
  final String name;

  @override
  Widget build(BuildContext context) {
    final font = TextStyle(fontSize: 16);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: context.xsize.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(blurRadius: 18, color: Color(0x45555555)),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: name));
                },
                leading: HugeIcon(
                  icon: data,
                  color: Colors.black,
                  size: 25,
                ),
                title: Text(name, style: font),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
