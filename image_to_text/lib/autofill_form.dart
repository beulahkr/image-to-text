import 'package:flutter/material.dart';

class AutofillForm extends StatefulWidget {
  final List<String> suggestions;
  const AutofillForm({super.key, required this.suggestions});

  @override
  State<AutofillForm> createState() => _AutofillFormState();
}

class _AutofillFormState extends State<AutofillForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _gasTypeController = TextEditingController();
  final TextEditingController _gasLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Name field
            Row(
              children: [
                const Text('Name: '),
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return widget.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _nameController.text = selection;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            // Model field
            Row(
              children: [
                const Text('Model: '),
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return widget.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _modelController.text = selection;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            // Serial Number field
            Row(
              children: [
                const Text('Serial Number: '),
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return widget.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _serialNumberController.text = selection;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            // Gas Type field
            Row(
              children: [
                const Text('Gas Type: '),
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return widget.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _gasTypeController.text = selection;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            // Gas Level field
            Row(
              children: [
                const Text('Gas Level: '),
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return widget.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _gasLevelController.text = selection;
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing Data'),
                      ),
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
