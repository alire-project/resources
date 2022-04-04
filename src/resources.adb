with Ada.Characters.Handling;

with GNAT.OS_Lib;
with GNAT.Strings;

with System;

with Interfaces.C;
with Interfaces.C.Strings;

package body Resources is

   function WAI_getExecutablePath
     (Output      : System.Address;
      Capacity    : Interfaces.C.int;
      Dirname_Len : access Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, WAI_getExecutablePath, "wai_alire_getExecutablePath");
   pragma Unreferenced (WAI_getExecutablePath);

   function WAI_getModulePath
     (Output      : System.Address;
      Capacity    : Interfaces.C.int;
      Dirname_Len : access Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, WAI_getModulePath, "wai_alire_getModulePath");

   function Get_Prefix_From_Env return String;
   function Get_Prefix return String;

   -----------------
   -- Module_Path --
   -----------------

   function Module_Path return String is
      use Interfaces.C;
      use System;

      Expected_Len : int;
   begin

      --  First get the output length
      Expected_Len := WAI_getModulePath (Null_Address, 0, null);

      if Expected_Len > 0 then
         declare
            Dirname_Len : aliased int;
            Output : String (1 .. Natural (Expected_Len));
            Len : constant int :=  WAI_getModulePath (Output'Address,
                                                      Output'Length,
                                                      Dirname_Len'Access);
         begin
            if Len = Expected_Len then
               return Output (1 .. Natural (Dirname_Len));
            else
               raise Program_Error;
            end if;
         end;
      else

         --  We don't have any fallback if the module path cannot be retrieved
         raise Program_Error;
      end if;
   end Module_Path;

   -------------------------
   -- Get_Prefix_From_Env --
   -------------------------

   function Get_Prefix_From_Env return String is
      use Ada.Characters.Handling;
      use GNAT.Strings;

      Env_Prefix : GNAT.Strings.String_Access :=
        GNAT.OS_Lib.Getenv (To_Upper (Crate_Name) & "_ALIRE_PREFIX");

   begin

      if Env_Prefix /= null then
         return Result : String (1 .. Env_Prefix.all'Length) do
            Result := Env_Prefix.all;
            GNAT.Strings.Free (Env_Prefix);
         end return;
      else

         return "";
      end if;
   end Get_Prefix_From_Env;

   ----------------
   -- Get_Prefix --
   ----------------

   function Get_Prefix return String is
      From_Env : constant String := Get_Prefix_From_Env;
   begin
      if From_Env /= "" then
         return From_Env & "/";
      else
         return Module_Path & "/" & Module_To_Prefix &"/";
      end if;
   end Get_Prefix;

   Elab_Prefix_Path : constant String := Get_Prefix;

   -----------------
   -- Prefix_Path --
   -----------------

   function Prefix_Path return String is
   begin
      return Elab_Prefix_Path;
   end Prefix_Path;

   -------------------
   -- Resource_Path --
   -------------------

   function Resource_Path return String is
   begin
      return Prefix_Path & Resource_Dir_From_Prefix;
   end Resource_Path;

end Resources;
