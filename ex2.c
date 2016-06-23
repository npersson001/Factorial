#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LEN 22 //include the terminator

main(){
	int loop = 1, length, integerToPrint, j, factorialToPrint;
	char inputString[LEN];
	char* string;


	while(loop){
		fgets(inputString, LEN, stdin);
		length = strlen(inputString);
		string = malloc(length + 1); // include the null terminator

		for(j=0; j < length; j++){
      		string[j] = inputString[j];
    	}

		integerToPrint = a_to_i(string);
		factorialToPrint = factorial(integerToPrint);

		free(string);

		if(integerToPrint == 0){
			loop = 0;
		}
		
		printf("%d\n", factorialToPrint);

	}
}

int a_to_i(char* str){
	int number, count, lengthString;
	//lengthString = strlen(str);

	number = 0;

	for(count = 0; str[count] != '\n'; count++){
		number = number * 10 + (str[count] - 48);
	}

	return number;
}

int factorial(int n){
	if(n == 0){
		return 1;
	}
	else{
		return n*factorial(n - 1);
	}
}