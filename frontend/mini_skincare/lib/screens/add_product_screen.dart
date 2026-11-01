import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const List<String> _categories = [
    'Cleanser',
    'Toner',
    'Serum',
    'Sunscreen',
    'Moisturizer',
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  String? Function(String?) _requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) return message;
      return null;
    };
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a price';
    }
    if (double.tryParse(value.trim()) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      Get.snackbar(
        'Category Required',
        'Please select a category for the product',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.find<ProductController>().addProduct(
      name: _nameController.text.trim(),
      category: _selectedCategory!,
      price: double.parse(_priceController.text.trim()),
      description: _descriptionController.text.trim(),
    );

    Get.back(); // Return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Add New Product'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Product Name'),
                TextFormField(
                  controller: _nameController,
                  decoration:
                  _inputDecoration(hintText: 'e.g., Hydrating Facial Mist'),
                  validator: _requiredValidator('Please enter a product name'),
                ),
                const SizedBox(height: 20),
                const _FieldLabel('Category'),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: const Text('Select Category'),
                  decoration: _inputDecoration(),
                  items: [
                    for (final category in _categories)
                      DropdownMenuItem(value: category, child: Text(category)),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedCategory = value);
                  },
                ),
                const SizedBox(height: 20),
                const _FieldLabel('Price (\$)'),
                TextFormField(
                  controller: _priceController,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: _inputDecoration(hintText: 'e.g., 19.99'),
                  validator: _validatePrice,
                ),
                const SizedBox(height: 20),
                const _FieldLabel('Description'),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: _inputDecoration(
                    hintText: 'Enter detailed product description...',
                  ),
                  validator: _requiredValidator('Please enter a description'),
                ),
                const SizedBox(height: 32),
                _SaveButton(onPressed: _submitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bold label shown above a form field, with its spacing below.
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Save Product',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}