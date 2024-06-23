import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _zipController = TextEditingController();

  String selectedGender = '';
  String selectedCountry = '';
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> countries = ['USA', 'Canada', 'UK', 'Germany', 'France'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            child: Form(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone'),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      SizedBox(height: 16.0),
                      MyBorderedTextField(),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _zipController,
                        decoration: InputDecoration(labelText: 'ZIP Code'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        items: genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Gender'),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        items: countries.map((String country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value!;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Country'),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission here
                          // You can access form values using _nameController.text, _emailController.text, etc.
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBorderedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Enter text',
        contentPadding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 15), // Padding inside the TextField
        border: OutlineInputBorder(
          // Border on all sides
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          // Border when the TextField is not focused
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // Border when the TextField is focused
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
