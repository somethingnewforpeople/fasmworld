use16                	  	 	 	; генерировать 16-битный код
org 100h             	 		 	; программа начинается с адреса 100h
;------------------------------------
	movzx cx, [n]				; копирование значения n в cx с расширением 0
	mov ax, 2 				; копирование 2 в ax
	mul cx 					; умножение ax на cx, результат в ax из за размера массивов
	mov di, ax				; копирование ax в di


lp:						; метка lp для вычитания значений массивов
	mov ax, word[f_array+di-2]		; копирование слова f_array со смещение di-2
	sub ax, word[s_array+si] 		; вычитание ax и слова s_array со смещением si
	mov word[res+si], ax 			; копирование ax в слово+si res
	add si, 2				; сложение si и 2 для смещения
	sub di, 2 				; вычитание di и 2 для смещения
	loop lp 				; итерация по значению в cx
 
    mov ax,4C00h    	 			; завершение программы
    int 21h       	  	 		; завершение программы
;------------------------------------
f_array dw -1111,2222,-3333,4444

s_array dw 1111,-2222,3333,-4444

n db 4

res dw 4 dup(?)
;------------------------------------
;Объявите в программе два массива 16-битных целых со знаком. Количество элементов массивов должно быть одинаковым и храниться в 8-битной переменной без знака. Требуется из последнего элемента второго массива вычесть первый элемент первого, из предпоследнего — вычесть второй элемент и т.д.
