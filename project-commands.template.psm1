<#	
.Synopsis
Allows you to define the common commands for any development project (build, clean, rebuild, test, etc) and issues them
from any folder in the project hierarchy.  

.Description
Allows you to define the common commands for any development project (build, clean, rebuild, test, etc) and issues them
from any folder in the project hierarchy.  

If you have found this file and have no idea what it is for, this is the 'commands' file used by the project-commands 
powershell extension.  You can read more about it here: https://github.com/jbuedel/project-commands

The core idea of project-commands is that there is a series of core commands that are common to every software development 
configuration, regardless of language or platform.  These commands are:

	build -    compile, link, package, etc
	clean -    remove all temporary files and generally get the file system to a code only state
	rebuild -  clean, then build
	test -     run unit tests, acceptance tests, and any other tests a developer might run locally
	develop -  actually open up the code in the editor/ide of choice.
	setupdev - check for and install any dependencies not otherwise accounted for.  If they can't be installed, at least 
               report on the fact that they are required. 

The *implementation* of these is of course quite different between development environments. That is where project-commands
comes in. You define what command(s) should happen when a user issues a 'build' for instance.  But with project-commands 
no one has to ask "how do I build this?".  The answer is always "type build".
	
Implement each of the following functions as you see fit for your project.  For example, the 'develop_project' function 
would likely open a .sln file, choosing the proper version of Visual Studio if necessary.  That function might look like
this:

	function develop_project {
		devenv MySolution.sln
	}

Note that when these functions are invoked, the current working directory is always set to the root of the project (which
is where this file is as well).  Once the command exits the user will be returned to the directory they were in.

This file should be checked into your project's source control.

#>

function build_project { 
	write-host "The 'build' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the build_project function."
}
function test_project {
	write-host "The 'test' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the test_project function."
}
function clean_project {
	write-host "The 'clean' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the clean_project function."
}
function rebuild_project {
	write-host "The 'rebuild' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the rebuild_project function."
}
function develop_project {
	write-host "The 'develop' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the develop_project function."
}
function pushenv_project {
	write-host "The 'pushenv' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the pushenv_project function."
}
function popenv_project {
	write-host "The 'popenv' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the popenv_project function."
}
function setupdev_project {
	write-host "The 'setupdev' command has not been created.  Edit your .project-commands.psm1 file and add your project specific commands to the setupdev_project function."
    # Try to write this command so running it multiple times doesn't hurt anything.
}
function share_project {
	write-host "The 'share' command has not been created.  Edit your .project-commands.psm1 file and add your project specific command(s) to the share_project function."
}

export-modulemember -function build_project
export-modulemember -function test_project
export-modulemember -function clean_project
export-modulemember -function rebuild_project
export-modulemember -function develop_project
export-modulemember -function pushenv_project
export-modulemember -function popenv_project
export-modulemember -function share_project
export-modulemember -function setupdev_project