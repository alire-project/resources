generic
   Crate_Name : String;
   --  MANDATORY: Name of the crate/project in lower case.

   Resource_Dir_From_Prefix : String := "share/" & Crate_Name & "/";
   --  OPTIONAL: Relative path from the prefix/installation dir to the resource
   --  folder. The default value provided here should work for all cases.

   Module_To_Prefix : String := "..";
   --  OPTIONAL: Relative path from the directory where the module (shared
   --  library or exectuable) is located to the prefix/installation dir.
   --  The default value provided here should work for all cases, i.e.
   --  when executables are installed in bin/ and libraries in lib/ or lib64/.

package Resources with SPARK_Mode => On is

   function Executable_Path return String;
   --  Return the absolute path to the running binary

   function Prefix_Path return String;
   --  Return an absolute path to the prefix/installation directory

   function Resource_Path return String;
   --  Return an absolute path to the resource directory

end Resources;
