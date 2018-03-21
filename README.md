# Example of VS2017 solution for Sitecore 8 with Docker and TDS

The project "https://github.com/pbering/SockerVS2017", published by Per Bering, shows a great way to develop Sitecore solutions with VS2017 and Docker containers. While checking it, I got some ideas for improvements.

This proposal aims to add the following enhancements:

 - Example for a TDS project in the solution
 - Ability to access the Website folder in the container at debugging time (with VS2017). This folder is embedded in the container in the Release configuration for easier deployment.
 - Support for specialized (slightly different) containers at debugging time.
   - Ability to persist all content of the Data folder (not only log and serialization files)
 - Performance improvements.
 - Improved base image re-usability.

The following features are shared with Per's solution:

- Databases is persisted between restarts
- Serialization and log folders are mounted with volumes (among other subfolders of the "Data" folder).
- Remote debugging, auto attaching to running containers with F5
- Build, re-build, clear builds/stops/starts compose services (containers)
- Optional Visual Studio automatic pull, build, and run of necessary container images in the background.

## Prerequisites

- Windows 10 Fall Creators Update
- Docker for Windows
- Visual Studio 2017 15.5.7 or later


## DEVELOPMENT ENVIRONMENT SETUP

>NOTE: Base images are build and consumed locally in this example, but in a real life scenario you would also push to an remote private repository like
hub.docker.com, quay.io or an internal one, so that images can be shared within your organization.
Unfortunately it has to be **private** repositories due to Sitecore licensing terms so we can't share images in the community.

1. Clone [this repository](https://github.com/Ben-m-s/Sitecore82TDS.git) into a folder such as “C:\Docker\Sitecore82TDS” (next step will asume this folder has been used):
1. Copy Sitecore 8.2 rev. 161221.zip into “c:\Docker\Sitecore82TDS\images\sitecore-82rev161221“
1. Copy license.xml into "c:\Docker\Sitecore82TDS\storage\Data\“
1. Copy the database files (*.mdf and *.ldf) from "Sitecore 8.2 rev. 161221.zip" into "c:\Docker\Sitecore82TDS\storage\Databases\“
1. Copy The "Website" folder files from "Sitecore 8.2 rev. 161221.zip" into "c:\Docker\Sitecore82TDS\storage\Website“
1. Open VS2017 as Administrator
1. Open the solution “c:\Docker\Sitecore82TDS\Sitecore82TDS.sln”
1. Open a PowerShell console as Administrator.
1. Run the script “c:\Docker\Sitecore82TDS\Build.ps1”
1. Copy file “c:\Docker\Sitecore82TDS\src\Website\Properties\PublishProfiles\LocalDevContainer.pubxml.example” as “LocalDevContainer.pubxml”
1. Edit the Publication settings for the project “Website”. Set the Target Location to “C:\Docker\Sitecore82TDS\storage\website”
1. Build the solution.
1. Publish the Website project to the local folder "c:\Docker\Sitecore82TDS\storage\Website“
1. Make sure the project “docker-compose” is set as StartUp project
1. Run the containers in “Debug” mode. The browser will open with Sitecore’s home page.
1. Copy the container’s IP in the “c:\Windows\System32\drivers\etc\hosts” file with the URL: sitecore82tds.dev.local
1. With VS2017, edit the properties of the TDS project “SampleSite.Master”.
   1. Select tab “Build”
   1. Check the checkbox “Edit user specific configuration (.user file)”
   1. Set the following values in the text boxes:
      1. Sitecore Web Url: “http://sitecore82tds.dev.local”
      1. Sitecore Deploy Folder: "c:\Docker\Sitecore82TDS\storage\Website“
   1. Check the checkbox “Install Sitecore Connector”. A guid should appear in the “Sitecore Access Guid” field
   1. Click the “Test” button to confirm the connection works
   1. Save the project.
1. Deploy the TDS project “SampleSite.Master”
1. Browse to “http://sitecore82tds.dev.local/sitecore/shell”
1. Login with “admin” and “b”
1. Browse to “/sitecore/content/Home”. Confirm there is a child page deployed by TDS.

## DEBUGING SITECORE IN A CONTAINER

1. Browse to “http://sitecore82tds.dev.local”. Notice the customisation that shows the computer name on the home page.
1. Attach to the running container
1. Put an interruption point in the class “C:\Docker\Sitecore82TDS\src\Website\Processors\ExampleProcessor.cs”
1. Refresh the page “http://sitecore82tds.dev.local”. Visual Studio should stop the execution and display run time data.


To stop everything again select "Build -> Clear".

## References:

[https://github.com/pbering/SockerVS2017)
