// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

class UsersEntity {
  String gender = '';
  String username = '';
  String nationality = '';
  String age = '';
  String origine = '';
  String adress = '';
  String pays = '';
  String taille = '';
  String poids = '';
  String statutMarital = '';
  String profession = '';
  String description = '';
  String profilePhoto = '';
  String photoList = '';
  String id = '';
  List<String> hobbies = const [];
  String email = '';
  String mahramNom = '';
  String mahramPrenom = '';
  String mahramMail = '';
  String mahramTel = '';
  bool mahramValide = false;
  bool enfants = false;
  String pratiqueReligieuse = '';
  String dressCode = '';
  String langues = '';
  String education = '';
  String password = '';
  bool emailVerified = false;
  String mahramPassword = '';
  UserCredential? userCredential;

  UsersEntity({
    this.adress = '',
    this.userCredential,
    this.hobbies = const [],
    this.emailVerified = false,
    this.password = '',
    this.id = '',
    this.mahramPassword = '',
    this.gender = '',
    this.username = '',
    this.nationality = '',
    this.age = '',
    this.origine = '',
    this.pays = '',
    this.taille = '',
    this.poids = '',
    this.statutMarital = '',
    this.profession = '',
    this.description = '',
    this.email = '',
    this.mahramNom = '',
    this.mahramPrenom = '',
    this.mahramMail = '',
    this.mahramTel = '',
    this.mahramValide = false,
    this.enfants = false,
    this.pratiqueReligieuse = '',
    this.dressCode = '',
    this.langues = '',
    this.education = '',
    this.profilePhoto = '',
    this.photoList = '',
  });

  UsersEntity.fromMap(Map<String, dynamic> map) {
    adress = map['adress'] ?? '';
    userCredential = map['userCredential'];
    id = map['id'] ?? '';
    emailVerified = map['emailVerified'] ?? false;
    gender = map['gender'] ?? '';
    hobbies = List<String>.from(map['hobbies'] ?? []);
    username = map['username'] ?? '';
    nationality = map['nationality'] ?? '';
    age = map['age'] ?? '';
    origine = map['origine'] ?? '';
    pays = map['pays'] ?? '';
    taille = map['taille'] ?? '';
    poids = map['poids'] ?? '';
    statutMarital = map['statutMarital'] ?? '';
    profession = map['profession'] ?? '';
    description = map['description'] ?? '';
    email = map['email'] ?? '';
    mahramNom = map['mahramNom'] ?? '';
    mahramPrenom = map['mahramPrenom'] ?? '';
    mahramMail = map['mahramMail'] ?? '';
    mahramTel = map['mahramTel'] ?? '';
    mahramValide = map['mahramValide'] ?? false;
    enfants = map['enfants'] ?? false;
    pratiqueReligieuse = map['pratiqueReligieuse'] ?? '';
    dressCode = map['dressCode'] ?? '';
    langues = map['langues'] ?? '';
    education = map['education'] ?? '';
    profilePhoto = map['profileimage'] ?? '';
    photoList = map['profileimagelist'] ?? '';
    password = map['password'] ?? '';
  }
}
