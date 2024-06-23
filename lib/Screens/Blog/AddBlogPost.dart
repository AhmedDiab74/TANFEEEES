import 'package:flutter/material.dart';



class AddBlogPostScreen extends StatefulWidget {
  @override
  _AddBlogPostScreenState createState() => _AddBlogPostScreenState();
}

class _AddBlogPostScreenState extends State<AddBlogPostScreen> {
  String dropdownValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Small Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Text Editor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement image upload logic
              },
              child: Text('Upload Image'),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tags',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement form submission logic
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
