function oseary --argument command
  switch $command

  case mount
    mkdir -p $HOME/.oseary
    env USER=chris PASSWORD=(cat ~/secrets/oseary) \
      HOST=192.168.0.100 MOUNT=$HOME/.oseary sshfs-mount

  case umount
    fusermount -z -u $HOME/.oseary; and echo "Unmounting"
    sleep 1
    rmdir $HOME/.oseary

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
