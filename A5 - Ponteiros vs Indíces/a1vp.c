#include<stdio.h>

#define TRUE 1
#define FALSE 0
#define SIZE 10

void main()
{
  static int lista[SIZE];
  int i;
  int *p, *p2;

  for(p = &lista[0]; p < lista + SIZE; p++)
  {
    printf("Número: ");
    scanf("%i", p);
  }

  for (p = &lista[0]; p < lista + SIZE - 1; p++) 
  {
    for (p2 = &lista[0]; p2 < lista + SIZE; p2++) 
    {
      if (*p > *p2) {
	*p += *p2;
	*p2 = *p - *p2;
	*p -= *p2;
      }  
    }
  }

  printf("Array ordenado: ");
  for (p = lista; p < lista + SIZE; p++)
  {
    printf(" %i, ", *p);
  }
  printf("\n");
}
