/* heading.h */
#ifndef HEADING_H
#define HEADING_H

#include <iostream>
#include <vector>
#include <stack>
#include <fstream>
#include <stdio.h>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <string.h>

using namespace std;
typedef string  temp;
typedef string  label;

enum symb_type {INT, INT_ARRAY};

struct symbol{
  int value;
  int size;
  symb_type type;

};

string gen(string operation1, string *operation2);

string gen(string operation1, string *operation2, string *operation3);

string gen(string operation1, string *operation2, string *operation3, string *operation4);

string gen(string operator1, string *operand1, string operand2);

string gen(string operator1, string *operand1, string *operand2, string operand3);

string new_temp();
string new_label();
string gen_param_init(string *id);

#endif
