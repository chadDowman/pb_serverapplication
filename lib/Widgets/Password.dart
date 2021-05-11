import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/pallete.dart';


class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key key,
    @required this.icon,
    @required this.hint,

    this.inputAction,
  }) : super(key: key);
  final IconData icon;
  final String hint;

  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),

        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,

            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kbod,
          ),
          obscureText: true,
          style: kbod,
          textInputAction: inputAction,

        ),
      ),
    );
  }
}