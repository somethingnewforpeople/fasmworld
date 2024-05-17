use16						; генерированить 16-битный код(для DOS)
org 100h					; начало программы с адресса 100h
;-----------------------------------
	jmp start				; безусловный переход на метку start
;-----------------------------------
text db "hello fasmworld!$"
length db 15

encode_text db 15 dup(?),13,10,"$"
decode_text db 15 dup(?),13,10,"$"
;-----------------------------------
start:						; метка start для начала программы
	movzx cx, [length] 			; копирование length в cx с расширением без знака
	and si, 00h 				; обнуление si для смещений
	and dx, 00h 				; обнуление dx для сдвигов


encode: 					; метка encode для кодирования текста
	mov bx, cx 				; сохранение значения счетчика в bx
	mov al, byte[text+si] 			; копирование байта text со смещением si в al
	inc dx					; увеличиваем dx на 1 для сдвигов
	mov cx, dx 				; копирование dx в cx для сдвигов
	ror al, cl 				; циклический сдвиг вправо на cl бит
	mov byte[encode_text+si], al 		; копирование al в байт encode_text со смещением si
	mov cx, bx 				; возвращение счетчика в cx	
	inc si 					; увеличение si на 1 для смещений		
	cmp dx, 7 				; проверка dx == 7 для сброса значения сдвига
	jz return_dx 				; переход на метку return_dx при флаге z == 1
	loop encode 				; итерация по метке encode


print_encode:					; метка для вывода кодированного текста
	mov dx, encode_text 			; копирование адреса encode_text в dx
	mov ah, 09h 				; ah=09h - функция DOS для вывода в консоль
	int 21h 				; вызов функции DOS
	jmp init_decode	 			; переход на init_decode для декодидирования


return_dx: 					; метка return_dx для обнуления dx
	and dx, 00h 				; обнуление dx для сдвигов
	loop encode 				; итерация по метке encode
	jmp print_encode 			; переход на print_encode если cx == 0 после loop


init_decode: 					; метка init_decode для повторной инициализации
	movzx cx, [length] 			; копирование length в cx с расширением без знака
	and si, 00h 				; обнуление si для смещений
	and dx, 00h 				; обнуление dx для сдвигов


decode: 					; метка decode для декодирования
	mov bx, cx 				; сохранение значения счетчика в bx
	mov al, byte[encode_text+si] 		; копирование байта encode_text со смещением si в al
	inc dx					; увеличиваем dx на 1 для сдвигов
	mov cx, dx 				; копирование dx в cx для сдвигов
	rol al, cl 				; циклический сдвиг влево на cl бит
	mov byte[decode_text+si], al 		; копирование al в байт decode_text со смещением si
	mov cx, bx 				; возвращение счетчика в cx	
	inc si 					; увеличение si на 1 для смещений		
	cmp dx, 7 				; проверка dx == 7 для сброса значения сдвига
	jz return_decode_dx 			; переход на метку return_decode_dx при флаге z == 1
	loop decode 				; итерация по метке encode


print_decode:					; метка для вывода декодированного текста
	mov dx, decode_text 			; копирование адреса encode_text в dx
	mov ah, 09h 				; ah=09h - функция DOS для вывода в консоль
	int 21h 				; вызов функции DOS
	jmp exit	 			; переход на метку exit


return_decode_dx: 				; метка return_decode_dx для обнуления dx 
	and dx, 00h 				; обнуление dx для сдвигов
	loop decode				; итерация по метке decode
	jmp print_decode 			; переход на print_decode если cx == 0 после loop


exit:
	mov ax, 4C00h				; ah - завершение программы DOS, al - код завершения
	int 21h					; вызов функции DOS
;-----------------------------------
; Объявите в программе строку. Длина строки должна быть больше 8 символов и храниться в байте без знака. Напишите цикл для шифрования строки по алгоритму: первый символ циклически сдвигается вправо на 1 бит, второй символ — на 2 бита, …, 7-й — на 7 битов, 8-й — снова на 1 бит, 9-й на 2 бита и т.д. Затем напишите цикл для расшифровки строки и выведите её на экран.
