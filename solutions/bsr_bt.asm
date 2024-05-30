;-----------------------------------
use16 									; генерировать 16-битный код для DOS
org 100h 								; начало программы с адреса 100h


start: 									; метка начала программы
	mov ax, 00000000b 					; ax = 0 для работы с битами 
	call task						 	; вызов процедуры task


exit: 									; метка завершения программы
	mov ax, 4C00h 						; завершение программы
	int 21h 							; вызов функции DOS


task:									; процедура сброса 7-го бита и включение 0-го бита
	bsr bx, ax 							; bx = номер бита = 1 в ax начиная со старшей части
	jz @f 	 							; переход на след. анон. метку если ax = 0
	btr ax, bx 							; проверка и сброс бита в ax но номеру в bx
	bsf bx, ax 							; bx = номер бита = 1 в ax начиная с младшей части
	jz @f 	 							; переход на след. анон. метку если ax = 0
	dec bx 								; bx = номер младшего нулевого бита в ax
	bts ax, bx 							; проверка и включение бита в ax по номеру в bx
	jmp .task_end 						; переход на task_end
@@: 									; анонимная метка для ax = 0
	bts ax, 0 							; младший нулевой бит в ax = 1
.task_end: 								; локальная метка конца процедуры
	ret 								; выход из процедуры
;-----------------------------------
; Напишите процедуру, которая сбрасывает старший единичный бит и устанавливает в единицу младший нулевой бит в регистре AX
