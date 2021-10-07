import 'dart:io';

class Cal {
  int add(num, num2) {
    int x = num;
    int y = num2;
    int c = x + y;

    return c;
  }

  int sub(num, num2) {
    int x = num;
    int y = num2;
    int c = x - y;
    return c;
  }

  int multi(num, num2) {
    int x = num;
    int y = num2;
    int c = x * y;
    return c;
  }

  double divi(num, num2) {
    int x = num;
    int y = num2;
    double c = x / y;
    return c;
  }
}

void main(List<String> args) {
  var cal2 = Cal();
  print("calculator");
  print("pliz inter first number");
  var f = int.parse(stdin.readLineSync()!);
  print("pliz enter the operation u need to +,-,/,*");
  String h = stdin.readLineSync()!;
  print("pliz enter second number");
  var g = int.parse(stdin.readLineSync()!);
  switch (h) {
    case "+":
      {
        print(cal2.add(f, g));
      }
      break;
    case "-":
      {
        print(cal2.sub(f, g));
      }
      break;
    case "*":
      {
        print(cal2.multi(f, g));
      }
      break;
    case "/":
      {
        try {
          cal2.divi(f, 0);
        } on IntegerDivisionByZeroException {
          print("division by zero");
        }
        cal2.divi(f, g);
        if (g == 0) {
          throw new IntegerDivisionByZeroException();
        }

        print(cal2.divi(f, g));
      }
  }
}
