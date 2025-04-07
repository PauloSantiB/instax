RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$'); 

RegExp passwordRexExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

RegExp specialCharRexExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
