import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/buku.dart';
import '../viewmodels/buku_viewmodel.dart';

class AddEditPage extends StatefulWidget {
  final Buku? book;

  const AddEditPage({super.key, this.book});

  @override
  AddEditPageState createState() => AddEditPageState();
}

class AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title, _author, _category, _status, _content;

  @override
  Widget build(BuildContext context) {
    final bukuViewModel = Provider.of<BukuViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.book?.title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                initialValue: widget.book?.author,
                decoration: const InputDecoration(labelText: 'Author'),
                onSaved: (value) => _author = value,
              ),
              TextFormField(
                initialValue: widget.book?.category,
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value,
              ),
              TextFormField(
                initialValue: widget.book?.content,
                decoration: const InputDecoration(labelText: 'Content'),
                onSaved: (value) => _content = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newBook = Buku(
                      id: widget.book?.id,
                      title: _title!,
                      author: _author!,
                      category: _category!,
                      status: 'Available',
                      content: _content!,
                    );

                    if (widget.book == null) {
                      bukuViewModel.addBook(newBook);
                    } else {
                      bukuViewModel.updateBook(newBook);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.book == null ? 'Add Book' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
