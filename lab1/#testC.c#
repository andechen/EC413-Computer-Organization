#include <stdio.h>
// SOLUTION FILE

main()
{
  int var_int;                    // 2
  char var_char;		  // 2
  float var_float;	 	  // 2
  double var_double;		  // 2

  unsigned char uchar1, uchar2;   // 3
  signed char schar1, schar2;

  int x, y;                       // 4

  char i;                         // 5
  char shift_char;

  int a[10] = {0,10,20,30,40,50,60,70,80,90};    // 6

  int b[10], c[10];               // 7
  int *ip, *ip2;
  int j, k;

  char AString[] = "HAL";           // 8

  // 1 -- change "World" to your name
  printf("\n\n PART 1 ---------\n");

  printf("\n Hello Ande! \n");

  // 2 -- find sizes of the other C datatypes
  printf("\n\n PART 2 ----------\n");

  printf("\n size of data type int = %d bytes", sizeof(var_int));
  printf("\n size of data type char = %d bytes", sizeof(var_char));
  printf("\n size of data type float = %d bytes", sizeof(var_float));
  printf("\n size of data type double = %d bytes", sizeof(var_double));

  // 3 -- explore signed versus unsigned datatypes and their interactions
  printf("\n\n PART 3 ----------\n");

  uchar1 = 0xFF;
  uchar2 = 0xFE;
  schar1 = 0xFF;
  schar2 = 0xFE;

  printf("\n uchar1 = %d ", uchar1);
  printf("\n uchar2 = %d ", uchar2);
  printf("\n schar1 = %d ", schar1);
  printf("\n schar2 = %d ", schar2);

  printf("\n\n uchar1 and schar1 have different outputs because uchar1 is an unsigned character, while schar1 is a signed character. This means that the first bit of schar1 is used to repersent negative.");

  if(uchar1 > uchar2){
	printf("\n\n %d", uchar1);
  }else{
	printf("\n\n %d", uchar2);
  }

  if(schar1 > schar2){
	printf("\n\n %d", schar1);
  }else{
	printf("\n\n %d", schar2);
  }

  if(uchar1 > schar1){
	printf("\n\n %d", uchar1);
  }else{
	printf("\n\n %d", schar1);
  }

  printf("\n\n schar1 + schar2 = %d", schar1+schar2);
  printf("\n Yes, this is expected.");

  printf("\n\n uchar1 + uchar2 = %d", uchar1+uchar2);
  printf("\n Yes, this is expected.");

  printf("\n\n schar1 + uchar1 = %d", schar1+uchar1);
  printf("\n schar1 + uchar1 adds the two numbers together");

  // 4 -- Booleans
  printf("\n\n PART 4 ----------\n");

  x = 1; y = 2;

  printf(" \n True = %d\n", x != y);
  printf(" False = %d\n", x == y);

  printf(" Size of boolean: %d", sizeof(x==y));

  printf("\n\n x & y: %d", x & y);
  printf("\n x && y: %d", x && y);

  printf("\n\n ~x: %d", ~x);
  printf("\n x != y: %d", x != y);

  // 5 -- shifts
  printf("\n\n PART 5 ----------\n");

  shift_char = 15;
  i = 1;

  printf("\n shift_char: %d", shift_char);
  printf("\n shift_char << %d = %d", i, shift_char << i);
  printf("\n shift_char >> %d = %d", i, shift_char >> i);
  
  printf("\n\n shift_char << %d = %d", i+3, shift_char << i+3);
  printf("\n This is expected because the binary form of 15 is 1111, so shifting it 4 to the left gives 11110000, which is 240");

  char new_char = shift_char << 8;
  printf("\n shift_char << %d = %d", i+7, new_char);
  printf("\n Shifting more than 7 places gives 0 because the char data type can only hold 1 byte, and shifting 8 places makes the char variable hold all the 0's generated from shifting.");
  // HINT: If you cannot observe any "interesting" results using the above statement,
  // try assigning the shifted value to a different variable and then printing the new 
  // variable.


  // 6 -- pointer basics
  printf("\n\n PART 6 ----------\n");

  ip = a;
  printf("\n start %d ", a[0]);
  printf("%d ", *(ip));
  printf("%d ", *(ip+1));
  printf("%d ", *ip++);
  printf("%d ", *ip);
  printf("%d ", *(ip+3));
  printf("%d \n", *(ip-1));

  printf("\n start %d ", a[1]);
  printf("%d ", *(ip));
  printf("%d ", *(ip+1));
  printf("%d ", *ip++);
  printf("%d ", *ip);
  printf("%d ", *(ip+3));
  printf("%d \n\n ", *(ip-1));

  printf("Size of integer pointer: %d bytes", sizeof(ip));
  
  printf("\n\n Pointer value: %x", ip);
  printf("\n It makes sense to use hex because memory address values can be very large");

  printf("\n\n ip: %x", ip);
  printf("\n ip+1: %x", ip+1);
  //printf("\n ip - ip+1: %d", ip-(ip+1));
  printf("\n The difference between ip and ip+1 is not 1 because ip is an integer array, so each element is 4 bytes");

  // 7 -- programming with pointers
  printf("\n\n PART 7 ----------\n");

  printf("\n %d ", a[0]);
  printf("%d ", a[1]);
  printf("%d ", a[2]);
  printf("%d ", a[3]);
  printf("%d ", a[4]);
  printf("%d ", a[5]);
  printf("%d ", a[6]);
  printf("%d ", a[7]);
  printf("%d ", a[8]);
  printf("%d\n ", a[9]);

  int array_len = sizeof(a)/sizeof(a[0]);

  for(j = 0; j < array_len; j++){
    b[j] = a[array_len-1-j];
    printf("%d ", b[j]);
  }

  printf("\n ");

  ip = a;
  for(j = 0; j < array_len; j++){
    b[j] = *(ip+array_len-1-j);
    printf("%d ", b[j]);
  }

  // 8 -- strings
  printf("\n\n PART 8 ----------\n");

  printf("\n %s \n ", AString);

  printf("H: %d", 'H'); 
  printf("\n A: %d", 'A');
  printf("\n L: %d", 'L');
  
  printf("\n AString[3]: %d", AString[3]);
  printf("\n The byte after the last character is 0 which is ASCII for NULL because these is nothing in AString after HAL");

  for(j = 0; j < 3; j++){
    AString[j] += 1;
  }

  printf("\n\n %s", AString);
  
  AString[3] += 60;
  printf("\n\n %s", AString);

  // 9 -- address calculation
  printf("\n\n PART 9 ----------\n");
  for (k = 0; k < 10; k++){
	 b[k] = a[k];         // direct reference to array element
 	 printf("%x ", &a[k]);
  }
  printf("\n");

  ip = a;
  ip2 = b;
  printf("%x\t%x\n", a, b);
  for (k = 0; k < 10; k++){ 
	*ip2++ = *ip++;     // indirect reference to array element
  	printf("%x ", ip);
	printf("%x\n ", ip2);
  }

  // 10 -- transpose array
  printf("\n\n PART 10 ----------\n\n ");
  int C[10][10];
  int Ct[10][10];

  for(i = 0; i < 10; i++){
	for(j = 0; j < 10; j++){
		C[i][j] = rand() % 10;
		printf("%d ",C[i][j]);
	}
	printf("\n ");
  }

  printf("TRANSPOSE\n ");

  for(i = 0; i < 10; i++){
	for(j = 0; j < 10; j++){
		Ct[i][j] = C[j][i];
		printf("%d ",Ct[i][j]);
	}
	printf("\n ");
  }

  // all done
  printf("\n\n ALL DONE\n");
}
