#include<stdio.h>

#define SIZE 10
#define TRUE 1
#define FALSE 0
void main()
{
  static int lista[SIZE];
  int swap;
  int *p, *pLast;
  
  pLast = &lista[SIZE-1];
  for(p = &lista[0]; p <= pLast; p++)
  {
    printf("Numero: ");
    scanf("%d", p);
  }

  do
  {
    p = &lista[0];
    swap = FALSE;
    while(p < pLast)
    {
      if (*p > *(p + 1))
      {
	*p += *(p+1);
	*(p+1) = *p - *(p+1);
	*p -= *(p+1);
	swap = TRUE;
      }
      p++;
    }
  } while (swap);
  
  printf("Lista ordenada: ");
  p = &lista[0];
  while (p <= pLast)
  {
    printf("%d, ", *p);
    p++;
  }
}
