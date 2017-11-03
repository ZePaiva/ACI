#include <stdio.h>

int main(void)
{
  unsigned int div(unsigned int dividendo, unsigned int divisor);

  printf("%d/%d = %d\n", 16, 4, div(16, 4));
  printf("%d/%d = %d\n", 20, 4, div(20, 4));
  printf("%d/%d = %d\n", 13, 4, div(13, 4));
  printf("%d/%d = %d\n", 1235, 4, div(1235, 4));
  printf("%d/%d = %d\n", 13416, 4, div(13416, 4));
  printf("%d/%d = %d\n", 346, 4, div(346, 4));
}

unsigned int div(unsigned int dividendo, unsigned int divisor)
{
  int i, bit, quociente, resto;
  divisor <<= 16;
  dividendo = (dividendo  & 0xFFFF) << 1;

  for (i = 0; i < 16; i++)
  {
    bit = 0;
    if (dividendo >= divisor)
    {
      dividendo -= divisor;
      bit = 1;
    }
    dividendo = (dividendo << 1) | bit;
  }

  quociente = dividendo & 0xFFFF;

  return quociente;
}
