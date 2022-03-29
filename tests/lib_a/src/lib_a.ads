with lib_a_Config;
with Resources;

package Lib_A is

   package Resources is new Standard.Resources (lib_a_Config.Crate_Name);

   procedure Print_Content;

end Lib_A;
