@ Assignment 2
@

.global strlen_asm0
.global strlen_asm1
.global strcpy_asm
.global strncpy_asm
.global strcmp_asm
.global strncmp_asm
.global strcat_asm

.text

strlen_asm0:        @ Gets the pointer to a string in R0 and returns len of the string passed
  MOV R3, R0        @ Store the pointer that came in into R3
  MOV R1, #0        @ To index into the string buffer
LoopStrlen0:
  LDRB R0,[R3, R1]  @ Access a char of the string into R0
  CMP R0, #0        @ Check if it is NULL
  BEQ LeaveStrlen0
  ADD R1, R1, #1    @ Increment the index to access the next char
  B LoopStrlen0      @ Scan the entire string until NULL is encountered
  
LeaveStrlen0:
  MOV R0, R1        @ The index is sams as the number of chars seen in the buffer so far
  BX LR             @ Return to the calling function



strcpy_asm:   
  MOV R3, #0        
  
LoopStrcpy:
  LDRB R2, [R1,R3]
  CMP R2, #0
  BEQ LoopStrcpyEnd
  LDRB R2, [R1,R3]
  STRB R2, [R0,R3]
  ADD R3,R3,#1
  B LoopStrcpy

LoopStrcpyEnd:
  BX LR



strncpy_asm:
  PUSH {R4}
  MOV R3, #0

LoopStrncpy:
  LDRB R4, [R1,R3]
  CMP R4, #0
  BEQ LoopStrncpyEnd 
  CMP R3, R2
  BEQ LoopStrncpyEnd
  LDRB R4, [R1,R3]
  STRB R4, [R0,R3]
  ADD R3,R3,#1
  B LoopStrncpy
  
LoopStrncpyEnd:
  MOV R4, #0
  STRB R4,[R0,R3]
  POP {R4}
  BX LR



strcmp_asm:
  PUSH {R4}
  MOV R3, #0
 
LoopStrcmp:
  LDRB R4, [R0,R3]
  CMP R4, #0
  BEQ LoopStrcmpEnd
  LDRB R2, [R1,R3]
  CMP R4, #0
  BEQ LoopStrcmpEnd
  CMP R4, R2
  BNE LoopStrcmpEnd
  ADD R3, R3, #1
  B LoopStrcmp

LoopStrcmpEnd:
  SUB R0, R4, R2
  POP {R4}
  BX LR



strncmp_asm:
  PUSH {R4}
  PUSH {R5}
  MOV R3, #0
  
LoopStrncmp:
  CMP R3, R2
  BEQ LoopStrncmpEnd
  LDRB R4, [R0,R3]
  LDRB R5, [R1,R3]
  CMP R4, #0
  BEQ LoopStrncmpEnd
  CMP R5, #0
  BEQ LoopStrncmpEnd
  CMP R4, R5
  BNE LoopStrncmpEnd
  ADD R3, R3, #1
  B LoopStrncmp
  
LoopStrncmpEnd:
    SUB R0, R4, R5
    POP {R5}
    POP {R4}
    BX LR



strcat_asm:
  PUSH {R4}
  MOV R3, #0
  MOV R4, #0
  
Loop1Strcat:
  LDRB R2, [R0,R3]
  CMP R2, #0
  BEQ Loop2Strcat
  ADD R3, R3, #1
  B Loop1Strcat

Loop2Strcat:
  LDRB R2, [R1,R4]
  STRB R2, [R0,R3]
  CMP R2, #0
  BEQ LoopStrcatEnd
  ADD R4, R4, #1
  ADD R3, R3, #1
  B Loop2Strcat
  
LoopStrcatEnd:
  POP {R4}
  BX LR


@ Data section starts here ...
.data
.align  4 @ necessary alignment to have variables which are aligned on 4 bytes boundary

.end  

@ End of Data segment
