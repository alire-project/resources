with Ada.Text_IO; use Ada.Text_IO;

with Resources;
with Lib_A;
with Tests_Config;

procedure Tests is
   package My_Resources is new Resources (Tests_Config.Crate_Name);

begin
   Put_Line ("Prefix_Path: " & My_Resources.Prefix_Path);
   Put_Line ("Lib_A Prefix_Path: " & Lib_A.Resources.Prefix_Path);

   Put_Line ("Test Resource_Path: " & My_Resources.Resource_Path);
   Put_Line ("Lib_A Resource_Path: " & Lib_A.Resources.Resource_Path);

   Lib_A.Print_Content;
end Tests;
