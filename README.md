
# BDSX-Scripts

Utilities to help you run your [BDSX](https://github.com/bdsx/bdsx) server.

To install, run

```bash
git clone https://github.com/bmar116/bdsx-scripts.git && bash bdsx-scripts/setup.sh
```

## Usage

```
./minecraft-control.sh [option]
- none: If server is not running, startup and join screen
- login: Join screen. Use in ~/.profile for ssh login.
- stop: Stop server without joining screen.
- backup: Backup entire worlds folder to backup/${timestamp}.tar
- backup clean: Deletes backups more than 2 weeks old after backing up.
- restart: Auto restart the server.
- restart backup: Backup before auto restarting.
- restart backup clean: Backup and cleanup backups before auto restarting.
```

## Enable SSH login session

Edit ``~/.profile`` and add

```bash
...
~/minecraft-server.sh
logout
```

to the end of the file. Now when you SSH into your server as that user, you will automatically join the MinecraftServer screen. Ctrl-A-D will detach the screen and logout.

## Enable nightly restarts

To enable nightly restarts and backups, run:

```bash
crontab -e
```

Choose your editor, and add to the end of the file:

```bash
...
0 0 * * * ~/minecraft-control.sh restart
...
```

To enable nightly backups, you can add `backup` to the end of the line. Add `clean` to clean backups after backing up.
