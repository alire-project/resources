with Ada.Text_IO; use Ada.Text_IO;

package body Lib_A is

   -------------------
   -- Print_Content --
   -------------------

   procedure Print_Content is
      File : File_Type;
   begin

      Open (File, In_File, Lib_A.Resources.Resource_Path & "/text_file.txt");

      while not End_Of_File (File) loop
         Put_Line (Get_Line (File));
      end loop;

      Close (File);
   end Print_Content;

end Lib_A;
