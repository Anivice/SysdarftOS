;
; width.asm
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

%ifndef _WIDTH_ASM_
%define _WIDTH_ASM_

.equ 'jmp',         'jmp        <%cb>, '
.equ 'je',          'je         <%cb>, '
.equ 'jne',         'jne        <%cb>, '
.equ 'jb',          'jb         <%cb>, '
.equ 'jbe',         'jbe        <%cb>, '
.equ 'jl',          'jl         <%cb>, '
.equ 'jle',         'jle        <%cb>, '
.equ 'loop',        'loop       <%cb>, '
.equ 'call',        'call       <%cb>, '

.equ 'addb',        'add .8bit      '
.equ 'addw',        'add .16bit     '
.equ 'addd',        'add .32bit     '
.equ 'addq',        'add .64bit     '

.equ 'subb',        'sub .8bit      '
.equ 'subw',        'sub .16bit     '
.equ 'subd',        'sub .32bit     '
.equ 'subq',        'sub .64bit     '

.equ 'adcb',        'adc .8bit      '
.equ 'adcw',        'adc .16bit     '
.equ 'adcd',        'adc .32bit     '
.equ 'adcq',        'adc .64bit     '

.equ 'sbbb',        'sbb .8bit      '
.equ 'sbbw',        'sbb .16bit     '
.equ 'sbbd',        'sbb .32bit     '
.equ 'sbbq',        'sbb .64bit     '

.equ 'mulb',        'mul .8bit      '
.equ 'mulw',        'mul .16bit     '
.equ 'muld',        'mul .32bit     '
.equ 'mulq',        'mul .64bit     '

.equ 'divb',        'div .8bit      '
.equ 'divw',        'div .16bit     '
.equ 'divd',        'div .32bit     '
.equ 'divq',        'div .64bit     '

.equ 'movb',        'mov .8bit      '
.equ 'movw',        'mov .16bit     '
.equ 'movd',        'mov .32bit     '
.equ 'movq',        'mov .64bit     '

.equ 'cmpb',        'cmp .8bit      '
.equ 'cmpw',        'cmp .16bit     '
.equ 'cmpd',        'cmp .32bit     '
.equ 'cmpq',        'cmp .64bit     '

.equ 'pushb',       'push .8bit     '
.equ 'pushw',       'push .16bit    '
.equ 'pushd',       'push .32bit    '
.equ 'pushq',       'push .64bit    '

.equ 'popb',        'pop .8bit      '
.equ 'popw',        'pop .16bit     '
.equ 'popd',        'pop .32bit     '
.equ 'popq',        'pop .64bit     '

.equ 'xorb',        'xor .8bit      '
.equ 'xorw',        'xor .16bit     '
.equ 'xord',        'xor .32bit     '
.equ 'xorq',        'xor .64bit     '

.equ 'andb',        'and .8bit      '
.equ 'andw',        'and .16bit     '
.equ 'andd',        'and .32bit     '
.equ 'andq',        'and .64bit     '

.equ 'orb',         'or .8bit       '
.equ 'orw',         'or .16bit      '
.equ 'ord',         'or .32bit      '
.equ 'orq',         'or .64bit      '

.equ 'decb',        'dec .8bit      '
.equ 'decw',        'dec .16bit     '
.equ 'decd',        'dec .32bit     '
.equ 'decq',        'dec .64bit     '

.equ 'incb',        'inc .8bit      '
.equ 'incw',        'inc .16bit     '
.equ 'incd',        'inc .32bit     '
.equ 'incq',        'inc .64bit     '

%endif ; _WIDTH_ASM_
