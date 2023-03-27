{ pkgs, ... }: {
  programs.fish = {

    interactiveShellInit = ''
      complete -f -c oseary -a mount -n __fish_oseary_needs_command -d "Mount the NAS"
      complete -f -c oseary -a umount -n __fish_oseary_needs_command -d "Unmount the NAS"
    '';

    functions = {

      # Parameters as environment variables:
      #   USER       username to connect as
      #   PASSWORD   password of user
      #   HOST       host to connect to
      #   MOUNT      filesystem mount point
      sshfs-mount = {
        body = ''
          echo "If this hangs indefinitely, you may need to SSH to the host to accept the server's public key."
          echo "Mounting..."
          echo "$PASSWORD" | \
              ${pkgs.sshfs}/bin/sshfs "$USER"@"$HOST": "$MOUNT" \
              -oKexAlgorithms=+diffie-hellman-group1-sha1 \
              -o ServerAliveInterval=30,password_stdin,allow_other && echo -e 'Done.'
        '';
      };

      oseary = {
        argumentNames = "command";
        body = ''
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
        '';
      };

      __fish_oseary_needs_command = {
        body = ''
          set cmd (commandline -opc)
          if [ (count $cmd) -eq 1 ]
              return 0
          else
              return 1
          end
        '';
      };
    };
  };
}
