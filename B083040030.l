%{
#include<stdio.h>
unsigned charCount = 1,lineCount = 1, last_is_a_number = 0;
int temp_yyleng;
%}
reserved ?i:(absoulte|and|begin|break|case|const|continue|do|else|end|for|funtion|if|mod|nil|not|object|of|or|program|then|to|var|while|array|integer|double|write|writeln|string|float|read)
space [ ]
eol \n
symbol [;:\(\)><=\[\]\+\-\*/\.,]|:=|==|<=|>=
identifiers ([^\r\n ;:\(\)><=\[\]\+\-\*/\.,])[a-zA-Z_0-9]*
real [+-]?([0-9]+|[0-9]*[.][0-9]*)([Ee][+-]?[0-9]*)?
string ['](.|[']['])*[a-zA-Z0-9']
comment \(\*([^\*]|[\*]+[^\*\)])*[\*]+\)


%%
{reserved} {
	temp_yyleng = yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\".\n", lineCount, charCount, yytext);
	charCount += temp_yyleng;
	last_is_a_number = 0;
	
}
{space} {
	charCount++;
}
{eol} {
	lineCount++; 
	charCount = 1;
	last_is_a_number = 0;
}
{comment} {
	temp_yyleng = yyleng;
	printf("Line: %d, 1st char: %d, \n%s\nis a \"command\".\n", lineCount, charCount, yytext);
	charCount += temp_yyleng;
}
{symbol} {
	temp_yyleng = yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\".\n", lineCount, charCount, yytext);
	charCount += temp_yyleng;
	last_is_a_number = 0;
}
{string} {
	temp_yyleng = yyleng;
	if(yytext[yyleng-1]!='\'')
	{
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"string\".\n", lineCount, charCount, yytext);
		charCount += temp_yyleng;
		break;
	}
	for(int j=0; j<yyleng; j++)
	{
		yytext[j] = yytext[j+1];
	}
	yyleng--;
	for(int j=yyleng-1; j<yyleng; j++)
	{
		yytext[j] = yytext[j+1];
	}
	yyleng--;
	
	for(int i=0; i<yyleng; i++)
	{
		if(yytext[i]=='\'' && yytext[i+1]=='\'')
		{
			for(int j=i; j<yyleng; j++)
			{
				yytext[j] = yytext[j+1];
			}
			yyleng--;
			i++;
		}			
	}
	if(yyleng>30)
	{
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"string\".\n", lineCount, charCount, yytext);
		charCount += temp_yyleng;
		break;
	}
	printf("Line: %d, 1st char: %d, \"%s\" is a \"string\".\n", lineCount, charCount, yytext);
	charCount += temp_yyleng;
	last_is_a_number = 0;
}
{real} {
	temp_yyleng = yyleng;
	if(yytext[0] == '+' || yytext[0] == '-' && last_is_a_number)
	{
		printf("Line: %d, 1st char: %d, \"%c\" is a \"symbol\".\n", lineCount, charCount, yytext[0]);
		for(int i=0; i<yyleng; i++)
			yytext[i] = yytext[i+1];
		charCount++;
		temp_yyleng--;
		yyleng--;
	}
	int point_flag = 0;
	for(int i=0; i<yyleng; i++)
		if(yytext[i] == '.')
			point_flag = 1;
	//.0001 or 1234. or 01.7 or 0.100
	if(yytext[0]=='.' || yytext[yyleng-1]=='.' || (yyleng > 1 && yytext[0]=='0' && yytext[1]!='.') || (yyleng>1 && point_flag && yytext[yyleng-1]=='0'))
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"real number\".\n", lineCount, charCount, yytext);
	else
		printf("Line: %d, 1st char: %d, \"%s\" is a \"real number\".\n", lineCount, charCount, yytext);	
	charCount += temp_yyleng;
	last_is_a_number = 1;
	
}
{identifiers} {
	temp_yyleng = yyleng;
	if(yyleng <=15 && ((yytext[0]>='a' && yytext[0]<='z') || (yytext[0]>='A' && yytext[0]<='Z') || yytext[0]=='_'))
		printf("Line: %d, 1st char: %d, \"%s\" is a \"ID\".\n", lineCount, charCount, yytext);
	else
		printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"ID\".\n", lineCount, charCount, yytext);	
	charCount += temp_yyleng;
	last_is_a_number = 1;
}

%%

int main()
{
	yylex(); 	
	return 0;
}
