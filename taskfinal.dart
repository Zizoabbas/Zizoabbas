import 'dart:io';

class Calcultor {
  int add(int num, int num2) {
    int z = num;
    int x = num2;
    int c = z + x;
    return c;
  }

  int sub(int num, int num2) {
    int z = num;
    int x = num2;
    int c = z - x;
    return c;
  }

  int multi(int num, int num2) {
    int z = num;
    int x = num2;
    int c = z * x;
    return c;
  }

  double divi(int num, int num2) {
    int z = num;
    int x = num2;
    double c = z / x;
    return c;
  }
}

void main(List<String> args) {
  print('calculator');
  var cal2 = Calcultor();
  print("pliz Enter two numbers ");
  var k = int.parse(stdin.readLineSync()!),
      f = int.parse(stdin.readLineSync()!);
  print('the two number u entered are $f,$k');
  print(
      "1-for addition press 1\n 2-for subtraction press2 \n 3-for multiplication press 3\n 4-for division press4\n");
  var i = int.parse(stdin.readLineSync()!);
  if (i == 1) {
    print("the addition  of this two numeris is =");
    print(cal2.add(k, f));
  } else if (i == 2) {
    print("the subtraction of this two numbers is = ");
    print(cal2.sub(k, f));
  } else if (i == 3) {
    print("the multiplication of this two numbers is =");
    print(cal2.multi(k, f));
  } else if (i == 4) {
    print("the division of this two numbers is =");
    print(cal2.divi(k, f));
  }
}
