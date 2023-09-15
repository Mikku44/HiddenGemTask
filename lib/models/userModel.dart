

Map<String, String> User(username,name, password, bmi, age, update) {
 
  Map<String, String> Users = {
    'username':username,
    'password': password.toString() ,
    'lastBMI': bmi.toString(),
    'age': age.toString(),
    'name': name.toString(),
    'updated_at': update.toString()
  };
  return Users;
}
