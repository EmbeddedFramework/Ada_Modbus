------------------------------------------------------------------------------
-- Copyright 2024, Gustavo Muro
-- Copyright (C) 2008, AdaCore
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

with AUnit;
with AUnit.Simple_Test_Cases;
with MB_Types;
with MB_Transport;
with Ada.Real_Time; use Ada.Real_Time;

package Mb_Master_F0x10_Test is

   type Test is new AUnit.Simple_Test_Cases.Test_Case with null record;

   function Name (T : Test) return AUnit.Message_String;

   procedure Run_Test (T : in out Test);

private

   type My_MB_Transport_Type is new
     MB_Transport.MB_Transport_Type (256) with record
      null;
   end record;

   procedure Send (Self : in out My_MB_Transport_Type;
                   Buffer : MB_Types.Byte_Array;
                   Length : MB_Transport.Msg_Length);

   overriding
   function Recv (Self : in out My_MB_Transport_Type;
                  Timeout : Time_Span) return MB_Transport.Msg_Length;

end Mb_Master_F0x10_Test;
