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

package MB_Slave is

   type Read_Holding_Registers is access procedure (
      Start      : MB_Types.Address;
      Quantity   : MB_Types.Quantity;
      Exception_Code : out MB_Types.Byte;
      Buffer     : out MB_Types.Holding_Register_Array
   );

   type Write_Holding_Registers is access procedure (
      Start      : MB_Types.Address;
      Quantity   : MB_Types.Quantity;
      Exception_Code : out MB_Types.Byte;
      Buffer     : in MB_Types.Holding_Register_Array
   );


   type Cmd_Type is record
      Cmd_0x03_Read_Holding_Reg    : Read_Holding_Registers;
      Cmd_0x10_Write_Holding_Reg   : Write_Holding_Registers;
   end record;

   -- Definición del tipo de acceso al registro
   type Cmd_Type_Ptr is access all Cmd_Type;

   -- Función que procesa el buffer
   function Process (
      Buffer     : in out MB_Types.Byte_Array;
      Start_PDU  : MB_Transport.Msg_Length;
      Cmd        : Cmd_Type_Ptr
   ) return MB_Transport.Msg_Length;

end MB_Slave;
