------------------------------------------------------------------------------
-- Copyright 2024, Gustavo Muro
-- All rights reserved
--
-- This file is part of EmbeddedFirmware.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
--
-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
-- 3. Neither the name of the copyright holder nor the names of its
--    contributors may be used to endorse or promote products derived from this
--    software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
------------------------------------------------------------------------------

with MB_Types;
with MB_Transport;
with MB_Serial_CB; use MB_Serial_CB;
with Ada.Real_Time; use Ada.Real_Time;

package MB_Ascii is

   Msg_Max_Length : constant Integer := 1 + (MB_Transport.Msg_Max_Length+1) * 2 + 2;

   type MB_Ascii_Type(Recv : MB_Serial_CB.Recv_CB;
                      Send : MB_Serial_CB.Send_CB) is
     new MB_Transport.MB_Transport_Type with record
      Serial_Recv : MB_Serial_CB.Recv_CB := Recv;
      Serial_Send : MB_Serial_CB.Send_CB := Send;
      Buffer : MB_Types.Byte_Array(1 .. Msg_Max_Length) := (others => 0);
   end record;

   overriding
   procedure Send (Self : in out MB_Ascii_Type ;
                   Buffer : MB_Types.Byte_Array ;
                   Length : MB_Transport.Msg_Length);

   overriding
   function Recv (Self : in out MB_Ascii_Type ; Timeout : Time_Span) return MB_Transport.Msg_Length;

end MB_Ascii;
