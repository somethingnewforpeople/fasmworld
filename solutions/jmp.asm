use16						; генерированить 16-битный код(для DOS)
org 100h					; начало программы с адресса 100h
;-----------------------------------
	jmp start				; безусловный переход на метку start
;-----------------------------------
a dw -9999
b dw 9999

aeqb db "a = b$"
agtb db "a > b$"
altb db "a < b$"
;-----------------------------------
start:						; метка start для начала программы
	mov ax, [a] 				; копирование a в ax
	cmp ax, [b]				; сравнение ax и b (ax-b)
	jz a_eq_b 				; условный переход по флагу z=1 на метку a_eq_b
	jg a_gt_b 				; условный переход по флагам z=0 и s=0 на метку a_gt_b
	jl a_lt_b 				; условный переход по флагам s!=o на метку a_lt_b


a_eq_b:
	mov dx, aeqb 				; копирование адреса aeqb в dx
	mov ah, 09h				; ah-09h функция DOS для вывода в консоль строки в dx
	int 21h					; вызов функции DOS
	jmp exit				; безусловный переход на метку exit


a_gt_b:
	mov dx, agtb 				; копирование адреса agtb в dx
	mov ah, 09h				; ah-09h функция DOS для вывода в консоль строки в dx
	int 21h					; вызов функции DOS 
	jmp exit 				; безусловный переход на метку exit


a_lt_b:
	mov dx, altb 				; копирование адреса altb в dx
	mov ah, 09h				; ah-09h функция DOS для вывода в консоль строки в dx
	int 21h					; вызов функции DOS 


exit:
	mov ax, 4C00h				; ah - завершение программы DOS, al - код завершения
	int 21h					; вызов функции DOS
;-----------------------------------
; Напишите программу для сравнения двух переменных со знаком a и b. В зависимости от результатов сравнения выведите «a < b», «a > b» или «a = b». Проверьте работу программы в отладчике.
