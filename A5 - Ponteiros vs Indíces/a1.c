#include<stdio.h>

#define TRUE 1
#define FALSE 0
#define SIZE 10

void main()
{
  static int lista[SIZE];
  int i, j;

  for(p = &lista[0]; p < lista + SIZE; p++)
  {
    printf("Número: ");
    scanf("%i", p);
  }

  for (i = 0; i < SIZE-1; i++) 
  {
    for (j = 0; j < SIZE; j++) 
    {
      if (lista[i] > lista[j]) {
        lista[i] += lista[j];
	lista[j] = lista[i] - lista[j];
	lista[i] -= lista[j];
      }  
    }
  }

  printf("Array ordenado: ");
  for (i = 0; i < SIZE; i++)
  {
    printf(" %i, ", lista[i]);
  }
  printf("\n");
}
