// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AuthService {
  late UserCredential userCredential; // Remove the global variable

  UsersEntity globaluser = UsersEntity(
    userCredential: null, // Initialize with null
    id: '',
    nationality: '',
    gender: '',
    username: '',
    age: '',
    origine: '',
    pays: '',
    profession: '',
    description: '',
    email: '',
    mahramNom: '',
    mahramPrenom: '',
    mahramMail: '',
    mahramTel: '',
    statutMarital: '',
    taille: '',
    mahramValide: false,
    enfants: false,
    pratiqueReligieuse: '',
    dressCode: '',
    langues: '',
    education: '',
    profilePhoto: '',
    photoList: '',
    hobbies: [],
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Start the Google sign-in process
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // Create a new credential using the Google ID token and access token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the credential
      userCredential = await _auth.signInWithCredential(
          credential); // Assign to the userCredential property

      // Update the user property in the UsersEntity instance
      globaluser = UsersEntity(
        userCredential: userCredential,
        id: '',
        nationality: '',
        gender: '',
        username: '',
        age: '',
        origine: '',
        pays: '',
        profession: '',
        description: '',
        email: '',
        mahramNom: '',
        mahramPrenom: '',
        mahramMail: '',
        mahramTel: '',
        statutMarital: '',
        taille: '',
        mahramValide: false,
        enfants: false,
        pratiqueReligieuse: '',
        dressCode: '',
        langues: '',
        education: '',
        profilePhoto: '',
        photoList: '',
        hobbies: [],
      );

      return userCredential;
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<UsersEntity?> getUserById(String userId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      return UsersEntity.fromMap(userData!);
    } else {
      return null;
    }
  }

  String generateVerificationCode() {
    Random random = Random();
    int code = random.nextInt(900000) +
        100000; // Generate a random number between 100000 and 999999
    return code.toString();
  }

  void sendVerificationCode(
      String recipientEmail, String verificationCode) async {
    String username = 'Mahram_App@barbariancosmetics.fr';
    String password = 'BarbarianC#83';

    final smtpServer = SmtpServer('smtp.hostinger.com',
        port: 465, username: username, password: password, ssl: true);

    final message = Message()
      ..from = Address(username, 'Your Name')
      ..recipients.add(recipientEmail)
      ..subject = 'Verification Code'
      ..text = 'Your verification code is: $verificationCode';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error occurred while sending email: $e');
    }
  }

  Future<String> getUserLocation(UsersEntity user) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case when location services are not enabled
      return ''; // Return empty string
    }

    // Check location permission status
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Handle case when the user has denied location permission permanently
      return ''; // Return empty string
    }

    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle case when the user has denied location permission
        return ''; // Return empty string
      }
    }

    // Fetch the user's current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use the position object to get latitude and longitude
    double lat = position.latitude;
    double lng = position.longitude;

    // Use geocoding to get the location name
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String locationName = placemark.name ?? '';
      String city = placemark.locality ?? '';
      String country = placemark.country ?? '';

      print('Location Name: $locationName');
      print('City: $city');
      print('Country: $country');
      String address = '$city, $country';
      user.adress = address;

      // Store the city and country to the user's document in Firestore
      // ... (add your code here to store the address)

      return address; // Return the address
    }

    return ''; // Return empty string if no address is found
  }

  Future<void> addUserToFirestore(
      UsersEntity user, UserCredential userCredential) async {
    try {
      CollectionReference usersCollection = _firestore.collection('users');

      await usersCollection.doc(userCredential.user?.uid).set({
        'gender': user.gender,
        'username': user.username,
        'nationality': user.nationality,
        'age': user.age,
        'origine': user.origine,
        'pays': user.pays,
        'taille': user.taille,
        'poids': user.poids,
        'statutMarital': user.statutMarital,
        'profession': user.profession,
        'description': user.description,
        'email': user.userCredential?.user?.email,
        'enfants': user.enfants,
        'pratiqueReligieuse': user.pratiqueReligieuse,
        'dressCode': user.dressCode,
        'langues': user.langues,
        'education': user.education,
        'emailVerified': true,
        'hobbies': user.hobbies,
        'id': user.userCredential?.user?.uid,
        'profileimage': user.photoList,
        'profileimagelist': user.profilePhoto,
      });
      if (user.gender.contains('Female')) {
        await usersCollection.doc(userCredential.user?.uid).update({
          'mahramNom': user.mahramNom,
          'mahramPrenom': user.mahramPrenom,
          'mahramMail': user.mahramMail,
          'mahramTel': user.mahramTel,
          'mahramValide': user.mahramValide,
        });
      }

      // Save the currentUser data to Firestore
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error adding user to Firestore: $e');
    }
  }

  void updateUserInfo(String userId, Map<String, dynamic> newData) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(newData)
        .then((value) {
      print("User data updated successfully!");
    }).catchError((error) {
      print("Failed to update user data: $error");
    });
  }

  String generatePassword(int length) {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#./";
    final random = Random.secure();
    final password =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();
    print(password);
    return password;
  }

  Future<bool> createParentAccount(String mahramMail, UsersEntity user) async {
    try {
      // Create a new user in Firebase Authentication
      String parentPassword = generatePassword(8);
      UserCredential mahramCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mahramMail,
        password: parentPassword,
      );
      // Save the parent's account information to Firestore
      CollectionReference usersCollection =
          await _firestore.collection('Mahrams');

      await usersCollection.doc(user.userCredential!.user!.uid).set({
        'isMahram': true,
        'mahram nom': user.mahramNom,
        'mahram prenom': user.mahramPrenom,
        'mahram mail': user.mahramMail,
        'mahram num': user.mahramTel,
        'password': parentPassword,
      });

      // Return true to indicate successful account creation
      return true;
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error creating parent account and adding to Firestore: $e');
      // Return false to indicate failure in account creation
      return false;
    }
  }

  Future<void> addMahramToFirestore(UsersEntity user) async {
    try {
      CollectionReference usersCollection = _firestore.collection('Mahrams');

      await usersCollection.doc(user.userCredential?.user?.uid).set({
        'isMahram': true,
        'mahram nom': user.mahramNom,
        'mahram prenom': user.mahramPrenom,
        'mahram mail': user.mahramMail,
        'mahram num': user.mahramTel,
      });

      // Save the currentUser data to Firestore
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error adding user to Firestore: $e');
    }
  }

  Future<UsersEntity?> getUserFromFirestore(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        UsersEntity user = UsersEntity.fromMap(snapshot.data()!);

        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
      throw Exception('Failed to get user from Firestore');
    }
  }

  Future<bool> checkIfMahram(String email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Mahrams')
        .where('mahram mail', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<bool> searchUserByEmail(String email) async {
    try {
      // Search for the user in the 'Mahrams' collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      return querySnapshot.size > 0;
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error searching user in Firestore: $e');
      return false;
    }
  }

  Future<bool> checkIfMahramvalid(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      var data = snapshot.data();
      if (data != null && data['mahramValide'] == true) {
        return true;
      }
    }

    return false;
  }
}
