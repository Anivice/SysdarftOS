;
; ioport.asm
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

%ifndef _IOPORT_ASM_
%define _IOPORT_ASM_

%define HDD_SECTOR_COUNT,   <$16( 0x136 )>
%define HDD_SECTOR_START,   <$16( 0x137 )>
%define HDD_OPERT_SECTOR,   <$16( 0x138 )>
%define HDD_DISK_OUTPUT,    <$16( 0x139 )>
%define HDD_DISK_INPUT,     <$16( 0x13A )>

%define FDA_SECTOR_COUNT,   <$16( 0x116 )>
%define FDA_SECTOR_START,   <$16( 0x117 )>
%define FDA_OPERT_SECTOR,   <$16( 0x118 )>
%define FDA_DISK_OUTPUT,    <$16( 0x119 )>
%define FDA_DISK_INPUT,     <$16( 0x11A )>

%define FDB_SECTOR_COUNT,   <$16( 0x126 )>
%define FDB_SECTOR_START,   <$16( 0x127 )>
%define FDB_OPERT_SECTOR,   <$16( 0x128 )>
%define FDB_DISK_OUTPUT,    <$16( 0x129 )>
%define FDB_DISK_INPUT,     <$16( 0x12A )>

%define RTC_TIME,           <$8( 0x70 )>
%define RTC_INTER,          <$8( 0x71 )>

%endif ; _IOPORT_ASM_
