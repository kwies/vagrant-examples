lampX
=====

Vagrant example for a simple LAMP-Stack (http://en.wikipedia.org/wiki/LAMP_%28software_bundle%29)

The example contains:
 - Ubuntu 14.04 Server
 - PHP (suphp)
 - Java, Tomcat, mod_jk
 - Python, mod_wsgi

Getting started: 
 - Checkout 
 - Start VM: 
   $ cd /path/to/this/dir
   $ vagrant up
 - Open Browser in your host: http://localhost:8080

Customization
 - Customize install script (THISDIR/config/shell/custom.sh)
 - Add your application source in source folder 
 - Customize apache config (THISDIR/config/files/apache/)
 - Destroy and start VM
   $ cd /path/to/this/dir
   $ vagrant destroy
   $ vagrant up
