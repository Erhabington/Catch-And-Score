[org 0x0100]
jmp start

message: db 'Press Any Key To Continue'
length: dw 25
gamename: db 'Catch & Score'
namelength: dw 13
ob1: db '10 point'
l1: dw 8
ob2: db '5 Point'
l2: dw 7
ob3: db '15 point'
l3: dw 8
Bomb: db 'game end'
l4: dw 8
msg2: db 'Score: '
len2: dw 7
scoreValue: dw 0
scoreValueDi: dw 300
bucketLeftDi: dw 0
bucketBaseDi: dw 0
bucketRightDi: dw 0
seconds: dw 0
minutes: dw 0
message2: db 'Your score is: ' 
length2: dw 15
message4: db 'Thank You For Playing!'
length4: dw 22
delay: dw 1
scrollDelay: dw 1

;random number generator for object spawning using system timer
randgen:    
mov ah,00h
int 1ah
mov ax,dx 
xor dx,dx
mov cx,4
div cx
add dl, '0'
ret

;random number generator for object position using system timer
randgen2:
mov ah,00h
int 1ah
mov ax,dx 
xor dx,dx
mov cx,136
div cx
add dl,10
ret

printstr:
push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax
mov al,80
mul byte [bp+10]
add ax,[bp+12]
shl ax,1
mov di,ax
mov si,[bp+6]
mov cx,[bp+4]
mov ah,[bp+8]

nextchar15: 
mov al, [si]
mov [es:di], ax
add di, 2 
add si, 1 
loop nextchar15 
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10

printgameover: 
push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax
mov al,80
mul byte [bp+10] ;left
add ax,[bp+12] ;top
shl ax,1
mov di,ax
mov cx,4
mov ah,[bp+8] ;color

next:
mov al,42
mov[es:di],ax
add di,4 ;increment rightward
loop next

sub di,16
mov cx,[bp+6]

nextchar: 
mov al, 42
mov [es:di], ax
add di, 160 ;increment downwards

loop nextchar

mov cx,[bp+4] ;right

nextchar2:
mov [es:di], ax 
add di, 4 ;increment next position

loop nextchar2

mov cx,2

nextchar3:
mov [es:di], ax
sub di, 160 ;decrement upwards

loop nextchar3

mov cx,2

nextchar4: 
mov [es:di], ax 
sub di, 4 ;decrement left wards

loop nextchar4

;printing A

sub di,460
mov cx,6

nextchar5:
mov al,47
mov [es:di],ax 
add di,158 ;slant left
loop nextchar5

sub di,946  
mov cx,6

nextchar6:
mov al,92
mov [es:di],ax
add di,162 ;slant right
loop nextchar6

sub di,488
mov cx,3

nextchar7:
mov al,42
mov [es:di],ax
sub di,4 ;decrement leftwards
loop nextchar7

;Printing M

add di,340
mov cx,5

nextchar8:
mov al,124
mov [es:di],ax
sub di,160 ;decrement upwards
loop nextchar8

mov cx,6

nextchar9:
mov al,92
mov[es:di],ax
add di,162 ;slant down right
loop nextchar9

sub di,162
mov cx,5

nextchar10:
mov al,47
mov[es:di],ax
sub di,158 ;slant up right
loop nextchar10

mov cx,6


nextchar11:
mov al,124
mov[es:di],ax
add di,160 ;increment downwards
loop nextchar11

;Printing E

sub di,152
mov cx,3

nextchar12:
mov al,42
mov[es:di],ax
add di,4
loop nextchar12

sub di,324
mov cx,3

nextchar13:
mov[es:di],ax
sub di,4
loop nextchar13

sub di,480
mov cx,6

nextchar31:
mov[es:di],ax
add di,160
loop nextchar31

sub di,956
mov cx,3

nextchar14:
mov al,42
mov[es:di],ax
add di,4
loop nextchar14

;Printing O

add di,4
mov cx,5

nextchar16:
mov al,42
mov[es:di],ax
add di,160
loop nextchar16

mov cx,4

nextchar17:
mov[es:di],ax
add di,4
loop nextchar17

mov cx,6

nextchar18:
mov[es:di],ax
sub di,160
loop nextchar18

add di,160
mov cx,4

nextchar19:
mov[es:di],ax
sub di,4
loop nextchar19

;Printing V
add di,16
mov cx,6

nextchar20:
mov al,92
mov[es:di],ax
add di,162 ;slant right
loop nextchar20

sub di,160
mov cx,6

nextchar21:
mov al,47
mov[es:di],ax
sub di,158 ;slant up right
loop nextchar21

;Printing E

add di,160
mov cx,6

nextchar22:
mov al,42
mov[es:di],ax
add di,160
loop nextchar22

sub di,160
mov cx,4

nextchar23:
mov[es:di],ax
add di,4
loop nextchar23

sub di,324
mov cx,3

nextchar24:
mov[es:di],ax
sub di,4
loop nextchar24

sub di,480
mov cx,4

nextchar25:
mov[es:di],ax
add di,4
loop nextchar25

;Printing R

add di,2
mov cx,6

nextchar26:
mov[es:di],ax
add di,160
loop nextchar26

sub di,960
mov cx,4

nextchar27:
mov[es:di],ax
add di,4
loop nextchar27

sub di,4
mov cx,3

nextchar28:
mov[es:di],ax
add di,160
loop nextchar28

sub di,160
mov cx,3

nextchar29:
mov[es:di],ax
sub di,4
loop nextchar29

mov cx,4

nextchar30:
mov[es:di],ax
add di,164
loop nextchar30

pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10

ending:
call clrscr
call bottomgreen
mov ax, 27
push ax
mov ax,13
push ax
mov ax,18 ;color
push ax
mov ax,message2
push ax
push word[length2]
call printstr
mov ax, 27 
push ax
mov ax,15
push ax
mov ax,18 ;color
push ax
mov ax,message4
push ax
push word[length4]
call printstr
mov ax,2 ;top position
push ax 
mov ax,2 ;left position
push ax
mov ax,28 ; color
push ax
mov ax,5 ;bottom
push ax
mov ax,3 
push ax
call printgameover
mov ax,[scoreValue]
ret

clrscr:
mov ax,0xb800
mov es,ax
mov di,0
nextcharz:
mov word[es:di],0x1620
add di,2
cmp di,4000
jne nextcharz
ret

clearLast3:
mov ax,0xb800
mov es,ax
mov di,2878
nextBlue:
mov word[es:di],0x1620
add di,2
cmp di,3358
jne nextBlue
ret

bottomgreen:
mov ax,0xb800
mov es,ax
mov di,3360
NextChar:
mov word[es:di],0x2520
add di,2
cmp di,4000
jne NextChar
ret

print:
mov ax, 0xb800 
mov es, ax
mov di, 1974
mov si,message
mov cx,[length]
mov ah,146
nextz:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextz

printname:
mov ax, 0xb800 
mov es, ax
mov di, 384
mov si,gamename
mov cx,[namelength]
mov ah,18
nextc:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextc
ret

;------------

obj1:
mov ax, 0xb800 
mov es, ax
mov di, 700
mov ax,0x142A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

obj2:
mov ax, 0xb800 
mov es, ax
mov di, 670
mov ax,0x162A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

bomb:
mov ax, 0xb800 
mov es, ax
mov di, 760
mov ax,0x102A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

obj3:
mov ax, 0xb800
mov es, ax
mov di, 726
mov ax,0x1D2A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
sub di,6
add di,160
mov [es:di],ax
add di,160
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
sub di,160
mov [es:di],ax
ret

;------------

newobj1:
mov ax, 0xb800 
mov es, ax
mov di,dx
mov ax,0x142A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

newobj2:
mov ax, 0xb800 
mov es, ax
mov di,dx
mov ax,0x162A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

newobj3:
mov ax, 0xb800
mov es, ax
mov di,dx
mov ax,0x1D2A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
sub di,6
add di,160
mov [es:di],ax
add di,160
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
sub di,160
mov [es:di],ax
ret

newbomb:
mov ax, 0xb800 
mov es, ax
mov di,dx
mov ax,0x102A
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,2
mov [es:di],ax
add di,156
mov [es:di],ax
add di,2
mov [es:di],ax
ret

;------------

p1:
mov ax, 0xb800 
mov es, ax
mov di, 1028
mov si,ob1
mov cx,[l1]
mov ah,0x14
nexT:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nexT
ret

p2:
mov ax, 0xb800 
mov es, ax
mov di, 1000
mov si,ob2
mov cx,[l2]
mov ah,0x16
next1:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop next1
ret

p3:
mov ax, 0xb800 
mov es, ax
mov di, 1056
mov si,ob3
mov cx,[l3]
mov ah,0x1D
nexT1:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nexT1
ret

p4:
mov ax, 0xb800 
mov es, ax
mov di, 1086
mov si,Bomb
mov cx,[l4]
mov ah,0x10
neXT1:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop neXT1
ret

;------------

;in order to not get odd values in di

add1:
add dl,1
jmp back

add2:
add dl,1
jmp back2

add3:
add dl,1
jmp back3

add4:
add dl,1
jmp back4

genobj1:
sub word[delay],1
jnz notyet
mov word[delay],28
call randgen2
test dl,1
jnz add1
back:
add dx,320 ;to print below "score"
call newobj1
notyet:
ret

genobj2:
sub word[delay],1
jnz notyet2
mov word[delay],28
call randgen2
test dl,1
jnz add2
back2:
add dx,320
call newobj2
notyet2:
ret

genobj3:
sub word[delay],1
jnz notyet3
mov word[delay],28
call randgen2
test dl,1
jnz add3
back3:
add dx,320
call newobj3
notyet3:
ret

genbomb:
sub word[delay],1
jnz notyet4
mov word[delay],28
call randgen2
test dl,1
jnz add4
back4:
add dx,320
call newbomb
notyet4:
ret

;------------

objectspawner:
call randgen
cmp dl,'0'
jne nextcomp
call genobj1

nextcomp:
cmp dl,'1'
jne nextcomp2
call genobj2

nextcomp2:
cmp dl,'2'
jne nextcomp3
call genobj3

nextcomp3:
cmp dl,'3'
jne nomatch2
call genbomb

nomatch2:
ret

;------------

startScreen:
call bottomgreen
call print
call printname
call obj1
call obj2
call bomb
call obj3
call p1
call p2
call p3
call p4
ret

PressAnyKey:
mov ah,0
int 16h
ret

GameScreen:
call clrscr
call bottomgreen
call bucketl
call bucketb
call bucketr
call printText
ret

printText:
mov ax, 0xb800 
mov es, ax
mov di, 262
mov si,msg2
mov cx,[len2]
mov ah,18
nextcH:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextcH
ret

bucketl:
mov ax,0xb800
mov es,ax
mov di,3426
mov [bucketLeftDi],di
mov cx,3
nextAsterick:
mov word[es:di],0x247C
add di,160
loop nextAsterick
ret

bucketb:
mov ax,0xb800
mov es,ax
mov di,3906
mov [bucketBaseDi],di
mov cx,7
nextAsteric:
mov word[es:di],0x242A
add di,2
loop nextAsteric
ret

bucketr:
mov ax,0xb800
mov es,ax
mov di,3438
mov [bucketRightDi],di
mov cx,3
nextAstericK11:
mov word[es:di],0x247C
add di,160
loop nextAstericK11
ret

scroll:
push bp
mov bp,sp
push ax
push cx
push si
push di
push es
push ds
mov ax, 80 
mul byte [bp+4] 
push ax 
shl ax, 1  
mov si, 3358
sub si, ax 
mov cx, 1520
shr ax,1 
sub cx, ax 
mov ax, 0xb800
mov es, ax 
mov ds, ax 
mov di, 3358 
std 
rep movsw 
mov ax, 0x1620
pop cx
rep stosw
pop ds
pop es
pop di
pop si
pop cx
pop ax
pop bp
ret 2

checkColor:
cmp word[es:di],0x142A
jne checkNext
add word[scoreValue],10
call clearLast3
jmp Continue2
checkNext:
cmp word[es:di],0x162A
jne checkNext2
add word[scoreValue],5
call clearLast3
jmp Continue2
checkNext2:
cmp word[es:di],0x1D2A
jne checkNext3
add word[scoreValue],15
call clearLast3
jmp Continue2
checkNext3:
jmp cont

checkPoint:
mov cx,7
mov di,[bucketLeftDi]
sub di,160
CheckBlue:
cmp word[es:di],0x1620
jne checkColor
add di,2
loop CheckBlue
Continue2:
ret

moveBucketPos:
call bottomgreen
mov ax,0xb800
mov es,ax
mov di,[bucketLeftDi]
mov cx,3
nextAsterick1:
mov word[es:di],0x247C
add di,160
loop nextAsterick1
mov ax,0xb800
mov es,ax
mov di,[bucketRightDi]
mov cx,3
nextAstericK:
mov word[es:di],0x247C
add di,160
loop nextAstericK
mov ax,0xb800
mov es,ax
mov di,[bucketBaseDi]
mov cx,7
nextAsteric1:
mov word[es:di],0x242A
add di,2
loop nextAsteric1

call objectspawner

ret

PrintScoreEnd:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax 
mov ax, [bp+4] 
mov bx, 10 
mov cx, 0 
nextdigitz: 
mov dx, 0 
div bx 
add dl, 0x30 
push dx 
inc cx 
cmp ax, 0 
jnz nextdigitz
mov di, 2162
nextposz: 
pop dx 
mov dh, 18 
mov [es:di], dx 
add di, 2 
loop nextposz
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2

PrintScore:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax 
mov ax, [bp+4] 
mov bx, 10 
mov cx, 0 
nextdigit: 
mov dx, 0 
div bx 
add dl, 0x30 
push dx 
inc cx 
cmp ax, 0 
jnz nextdigit 
mov di, 274 
nextpos: 
pop dx 
mov dh, 18 
mov [es:di], dx 
add di, 2 
loop nextpos 
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2 

nomove:
add word[bucketRightDi],4
add word[bucketLeftDi],4
add word[bucketBaseDi],4
jmp nomatch

nomove2:
sub word[bucketRightDi],4
sub word[bucketLeftDi],4
sub word[bucketBaseDi],4
jmp nomatch

incMIN:
add word[minutes],1
mov word[seconds],0
jmp con

move:
call updatedTimer
mov ax, 0xb800
mov es, ax
in al, 0x60
cmp al, 75 ;left
jne nextcmp
sub word[bucketRightDi],4
sub word[bucketLeftDi],4
sub word[bucketBaseDi],4
cmp word[bucketLeftDi],3360
jb nomove
jmp nomatch
nextcmp:
cmp al, 77 ;right
jne nomatch
add word[bucketRightDi],4
add word[bucketLeftDi],4
add word[bucketBaseDi],4
cmp word[bucketLeftDi],3506
ja nomove2
nomatch:
sub word[scrollDelay],1
jnz notyet5
mov word[scrollDelay],5
mov ax,1
push ax
call scroll
call checkPoint
mov ax,[scoreValue]
push ax
call PrintScore
notyet5:
call moveBucketPos
ret

updatedTimer:
add word[seconds],1
cmp word[seconds],60
je incMIN
con:
cmp word[minutes],30
je cont
ret

moveBucket:
ll1:
mov ah,0x01
int 0x16
call move
mov cx,01h
mov dx,0h
mov ah,86h
int 15h
jmp ll1
ret

start:
call clrscr
call startScreen
call PressAnyKey
call GameScreen
call moveBucket
cont:
call ending
mov ax,[scoreValue]
push ax
call PrintScoreEnd

mov ax,0x4c00
int 21h