import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatwith/api_model/user.dart';
import 'package:chatwith/api_service/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    users = (await ApiServices().getData(context));
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/image/download3-removebg-preview.png",
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                ),
                const Text(
                  "ChatWith",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: _isLoading,
            replacement: const Center(child: CircularProgressIndicator()),
            child: users.isEmpty
                ? showError("NOT FOUND")
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTileOfData(
                          image: users[index].avatar,
                          title: users[index].firstName,
                          last: users[index].lastName,
                          id: users[index].id.toString(),
                          email1: users[index].email,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 0,
                        );
                      },
                      itemCount: users.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget showError(message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ListTileOfData extends StatelessWidget {
  const ListTileOfData(
      {Key? key,
      required this.title,
      required this.id,
      required this.email1,
      required this.image,
      required this.last})
      : super(key: key);
  final String title;
  final String id;
  final String email1;
  final String image;
  final String last;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  30,
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                ),
              ),
              const HorizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        last,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Text(
                    email1,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 15,
            child: Text(
              id,
            ),
          )
        ],
      ),
    );
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
    );
  }
}
