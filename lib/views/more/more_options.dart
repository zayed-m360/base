import 'dart:ui';

import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {

  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 50, // Minimum width
            maxWidth: 50, // Maximum width
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 33, 55).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text(
                    "Option 1",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text(
                    "Option 2",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text(
                    "Option 3",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
