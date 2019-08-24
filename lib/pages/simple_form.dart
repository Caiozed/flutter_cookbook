import 'package:flutter/material.dart';

class SimpleFormPage extends StatefulWidget {
  @override
  SimpleFormPageState createState() => SimpleFormPageState();
}

class SimpleFormPageState extends State<SimpleFormPage>{
    final _formKey = GlobalKey<FormState>();
    final myController = TextEditingController();
    var title = "";

    getFormKey(){
      return _formKey;
    }

  @override
  void initState() {
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    setState(() {
      title = myController.text; 
    });
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center( 
        child: SimpleForm(getFormKey(), myController))
    );
  }
}

class SimpleForm extends StatelessWidget{
  var _formKey;
  var myController;
  SimpleForm(GlobalKey<FormState> formKey, TextEditingController controller){
    this._formKey = formKey;
    this.myController = controller;
  }



  @override  
  Widget build(BuildContext context){
    return  Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: myController,
               decoration: InputDecoration(
                labelText: 'Write something!',
                hintText: 'Write something!',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.tealAccent,
                  style: BorderStyle.solid,
                  width: 5
                ))
              ),
              validator: (value){
                if(value.isEmpty){
                  return "Write something!";
                }
                return null;
              },
            ),
           ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: (){
                if(_formKey.currentState.validate()){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("You'r all set!")));
                }
              },
              child: Text("Submit", 
              style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}