use16							; генерированить 16-битный код(для DOS)
org 100h						; начало программы с адресса 100h
;-----------------------------------
	movzx cx, [n]				; копирование значения n в cx с расширением 0
	inc ax 				 		; инкремент ax
	mov bx, 3 				 	; копирование 3 в bx


lp: 							; метка lp для степени
	mul bx						; умножение ax и bx, dx-всегда будет 0
	loop lp 					; цикл на метку lp, кол-во итераций в cx


	mov [a], ax 				; копирование ax в a


	mov ax, 4C00h				; ah - завершение программы DOS, al - код завершения
	int 21h						; вызов функции DOS
;-----------------------------------
n db 7

a dw ?
;-----------------------------------
; Напишите программу для вычисления степени числа 3 по формуле a = 3n. Число a — 16-битное целое без знака, число n — 8-битное целое без знака (используйте n<11, чтобы избежать переполнения).
