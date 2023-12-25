import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collection user
const userCollection = "users";
const vendorCollection = 'vendors';
//product collection
const productCollection = "products";
//cart collection
const cartCollection = "cart";
const chatsCollection = 'chats';
const messagesCollection = 'messages';

const orderCollection = 'orders';
