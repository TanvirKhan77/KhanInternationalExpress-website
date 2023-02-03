import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';


final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentUser;

UserModel? userModelCurrentInfo;

Color primaryColor = Color(0xFF01579B);