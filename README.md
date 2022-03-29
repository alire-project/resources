# Resources
Utility library to handle project resources at run-time

The `Resources` crate provides an common way to access project
resources/assets, i.e. non executable files of a project. For instance
templates, images, 3D models, so on and so forth.

# Usage 

## Store resources

The default, and recommended, location for resources/assets files is the
following: `<CRATE_ROOT>/share/<CRATE_NAME>/`

For instance, a crate named `my_crate` will have the following directory
structure:
```
+-- alire.toml
+-- my_crate.gpr
+-- share
|   +-- my_crate
|       +-- text_file.txt
+-- src
    +-- my_crate.adb
    +-- my_crate.ads
```

You can of course have sub-directories in `share/<CRATE_NAME>`.

## Specify resources location in GPR file

For the resources to be correctly installed with `gprinstall` add the
following lines to your project file:
```ada
   package Install is
      for Artifacts (".") use ("share");
   end Install;
```

This will tell `gprinstall` to copy the content of the `share` folder at the
root of the installation.

## Access resources from Ada code

To use `Resources`, instantiate the generic package `Resources` with your
crate/project name as a parameter:
```ada
with Resources;

procedure Main is
   package My_Resources is new Resources ("my_crate");
```
Using Alire crate config, the crate name is already provided:
```ada
with Resources;
with my_crate_Config;

procedure Main is
   package My_Resources is new Resources (my_crate_Config.Crate_Name);
```

From here, you can get the standard location of resources using the
`Resource_Path` function. The function returns and absolute path to the
`share/<CRATE_NAME>/` folder where you stored resources.

For example:
```ada
  Open (File, In_File, My_Resources.Resource_Path & "/text_file.txt");
```

# How does it work?

During development `Resources` will use a `<CRATE_NAME>_ALIRE_PREFIX`
environment variable, typically set by [Alire](https://alire.ada.dev), to find
the root directory of the crate. So `Resources` will work no matter how the
sources are checked out (e.g. in Alire cache folder, as a pin with relative
path, etc.).

After installation, i.e. when the env variable is not set, `Resources` will use
a relative path from the directory where the executable/shared library is
installed. This done using the [whereami](https://github.com/gpakosz/whereami)
C project, that provides an absolute path to the location of an executable or
shared library.
