import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const PasswordFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        suffixIcon: widget.controller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close),
          onPressed: () => widget.controller.clear(),
        ),
      ),
      keyboardType: TextInputType.text,
      autofillHints: [AutofillHints.password],
      obscureText: true,

      validator: (password){
        if(password == null || password.isEmpty){
          return 'Ce champ est obligatoire';
        }
        return null;
      }
  );
}