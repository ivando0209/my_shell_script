
echo 'boot-recovery' > recovery_command
echo '--update_package=/cache/ota/ota_package.zip ' >> recovery_command 
echo '--wipe_cache ' >> recovery_command
echo 'reboot ' >> recovery_command 
