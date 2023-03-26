{
    programs.ssh = {
        enable = true;
        matchBlocks = {
            "*".identityFile = "/home/chris/.ssh/default-key";
            "chris-martin.org".port = 36411;
        };
    };
}
