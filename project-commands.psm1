function build 		{	invoke-build-cmd("build") 	}
function test 		{	invoke-build-cmd("test") 		}
function clean 		{	invoke-build-cmd("clean") 	}
function rebuild 	{	invoke-build-cmd("rebuild") 	}
function develop 	{ 	invoke-build-cmd("develop") 	}
function pushenv 	{	invoke-build-cmd("pushenv") 	}
function popenv 	{ 	invoke-build-cmd("popenv") 	}
function share 		{ 	invoke-build-cmd("share") 	}

function invoke-build-cmd {

	Param($cmdscript)

	# This file exists (or will be created) in the project dir.  It is a posh module 
	# containing the actual project specific implementation of the commands (build, 
	# develop, etc).
	$project_commands_file = ".\.project-commands.psm1"
	$project_commands_modulename = ".project-commands"	
	
	# Set this to some directory that always exists in the root of your projects.
	# For me, it's mercurial's repo directory, or git's. Also look for project-commands
	# files deeper than the root.  This supports the situation of multiple projects
	# in a single source tree.
	$projectrootflagdirs = ".hg", ".git", $project_commands_file
	
	# Work up the tree, till the root (contains $project-root-flag-dir) dir is found.
	$projectdir = '.'
	
	while(!(any-in $projectdir $projectrootflagdirs)) {
		$projectdir = join-path $projectdir ..

		# If we hit the drive (c:, d:, whatever) we need to abort.
		if(!( get-item $projectdir ).Parent) { # drive has an empty parent
			echo "There is no project here ($projectrootflagdirs not found)."
      echo "You could manually do a:"
      echo "     cp $psScriptRoot\project-commands.template.psm1 $project_commands_file"
      echo "to create a project rooted in this directory."
			return
		}
	}

	# Move to the project dir
	push-location $projectdir	
	
	if(test-path $project_commands_file) {
		Import-Module $project_commands_file
		& ($cmdscript + "_project")
		Remove-Module $project_commands_modulename
	}
	else {
		cp $psScriptRoot\project-commands.template.psm1 $project_commands_file
		
		echo "Project file $project_commands_file did not exist, and so was created."
		echo "Edit it to add in the specific commands that implement '$cmdscript' for this project."
		
		echo "You may want to add $project_commands_file to your vcs."
	}

	# Go back to the original location
	pop-location
}

# Returns $true if any of the items in $testpaths exist in the $targetdir directory.  
# Otherwise returns $false.
function any-in {
	param($targetdir = '.', $testpaths)
	
	foreach ($d in $testpaths) {
		if(test-path (join-path $targetdir $d)) {
			return $true
		}
	}
	return $false
}

Export-ModuleMember -Function  @('build', 'rebuild', 'test', 'clean', 'develop', 'pushenv', 'popenv', 'share') 
