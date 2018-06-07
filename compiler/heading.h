/* heading.h */


#include <iostream>
#include <vector>
#include <stack>
#include <fstream>
#include <stdio.h>
#include <string>
#include <sstream>

using namespace std;
typedef string  temp;
typedef string  label;

enum symb_type {INT, INT_ARRAY};

struct symbol{
  int value;
  int size;
  symb_type type;

};

inline string gen(string *operation1, string *operation2);

inline string gen(string *operation1, string *operation2, string *operation3);

inline string gen(string *operation1, string *operation2, string *operation3, string *operation4);

string new_temp();
string new_label();
