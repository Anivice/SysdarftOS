;
; main.asm
;
; This file defines BIOS setup routine
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


.org 0xC1800
%include "width.asm"
%include "stdio.asm"
%include "stack.asm"

jmp <_start>

_start:
    movq    <%sp>,          <$64(0xFFFF)>
    movq    <%sb>,          <_stack_begin>
    movq    <%dp>,          <_msg>
    pushq   <$64(123456789)>
    pushq   <$64(0)>
    pushq   <_hw>
    call    <printf>
    jmp     <$64(@)>

_msg:
.string <"%s: %d">
.8bit_data < 0 >

_hw:
.string <"Hello, World!">
.8bit_data < 0 >
