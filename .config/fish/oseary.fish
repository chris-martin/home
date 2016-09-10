function oseary --argument command
  switch $command

  case mount
    env USER=chris PASSWORD=(cat ~/secrets/oseary) \
      HOST=192.168.0.100 MOUNT=$HOME/mnt/oseary sshfs-mount

  case umount
    fusermount -u $HOME/mnt/oseary; and echo "Unmounted."

  case '*'
    echo "???"

  end
end

function __fish_oseary_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  else
    return 1
  end
end

complete -f -c oseary -a mount \
  -n __fish_oseary_needs_command \
  -d "Mount the NAS"

complete -f -c oseary -a umount \
  -n __fish_oseary_needs_command \
  -d "Unmount the NAS"
