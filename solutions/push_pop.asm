use16								; генерированить 16-битный код(для DOS)
org 100h							; начало программы с адресса 100h
;-----------------------------------
	jmp start						; безусловный переход на метку start
;-----------------------------------
text db "$!olleH"
length db 7

rev_text db 7 dup(?)
;-----------------------------------
start:								; метка start для начала программы
	movzx cx, [length] 				; копирование length в cx с расширением без знака
	xor si, si 						; обнуление si для смещений


push_stack: 						; метка push_stack для отправки значений в стек
	movzx ax, [text+si]	 			; копирование text со смещением si в ax с расширением
	inc si 							; увеличение si на 1 для смещений
	push ax 						; отправка ax в стек
	loop push_stack 				; итерация по метке push_stack
	movzx cx, [length] 				; копирование length в cx с расширением без знака
	xor si, si 						; обнуление si для смещений


pop_stack: 							; метка pop_stack для возврата значения из стека
	pop ax 							; возврат значения из стека в ax
	mov byte[rev_text+si], al 		; сохранение результата байта в rev_text со смещением si
	inc si 							; увеличение si на 1 для смещений
	loop pop_stack 					; итерация по метке pop_stack


print_rev_text: 					; метка print_rev_text для вывода
	mov dx, rev_text 				; копирование адреса rev_text в dx
	mov ah, 09h 					; ah=09h - функция DOS для вывода строки
	int 21h 						; вызов функции DOS


exit:
	mov ax, 4C00h					; ah - завершение программы DOS, al - код завершения
	int 21h							; вызов функции DOS
;-----------------------------------
; Объявите в программе строку «$!olleH». Напишите код для переворачивания строки с использованием стека (в цикле поместите каждый символ в стек, а затем извлеките в обратном порядке). Выведите полученную строку на экран.
