/* heading.h */

using namespace std;

#include<iostream>
#include<vector>
#include<stack>
#include<fstream>
#include<stdio.h>
#include<string>

typedef string * temp;
typedef sytrng * label;

enum symb_type {INT, ARRAY};

struct symbol{
  int value;
  int size;
  symb_type type;

};
