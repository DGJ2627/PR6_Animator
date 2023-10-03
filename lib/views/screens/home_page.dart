import 'dart:math';
import 'package:animator_galaxy_planet/controlles/providers/loadjson_provider.dart';
import 'package:animator_galaxy_planet/controlles/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    loadJson();

    super.initState();
  }

  loadJson() async {
    Provider.of<LoadJsonProvider>(context, listen: false).loadJson();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (Provider.of<LoadJsonProvider>(context).planets.isNotEmpty)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/star.png"),
                ),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Solar System",
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Provider.of<ThemeAccessProvider>(context,
                                      listen: false)
                                  .Changetheme();
                            },
                            icon: (Provider.of<ThemeAccessProvider>(context)
                                        .themeAccessModel
                                        .isdark ==
                                    false)
                                ? const Icon(
                                    CupertinoIcons.moon_stars_fill,
                                    color: CupertinoColors.white,
                                  )
                                : const Icon(
                                    CupertinoIcons.sun_max_fill,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<LoadJsonProvider>(context).planets.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('Details_page',
                                arguments: Provider.of<LoadJsonProvider>(
                                        context,
                                        listen: false)
                                    .planets[i]);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                TweenAnimationBuilder(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: 2 * pi,
                                  ),
                                  duration: const Duration(seconds: 4),
                                  builder: (context, val, widget) {
                                    return Transform.rotate(
                                      angle: val,
                                      child: TweenAnimationBuilder(
                                        tween: Tween<double>(
                                          begin: 0.5,
                                          end: 1.1,
                                        ),
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 4),
                                        builder: (context, val, widget) {
                                          return Transform.scale(
                                            scale: val,
                                            child: widget,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 60,
                                          foregroundImage: AssetImage(
                                              Provider.of<LoadJsonProvider>(
                                                      context)
                                                  .planets[i]
                                                  .image),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 70,
                                ),
                                Expanded(
                                  child: Text(
                                    Provider.of<LoadJsonProvider>(context)
                                        .planets[i]
                                        .name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
