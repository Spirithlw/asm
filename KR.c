#include <string.h>
#include <stdio.h>
#include <stdlib.h>

    void N_SCOPY(int arg, const char arr[],char* buffer)
        {

        }

   void _p2( char* a, char* b )//a = si, b = di; strcat
       {
        if ( (a == nullptr ) || ( b == nullptr ) )
            {
            return ;
            }

       while ( *a != 0 )
           {
           a++;
           }

       a--;
       while ( *b != 0 )
           {
           (*a) = (*b);
           b++;
           a++;
           }

       (*a) = 0;
       }

   char16_t _p3( char* a)//a = si; сумма всех байтов строки
       {
       if ( a == nullptr )
           {
           return 0;
           }

       char16_t d = 0;
       while ( *a != 0 )
           {
           d+= (*a);
           a++;
           }

       return d;
       }

   void _p1( char* a )//a = di, b = si; strrev
       {
       if ( (a == nullptr) || ( *a == 0 ) )
           {
           return;
           }

       char* b = a;
       while ( *b != 0 )
           {
           b++;
           }

       b--;
       while ( a < b )
           {
           char temp = *a;
           *a = *b;
           *b = temp;

           a++;
           b--;
           }

       }


   char* _p4( int* a, char b)// a = si, b = ax, c = di, d = dx
       {
       if ( a == nullptr )
           {
           return nullptr;
           }

       char* c = a;
       b *=2;
       char* d = b + a ;
       while ( a < d )
           {
            if ( *a < *c )
                {
                c = a;
                }
            a += 2;
           }

       return c;
       }

       char array[5] = {1, 5, -8, 9, 1};

   int main()
       {
       char buffer[90];
       printf("\n");
       N_SCOPY(80, "abcde", buffer);
       _p1(buffer);
       printf("<%s>\n", buffer);
       _p2(buffer, "12345");
       printf("<%s>\n", buffer);
       printf("<%s>\n", _p3(buffer) );
       N_SCOPY(10, array, buffer + 80);
       printf("<%d>\n",*( _p4( buffer + 80, 5) ) );
       return 0;
       }
