with Resources;

with Lib_A;

with Ada.Text_IO;

procedure Tests is
   package My_Resources is new Resources ("tests");

begin
   Ada.Text_IO.Put_Line ("Prefix_Path: " & My_Resources.Prefix_Path);
   Ada.Text_IO.Put_Line ("Lib_A Prefix_Path: " & Lib_A.Resources.Prefix_Path);

   Ada.Text_IO.Put_Line ("Test Resource_Path: " & My_Resources.Resource_Path);
   Ada.Text_IO.Put_Line ("Lib_A Resource_Path: " & Lib_A.Resources.Resource_Path);
end Tests;
