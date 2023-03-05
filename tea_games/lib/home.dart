import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget body() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Um jogo')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }
}
