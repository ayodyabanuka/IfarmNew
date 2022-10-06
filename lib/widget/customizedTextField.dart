import 'package:flutter/material.dart';

class customizedTextField extends StatefulWidget {
  final TextEditingController? mycontroller;
  final String? lableText, empty;
  final bool? isPassword;
  customizedTextField(
      {Key? key,
      this.mycontroller,
      this.lableText,
      this.isPassword,
      this.empty})
      : super(key: key);

  @override
  State<customizedTextField> createState() => _customizedTextFieldState();
}

bool _obscureText = true;

class _customizedTextFieldState extends State<customizedTextField> {
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 255, 255, 255)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return widget.empty;
            }
          },
          obscureText: widget.isPassword == true && _obscureText == true,
          controller: widget.mycontroller,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          decoration: InputDecoration(
              suffixIcon: widget.isPassword!
                  ? GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              labelText: widget.lableText,
              border: InputBorder.none,
              labelStyle:
                  const TextStyle(color: Color.fromARGB(255, 88, 88, 88))),
        ),
      ),
    );
  }
}
