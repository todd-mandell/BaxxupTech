REM add this in task scheduler for your windows endpoints and obviously change paths as needed
REM this is a one way copy operation WITH file versioning in a dated folder and it only copies stuff that has changed to the actual main folder in the rclone remote location
rclone copy \\UNCPath\WindowsNetworkShare remote:/folderPath --backup-dir "remote:/rcloneVersionBakups-%date:/=-%" --update --checksum
