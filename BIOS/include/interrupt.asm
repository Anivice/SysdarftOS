;
; interrupt.asm
;
; This file defines basic interrupt routine handler for BIOS
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

%ifndef _INTERRUPT_ASM_
%define _INTERRUPT_ASM_

.equ 'DO_TELETYPE',         'int <$8( 0x10 )>'
.equ 'DO_SET_CUR_POS',      'int <$8( 0x11 )>'
.equ 'DO_SET_CUR_VSB',      'int <$8( 0x12 )>'
.equ 'DO_NEWLINE',          'int <$8( 0x13 )>'
.equ 'DO_GETC',             'int <$8( 0x14 )>'
.equ 'DO_GET_CUR_POS',      'int <$8( 0x15 )>'
.equ 'DO_GET_MEM_SIZE',     'int <$8( 0x16 )>'
.equ 'DO_RINGBELL',         'int <$8( 0x17 )>'
.equ 'DO_REFRESH',          'int <$8( 0x18 )>'
.equ 'DO_FLUSH_INPUT',      'int <$8( 0x19 )>'

%endif ; _INTERRUPT_ASM_
