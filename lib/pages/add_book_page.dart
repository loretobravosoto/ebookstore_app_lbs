import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';
import 'package:ebookstore_app/model/book_model.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBookPage extends StatefulWidget {
  final BookModel? bookModel;
  final bool isEditMode;

  const AddBookPage({
    super.key,
    this.bookModel,
    this.isEditMode = false,
  });

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();
  final _rateController = TextEditingController();
  final _pagesController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _languageController = TextEditingController();
  final _descriptionController = TextEditingController();
  String actionText = "Save";

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.bookModel != null) {
      setState(() {
        actionText = "Update";
        _titleController.text = widget.bookModel!.title;
        _authorController.text = widget.bookModel!.author;
        _priceController.text = widget.bookModel!.price.toString();
        _rateController.text = widget.bookModel!.rate.toString();
        _pagesController.text = widget.bookModel!.pages.toString();
        _imageUrlController.text = widget.bookModel!.imageUrl;
        _languageController.text = widget.bookModel!.language;
        _descriptionController.text = widget.bookModel!.description;
      });
    }
  }

  void _saveBook(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final bookId = widget.isEditMode && widget.bookModel != null
          ? widget.bookModel!.id
          : '';

      final price = double.parse(_priceController.text);
      final rate = double.parse(_rateController.text);
      final pages = int.parse(_pagesController.text);

      context.read<EbookstoreBloc>().add(
            CreateNewBookEvent(
              id: bookId,
              title: _titleController.text,
              author: _authorController.text,
              price: price,
              rate: rate,
              pages: pages,
              imageUrl: _imageUrlController.text,
              language: _languageController.text,
              description: _descriptionController.text,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Book added to catalog"),
        duration: Duration(seconds: 2),
      ),
    );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors in the form")),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _rateController.dispose();
    _pagesController.dispose();
    _imageUrlController.dispose();
    _languageController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$actionText Book",
          style: TextStyle(
            fontSize: 16,
            color: AppColor.greyLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
       backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildStyledTextField(
                  controller: _titleController,
                  label: "Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    if (!RegExp(r"^[a-zA-Z\s`',\.\-\(\):;]+$")
                        .hasMatch(value)) {
                      return "Title can only contain letters";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _authorController,
                  label: "Author",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Author is required";
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Author must contain only letters";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _priceController,
                  label: "Price",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price is required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Price must be a valid number";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _rateController,
                  label: "Rate",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Rate is required";
                    }
                    final rate = double.tryParse(value);
                    if (rate == null || rate < 1 || rate > 5) {
                      return "Rate must be between 1 and 5";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _pagesController,
                  label: "Pages",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Pages is required";
                    }
                    if (int.tryParse(value) == null) {
                      return "Pages must be a valid number";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _imageUrlController,
                  label: "Image URL",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Image URL is required";
                    }
                    if (!value.startsWith("http")) {
                      return "Image URL must start with http";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _languageController,
                  label: "Language",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Language is required";
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Language must contain only letters";
                    }
                    return null;
                  },
                ),
                _buildStyledTextField(
                  controller: _descriptionController,
                  label: "Description",
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                    if (value.length > 500) {
                      return "Description cannot exceed 500 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _saveBook(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.orange,
                    foregroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("$actionText Book"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12, 
            color: AppColor.greyLight, 
          ),
          filled: true,
          fillColor: AppColor.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:  BorderSide(color: AppColor.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:  BorderSide(color: AppColor.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:  BorderSide(color:AppColor.green, width: 2),
          ),
        ),
      ),
    );
  }
}
