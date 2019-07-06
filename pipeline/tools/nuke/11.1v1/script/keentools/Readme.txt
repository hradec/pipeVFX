FAQ:

1) Q: What is the simplest way to install KeenTools?
   A: The simplest way to install KeenTools is to run the installer.

2) Q: What exactly does the installer do?
   A: The installer copies KeenTools files to Nuke plugins directory:
      - OSX: "/Library/Application Support/NUKE/x.x/plugins/"
      - Linux: "/usr/local/NUKE/x.x/plugins/"
      - Windows: "C:\Program Files\Common Files\NUKE\x.x\plugins\"
      where "x.x" is Nuke version (10.5 for example).

3) Q: How to uninstall KeenTools?
   A: Remove KeenTools folder from Nuke plugins directory to uninstall KeenTools.

4) Q: Is it possible to use KeenTools with NUKE Non-commercial?
   A: No, Non-commercial version doesn't support third-party plug-ins.

5) Q: I have a feature request or found a bug, how can I submit it?
   A: We'd appreciate it if you submit it to our issue tracker: "https://youtrack.jetbrains.com/issues/OT".
      You may have to log in using your google account or sign up to create an issue.
      Please specify KeenTools and Nuke versions and your OS in the description.

6) Q: What is "manual" directory for?
   A: "manual" directory is only for performing manual installation. It isn't required if you're using the installer.

7) Q: How can I contact you if I have a question or a problem?
   A: Feel free to contact us at "keenvfx@gmail.com".

8) Q: How can I perform manual installation
   A: - copy KeenTools folder from "manual" directory to any place you want
      - add the path to KeenTools folder to Nuke path by adding "nuke.pluginAddPath('PATH_TO_KEENTOOLS')" to init.py file

9) Q: How can I perform manual installation working for multiple Nuke versions and operating systems?
   A: - copy KeenTools folders from "manual" directories for every Nuke version and operating system you want to any place you want
      - add the path to all that folders to Nuke path

   For example if you want to work with different versions of Nuke on Windows with the same manual installation you may
      - unpack WIN_KEEN_TOOLS.zip to C:/KeenTools (could be any directory)
      - write the next lines to %HOMEPATH%/.nuke/init.py:
         nuke.pluginAddPath('C:/KeenTools/NUKE8.0/manual/KeenTools')
         nuke.pluginAddPath('C:/KeenTools/NUKE9.0/manual/KeenTools')
         nuke.pluginAddPath('C:/KeenTools/NUKE10.0/manual/KeenTools')
         nuke.pluginAddPath('C:/KeenTools/NUKE10.5/manual/KeenTools')
   KeenTools will automatically choose which installation should be loaded

10) Q: How can I customize KeenTools menu?
   A: You can find menu.py file in KeenTools directory and edit it as you see fit.
