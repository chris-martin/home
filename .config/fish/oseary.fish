function oseary-mount
  env USER=chris PASSWORD=(cat ~/secrets/oseary) \
    HOST=192.168.0.100 MOUNT=$HOME/mnt/oseary sshfs-mount
end

function oseary-umount
  fusermount -u $HOME/mnt/oseary
end
