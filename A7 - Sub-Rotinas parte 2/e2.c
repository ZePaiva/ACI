#include <stdio.h>

int main(void)
{
  char *itoa(int val, int base, char *s);
  static char str[33];
  int val;
  do{
    scanf("%d", &val);
    printf("%s\n", itoa(val, 2, str));
    printf("%s\n", itoa(val, 8, str));
    printf("%s\n", itoa(val, 16, str));
  }while (val != 0);
  return 0;
}

char *itoa(int val, int base, char *str)
{
  char *strrev(char *s);
  char toascii(char s);

  char *p = str;
  char digit;
  do
  {
    digit = val % base;
    val = val / base;
    *p++ = toascii(digit);
  } while(val > 0);

  *p = '\0';
  strrev(str);
  return str;
}

void exchange(char *c1, char *c2)
{
  char aux = *c1;
  *c1 = *c2;
  *c2 = aux;
}

char *strrev(char *str)
{
  char *p1 = str;
  char *p2 = str;

  while(*p2 != '\0')
  {
    p2++;
  }
  p2--;
  while(p1 < p2)
  {
    exchange(p1, p2);
    p1++;
    p2--;
  }
  return str;
}
char toascii(char a)
{
  a += '0';
  if (a > '9')
    a +=7;
  return a;
}
