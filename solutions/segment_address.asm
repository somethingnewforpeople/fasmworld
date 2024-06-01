format MZ 					; DOS EXE файл
entry main_seg:start 				; точка входа
stack 200h 					; размер стека

;-----------------------------------
; Сегмент данных
segment data_seg
first_seg db "first segment$"
second_seg db "second segment$"
third_seg db "third segment$"
var1 db 5
var2 db 10

;----------------------------------
; Главный сегмент кода
segment main_seg 				; сегмент кода
start: 						; старт выполнения программы
	mov ax, data_seg 			; \
	mov ds, ax				; /инициализация регистра ds(данные)

	mov al, [var1] 				; al = var1 для сравнения чисел
	cmp al, [var2] 				; сравнение al и var2
	jz t_seg_equal 				; переход на t_set_equal если al = var2
	jg t_seg_greater 			; переход на t_seg_greater если al > var2
	jmp f_seg:seg_less 			; переход на seg_less в f_seg, al < var2


t_seg_equal: 					; метка для var1 = var2
	jmp t_seg:seg_equal 			; переход на seg_equal в t_seg


t_seg_greater: 					; метка для var1 > var2
	jmp s_seg:seg_greater 			; переход на seg_greater в s_seg

	
exit: 						; метка конца программы
	mov ax, 4C00h 				; ax = функция DOS завершения программы
	int 21h 				; вызов функции DOS

;-----------------------------------
; Третий сегмент кода
segment t_seg 					; сегмент кода
seg_equal: 					; метка для var1 = var2
	mov dx, third_seg 			; dx = third_seg
	call seg_print:print 			; дальний вызов print в seg_print
	jmp main_seg:exit 			; переход на exit в main_seg

;-----------------------------------
; Второй сегмент кода
segment s_seg 					; сегмент кода
seg_greater: 					; метка для var1 > var2
	mov dx, second_seg 			; dx = second_reg
	call seg_print:print 			; дальний вызов print в seg_print
	jmp main_seg:exit 			; переход на exit в main_seg

;-----------------------------------
; Первый сегмент кода
segment f_seg 					; сегмент кода
seg_less: 					; метка для var1 < var2
	mov dx, first_seg 			; dx = first_seg
	call seg_print:print 			; дальний вызов print в seg_print
	jmp main_seg:exit 			; переход на exit в main_seg

;-----------------------------------
; Сегмент кода для вывода
segment seg_print 				; сегмент кода
print: 						; процедура вывода результата
	mov ah, 09h 				; ah = функция DOS для вывода строки
	int 21h 				; вызов функции DOS
	retf 					; возврат из дальнего вызова

;-----------------------------------
; Напишите программу, которая сравнивает две переменные и выполняет переход в другой сегмент в зависимости от результата сравнения. Если меньше, переход в сегмент 1. Если больше — в сегмент 2. Иначе в сегмент 3.
