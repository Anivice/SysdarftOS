; printf.asm
;
; Copyright 2025 Anivice Ives
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;
; SPDX-License-Identifier: GPL-3.0-or-later
;

%include "interrupt.asm"
%include "width.asm"

; print_num(%fer0)->void, print a number
print_num:
    pushall                                 ; preserve CPU state
    xorq        <%fer3>,    <%fer3>         ; digit counter
    .loop_divide:                           ; loop divide
        divq    <$64(10)>                   ; divide %fer0 by 10
        pushq   <%fer1>                     ; push the reminder to the stack
        incq    <%fer3>                     ; increase the value in the counter
        cmpq    <%fer0>,    <$64(0)>        ; see if %fer0 is 0
        jne     <.loop_divide>              ; if it's 0, loop divide
    .loop_print:                            ; loop print, with %fer3 being the counter
        popq    <%fer0>                     ; retrieve the previously saved digit
        addq    <%fer0>,    <$64('0')>      ; convert the digit to ASCII
        int     <$8(0x10)>                  ; GPU teletype
        loop    <.loop_print>               ; loop when %fer3 is not 0
    popall                                  ; restore CPU state
    ret                                     ; return


; print_string(%db:%dp)->void, print null terminating string
print_string:
    pushall                                                                 ; preserve CPU state
    xorw        <%exr0>,    <%exr0>                                         ; clear %exr0 for ASCII store
    .loop:                                                                  ; loop printer
        movb    <%r0>,      <*1&8(%db, %dp, $8(0))>                         ; move %db:%dp to %R0
        cmpb    <%r0>,      <$8(0)>                                         ; see if it's 0
        je      <.end>                                                      ; it is, end
        int     <$8(0x10)>                                                  ; teletype
        incq    <%dp>                                                       ; move to next character
        jmp     <.loop>                                                     ; continue
    .end:                                                                   ; end loop
    popall                                                                  ; restore CPU state
    ret                                                                     ; return

; printf(%db:%dp)->void, print formatted pattern
printf:
    pushall                                                                 ; preserve CPU state
    lea         <%ep>,      <*1&8(%sp, $16(192), $8(16))>                   ; %ep = %sp + 192 + 16 (all registers)
    movq        <%eb>,      <%sb>                                           ; move stack base to %eb
    xorw        <%exr0>,    <%exr0>                                         ; clear %exr0 for ASCII store
    .loop:                                                                  ; loop printer
        movb    <%r0>,      <*1&8(%db, %dp, $8(0))>                         ; move %db:%dp to %R0
        cmpb    <%r0>,      <$8(0)>                                         ; see if it's 0
        je      <.end>                                                      ; it is, end
        ; now, we determine the type of the character:
        ; case 1: '%'
        cmpb    <%r0>,      <$8('%')>                                       ; see if it's '%'
        je      <.escaped>                                                  ; yes, escape

        .normal:
        int     <$8(0x10)>                                                  ; normal character, teletype
        jmp     <.print_end>                                                ; end current loop

        .escaped:
            incq    <%dp>                                                   ; move to next character
            movb    <%r0>,      <*1&8(%db, %dp, $8(0))>                     ; move %db:%dp to %R0
            cmpb    <%r0>,      <$8('s')>                                   ; see if %R0 is 's'
            je      <.string>                                               ; yes, print string
            cmpb    <%r0>,      <$8('d')>                                   ; see if %R0 is 'd'
            je      <.number>                                               ; yes, print number
            jmp     <.normal>                                               ; normal print

            .string:
                pushq   <%db>                                               ; preserve %db
                pushq   <%dp>                                               ; preserve %dp

                movq    <%dp>,  <*1&64(%eb, %ep, $8(0))>                    ; pop64 %dp
                addq    <%ep>,  <$64(8)>
                movq    <%db>,  <*1&64(%eb, %ep, $8(0))>                    ; pop64 %db
                addq    <%ep>,  <$64(8)>
                call    <print_string>                                      ; print_string

                popq    <%dp>                                               ; restore %dp
                popq    <%db>                                               ; restore %db
                jmp     <.print_end>                                        ; continue

            .number:
                pushq   <%fer0>                                             ; preserve %fer0
                movq    <%fer0>,    <*1&64(%eb, %ep, $8(0))>                ; pop64 %fer0
                addq    <%ep>,      <$64(8)>
                call    <print_num>                                         ; print_num
                popq    <%fer0>                                             ; restore %fer0
        .print_end:                                                         ; end of print
        incq    <%dp>                                                       ; move to next character
        jmp     <.loop>                                                     ; continue
    .end:                                                                   ; end loop
    popall                                                                  ; restore CPU state
    ret                                                                     ; return
