import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  const customButton({
    super.key,
    required this.height,
    required this.width, 
    required this.onTap,
  });

  final double height;
  final double width;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: height * 0.05,
      width: width * 1,
      child: ElevatedButton(
        onPressed: onTap,
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
