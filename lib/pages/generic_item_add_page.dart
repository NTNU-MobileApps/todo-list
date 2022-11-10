import 'package:flutter/material.dart';
import '../widgets/form_page.dart';
import '../widgets/form_submit_button.dart';
import '../widgets/text_input_field.dart';
import '../widgets/vertical_padding.dart';

/// An page for adding or editing an item, where name is specified
/// Calls the onSubmit provided by the parent
class GenericItemAddEditPage extends StatefulWidget {
  final List<String> existingNames;
  final String inputElementHint;
  final void Function(String name, BuildContext context) onSubmit;
  final String formTitle;
  final String? existingName;

  /// existingNames: a list of existing object names. When the input field
  ///   contains one of these names, disable the submission button
  /// inputElementHint: The hint to show for the input element
  /// formTitle: The title to show for the form
  /// existingName: if this is set, the form is for editing and existing item.
  ///   Otherwise - for adding a new item.
  const GenericItemAddEditPage(
      {Key? key,
      required this.existingNames,
      required this.inputElementHint,
      required this.onSubmit,
      required this.formTitle,
      this.existingName})
      : super(key: key);

  @override
  State<GenericItemAddEditPage> createState() => _GenericItemAddEditPageState();
}

class _GenericItemAddEditPageState extends State<GenericItemAddEditPage> {
  TextEditingController? nameController;

  String get name => nameController != null ? nameController!.text : "";

  bool get isEditing => widget.existingName != null;

  bool isSubmissionDisabled = true;

  /// Check if name is non-empty and not used for any other item
  bool _isNameValid(String name) =>
      name.isNotEmpty && !widget.existingNames.contains(name);

  @override
  Widget build(BuildContext context) {
    nameController ??= TextEditingController(text: widget.existingName);
    return FormPage(
      inputs: [
        TextInputField(
          label: widget.inputElementHint,
          autofocus: true,
          controller: nameController,
          onChanged: (newName) => _validateForm(newName),
        ),
        const MediumVerticalPadding(),
        FormSubmitButton(
          title: isEditing ? "Update" : "Add",
          onPressed: () => widget.onSubmit(name, context),
          disabled: isSubmissionDisabled,
          showSpinner: false,
        )
      ],
      title: widget.formTitle,
    );
  }

  void _validateForm(String newName) {
    setState(() {
      isSubmissionDisabled = !_isNameValid(newName);
    });
  }
}
