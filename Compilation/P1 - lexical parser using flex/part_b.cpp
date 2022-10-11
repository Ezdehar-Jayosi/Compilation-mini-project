#include "tokens.hpp"
#include <stack>
#include <iostream>
#include <string>
#include <stdlib.h>
#include <stdio.h>

using namespace std;
void printStack(stack<int>output){
   int temp;
    while(!output.empty()){
        temp = output.top();
        switch (temp)
			{
			case 1:
				std::cout << "(" << std::endl;
				break;
			case 2:
				std::cout << "{" << std::endl;
				break;
			case 3:
                std::cout <<  std::endl;
                break;
            case 11: 
                std::cout << ")" << std::endl;
                break;
            case 22:
                std::cout << "}" << std::endl;
                break;
                
			}
            output.pop();
        
    }
  
}
int main()
{
	int token, x=0;
	stack<int> s, output;
    
	
	while(token = yylex()) {
        if(token==WHITESPACE) {continue;}
		if ((token!=LBRACE)&&(token!=RBRACE)&& (token!=LPAREN)&& (token!=RPAREN))
		{
			cout << "Error: " << tokenTypeArray[token-1] << endl;
			exit(1);
		}
           
             
		if ((token==LBRACE) || (token==LPAREN))
		{
            int i=0;
            while(i<x){
                std::cout << '\t' ;
                i++;
            }
            x++;
			switch (yytext[0])
			{
			case '(':
				s.push(1);
                std::cout << "(" << std::endl;
                output.push(1);
				break;
			case '{':
				s.push(2);
                std::cout << "{" << std::endl;
                output.push(2);
				break;
			
			}
		}
		else if((token==RBRACE)||(token==RPAREN)){
           if(s.empty()){
                cout << "Error: Bad Expression"  << endl;
                exit(1);
           }
          
             
            int token_top;
            switch (yytext[0])
			{
			case ')':
            
			    token_top = s.top();
                if(token_top == 1) {
                     int i=0;
                      x--;
                    while(i<x){
                        std::cout << '\t' ;
                        i++;
                    }
                    
                    s.pop();
                     std::cout << ")" << std::endl;
                    output.push(11);
                   
                }
                else {
                    cout << "Error: Bad Expression"  << endl;
                    exit(1);  
                }
                
				break;
			case '}':
				token_top = s.top();
                if(token_top == 2){
                    int i=0;
                     x--;
                    while(i<x){
                        std::cout << '\t' ;
                        i++;
                    }
                    s.pop();
                    std::cout << "}" << std::endl;
                    output.push(22);
                    
                }
                else {
                    cout << "Error: Bad Expression"  << endl;
                    exit(1);
                }
                 
				break;
			
			}
             
           
        }
	}

	if (!s.empty())
	{
        cout << "Error: Bad Expression"  << endl;
        exit(1);
    }
   /* stack<int> reverse_output_stack;
    
    while(!output.empty){
        reverse_output_stack.push(output.top());
        output.pop();
    }*/
	
  //  printStack(reverse_output_stack);

	return 0;
}
