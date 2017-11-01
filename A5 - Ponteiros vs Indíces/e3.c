#include<stdio.h>

#define TRUE 1
#define FALSE 0
#define SIZE 10

int main()
{
  static int lista[SIZE];
  int houveTroca, i;
  int *p;

  for(p = &lista[0]; p < lista + SIZE; p++)
  {
    printf("Número: ");
    scanf("%i", p);
  }

  do
  {
    houveTroca = FALSE;
    for (i = 0; i < SIZE - 1; i++)
    {
      if (lista[i] > lista[i+1])
      {
	houveTroca = TRUE;
	lista[i] += lista[i+1];
	lista[i+1] = lista[i] - lista[i+1];
	lista[i] -= lista[i+1];
      }
    }
  } while (houveTroca);

  printf("Array ordenado: ");
  for (i = 0; i < SIZE; i++)
  {
    printf(" %i, ", lista[i]);
  }
  printf("\n");

  return 0;
}
