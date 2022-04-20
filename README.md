# compiler HW1 作業說明

在第一個作業，你必須使用 Lex 寫出一個 **Pascal scanner**。你的 scanner 要能處理所有的保留字 (reserved words)、識別字 (Identifiers)、符號 (symbols) 、數字(Integer、Real)、註解 (comments)、字串常數(quoted string)。如果處理到不合法的 token，你的 scanner 要產生 error message (error detection)。你的 scanner 要盡可能的處理完所有的輸入 (input)。如果發生錯誤，產生 error message，之後能繼續處理其它的輸入 (error recovery)。

Scanner 的輸出 (output) 會列出每個token以及此 token的型態 (integer, real, ID, reserved word, string, symbol) 、此 token 所在的行數、第一個字元所在的位置。

### (1).  保留字(reserved)
Pascal 是 case-insensitive。例如：保留字**program** 、 **ProGram** 和 **PROGRAM** 是一樣的。  
保留字列表：
```
  absolute  and  begin  break  case  const  continue  do  else  end  for	function  if  mod  nil  not  object  of  or  program  then  to  var  while
  array  integer  double   write  writeln   string   float  read  array integer double write writeln string float
```

### (2).	識別字 (Identifiers)  
字數最長到 15個字元。一個識別字的第一個字元必須是英文字母或是底線符號 (_) 起頭，在第一個字元之後，可以是英文字母、數字和底線符號。識別字裡不可包含空白字元。
例如：  
```
 	peter 、 _db 、 a1 這些是合法的識別字。  
 	1a 、^db 、 #db 、 abcdefghijklmnopqrstuvwxyz12345 這些都不是合法的識別字。  
```
  
### (3).	符號 (symbols)
符號列表：
```
  ;  :  (  )  :=  >  <  =  ==  <=  >=  [  ]  +  -  *  /  .
``` 

### (4).	實數 (Real) 
常數可以有正負，且有小數點 (decimal point) 表示法和科學符號表示法兩種。
例如：
```
 	1.0 、 3.14 、 7E-2 、 12.25e+6 、 -7.5E+3 這些是合法的實數常數。
 	1.00 、 03.0 、 12.100 、 .1 、 1. 這些都不是合法的實數常數。
```

### (5).	字串常數 (quoted string)
字數最長到 30 個字元，你的 scanner 如何處理超長的字串常數？’Pascal’ 即是字串常數。你的scanner必須能處理下列這些字串：  
```
 空字串，即 ’’。
 ‘ ’ 代表一個空白。
 ‘You’’ll see’ 代表字串 You’ll see
```
### (6).  註解(comment)
你的 scanner 如何處理註解？註解可以跨行。
例如：
```
 	(* comment *) 是一個合法的註解。
 	(* comment
	second line *) 是一個合法的註解。
 	(*****) 是一個合法的註解。
 	(* a**b) *) 是一個合法的註解。
 	(*ab*)**) 不是一個合法的註解。
```



