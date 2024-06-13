import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/admin/manage_user/user_profile_page.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AdminManageUserPage extends StatefulWidget {
  const AdminManageUserPage({super.key});

  @override
  State<AdminManageUserPage> createState() => _AdminManageUserPageState();
}

class _AdminManageUserPageState extends State<AdminManageUserPage> {
  List _allResults = [];
  List _resultList = [];
  final _searchController = TextEditingController();
  String _selectedRole = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isNotEqualTo: 'Admin')
        .orderBy('first_name')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  _onSearchChanged() {
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  searchResultList() {
    var filteredResults = [];
    if (_selectedRole == 'All') {
      filteredResults = List.from(_allResults);
    } else {
      for (var user in _allResults) {
        if (user['role'].toString().toLowerCase() ==
            _selectedRole.toLowerCase()) {
          filteredResults.add(user);
        }
      }
    }

    if (_searchController.text != "") {
      var searchResults = [];
      for (var user in filteredResults) {
        var firstName = user['first_name'].toLowerCase();
        var lastName = user['last_name'].toLowerCase();
        var email = user['email'].toLowerCase();
        if (firstName.contains(_searchController.text.toLowerCase()) ||
            lastName.contains(_searchController.text.toLowerCase()) ||
            email.contains(_searchController.text.toLowerCase())) {
          searchResults.add(user);
        }
      }
      filteredResults = searchResults;
    }

    setState(() {
      _resultList = filteredResults;
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter by Role',
                style: AppTheme.normalTextGrey,
                textAlign: TextAlign.left,
              ),
              ListTile(
                titleTextStyle: AppTheme.smallTextGreen,
                title: const Text('All Users'),
                onTap: () {
                  setState(() {
                    _selectedRole = 'All';
                    searchResultList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                titleTextStyle: AppTheme.smallTextGreen,
                title: const Text('Therapists'),
                onTap: () {
                  setState(() {
                    _selectedRole = 'Therapist';
                    searchResultList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                titleTextStyle: AppTheme.smallTextGreen,
                title: const Text('Members'),
                onTap: () {
                  setState(() {
                    _selectedRole = 'Member';
                    searchResultList();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Manage User"),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    "/admin-register-page",
                  ),
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: _showFilterDialog,
                  icon: Icon(Icons.tune),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CupertinoSearchTextField(
              controller: _searchController,
              itemColor: AppTheme.primaryGreen,
              backgroundColor: AppTheme.backgroundWhite,
              style: AppTheme.smallTextGrey,
              placeholder: 'Search Name or Email',
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _resultList.length,
        itemBuilder: (context, index) {
          var user = _resultList[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Row(
              children: [
                Text(_resultList[index]['first_name'],
                    style: AppTheme.smallTextGrey),
                Text(" "),
                Text(
                  _resultList[index]['last_name'],
                  style: AppTheme.smallTextGrey,
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(_resultList[index]['profile_picture']),
            ),
            subtitle: Text(_resultList[index]['role'].toString().toLowerCase(),
                style: AppTheme.smallTextGreen),
            trailing: buildBanChip(_resultList[index]['is_banned']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(
                    userData: user,
                    onBanUser: () {
                      getClientStream();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBanChip(bool isBanned) {
    return Chip(
      label: Text(
        isBanned ? "Banned" : "Active",
        style: AppTheme.smallTextWhite,
      ),
      backgroundColor: isBanned ? AppTheme.lightRed : AppTheme.primaryGreen,
    );
  }
}
