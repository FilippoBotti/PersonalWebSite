import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: AspectRatio(
        aspectRatio: 0.3,
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Form(
            key: _formKey,
            child: Center(
              child: Card(
                color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contattami",
                          style: Responsive.isMobile(context)
                              ? Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white)
                              : Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: defaultPadding / 2,
                        ),
                        Text(
                          "Hai una grande idea, ma non sai come svilupparla?\nDescrivimela e parliamone!",
                          style: Responsive.isMobile(context)
                              ? Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: bodyTextColor)
                              : Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: bodyTextColor),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hoverColor: bgColor,
                              fillColor: bgColor,
                              filled: true,
                              hintText: "Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: bgColor),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Please enter some text.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hoverColor: bgColor,
                              fillColor: bgColor,
                              filled: true,
                              hintText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: bgColor),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Please enter some text.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hoverColor: bgColor,
                              fillColor: bgColor,
                              filled: true,
                              hintText: "Object",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: bgColor),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Please enter some text.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Responsive(
                          mobile: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            child: TextFormField(
                              maxLines: (Responsive.deviceHeight(context) < 720)
                                  ? 3
                                  : 5,
                              decoration: InputDecoration(
                                hoverColor: bgColor,
                                fillColor: bgColor,
                                filled: true,
                                hintText: "Your awesome idea...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: bgColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' Please enter some text.';
                                }
                                return null;
                              },
                            ),
                          ),
                          tablet: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            child: TextFormField(
                              maxLines: (Responsive.deviceHeight(context) < 720)
                                  ? 3
                                  : 10,
                              decoration: InputDecoration(
                                hoverColor: bgColor,
                                fillColor: bgColor,
                                filled: true,
                                hintText: "Your awesome idea...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: bgColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' Please enter some text.';
                                }
                                return null;
                              },
                            ),
                          ),
                          desktop: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            child: TextFormField(
                              maxLines: (Responsive.deviceHeight(context) < 720)
                                  ? 3
                                  : 10,
                              decoration: InputDecoration(
                                hoverColor: bgColor,
                                fillColor: bgColor,
                                filled: true,
                                hintText: "Your awesome idea...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: bgColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' Please enter some text.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding),
                                backgroundColor: primaryColor,
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: darkColor),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          padding: const EdgeInsets.all(defaultPadding),
          //color: secondaryColor,
        ),
      ),
    );
  }
}
