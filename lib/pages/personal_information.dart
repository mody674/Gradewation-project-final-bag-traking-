import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextController = TextEditingController(
      text: "Samir Elmahdy",
    );
    TextEditingController emailTextController = TextEditingController(
      text: "samir elmahdy22@gamil.com",
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Personal Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[100]!, width: 2),
            ),
            child: ListTile(
              title: const Text(
                "Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              subtitle: Text(
                nameTextController.text,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TextFieldCustom(
                            title: 'Name',
                            controller: nameTextController,
                          ),
                          const SizedBox(height: 10),
                          _ButtonCustom(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[100]!, width: 2),
            ),
            child: ListTile(
              title: const Text(
                "E-mail",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              subtitle: Text(
                emailTextController.text,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TextFieldCustom(
                            title: 'E-mail',
                            controller: emailTextController,
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          _ButtonCustom(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _TypesCard(),
        ],
      ),
    );
  }
}

// ويدجيت TypesCard المدمج
class _TypesCard extends StatefulWidget {
  const _TypesCard();

  @override
  State<_TypesCard> createState() => _TypesCardState();
}

class _TypesCardState extends State<_TypesCard> {
  String _selectedType = 'english';
  final List<String> types = ['Arabic', 'english'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[100]!, width: 2),
      ),
      child: ListTile(
        title: const Text(
          "Type",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        subtitle: const Text(
          "Male",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.red,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        String type = types[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = type;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF960912),
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  type,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                if (_selectedType == type)
                                  const Icon(
                                    Icons.check,
                                    color: Color(0xFF960912),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ويدجيت ButtonCustom المدمج من ProfilePagePhoto
class _ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;

  const _ButtonCustom({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.sizeOf(context).width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 150, 9, 18),
          ),
          child: const Text(
            "Save Changes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ويدجيت TextFieldCustom المدمج من ProfilePagePhoto
class _TextFieldCustom extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? inputType;

  const _TextFieldCustom({
    required this.title,
    required this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
