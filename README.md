# Udemy class on Bash shell scripting

 Udemy class on Bash shell scripting, taught by Jason Cannon of
 LinuxTrainingAcademy.com.  Interesting class so far; class is taught by
 using a virtual box running Centos7.  Just now getting into it.  
 
 I'll be bouncing around between several Linux boxes, so I thought I'd
 better create a repo for the class.  

 ## Virtualbox and Vagrant requirements

 One thing to note is that while there are instructions for installing
 Vagrant and Virtual box for Windows and Mac, and also Centos/RedHat
 Linux, other distros are omitted.  

 So far I'm not running the course on a Red Hat or Centos7 box, so I've
 had to find my instructions for installing Virtualbox and Vagrant for
 my particular Linux distros that I use.  I do *not* follow the
 instructions for installing according to the class notes.  If you do,
 you'll risk damaging your system or create some sort of mess.  Just
 use your distro's installation documentation for installing these two
 dependencies.  The first couple of lessons help test out your
 installation.  You also might have to make sure that virtual machines
 are enabled in the BIOS, which they probably are on a newer 64-bit box.

 The Arch-based distros seem to like a reboot after installing their
 packages, and inserting the `vboxdrv` module right away did *not* work
 for me.  However, once I did a `lsmod` after a reboot, I saw that all
 my virtualbox modules had been loaded.  This was Antergos and Manjaro.
 (I had to edit a modules.conf file for the virtualbox service on
 Antergos.)

 Once you get Vagrant and Virtualbox installed, you'll need to add a
 particular box to Vagrant:

 ```vagrant box add jasonc/centos7```



 ## Early Impression

 So far so good.  The guy sounds like an experienced Linux guy.  He's
 already identified several things that are "the old way" of doing
 things, which I didn't know.  I'll be curious to find out the history
 of some of the conventions, such as `[[` instead of `[` as a shell
 built-in.  
