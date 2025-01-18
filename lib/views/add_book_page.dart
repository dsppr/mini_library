import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../viewmodels/book_viewmodel.dart';

class AddBookPage extends StatefulWidget {
  final Book? book;

  const AddBookPage({Key? key, this.book}) : super(key: key);

  @override
  AddBookPageState createState() => AddBookPageState();
}

class AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController();
  final _statusController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _categoryController.text = widget.book!.category;
      _statusController.text = widget.book!.status;
      _descriptionController.text = widget.book!.description;
    } else {
      _statusController.text = 'Available';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BookViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.book == null ? 'Add New Book' : 'Edit Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter an author'
                    : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newBook = Book(
                      id: widget.book?.id,
                      title: _titleController.text,
                      author: _authorController.text,
                      category: _categoryController.text,
                      status: _statusController.text,
                      description: _descriptionController.text,
                    );
                    if (widget.book == null) {
                      bookViewModel.addBook(newBook);
                    } else {
                      bookViewModel.updateBook(newBook);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.book == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
