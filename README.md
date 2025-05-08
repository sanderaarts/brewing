# brews-ready
Checks whether there are brew packages that are ready to be upgraded.

Set terminal to run `check.sh` on opening new shell _*)_. The script will check if it has been more than the set interval since
the previous check. The default is 24h, but this can be changed by creating an `.interval` file with an integer value as
it's sole content. If the set hourly interval has passed, it will show what brew packages are ready to be upgraded, if
any.


_*)_ In Apple's _Terminal_ app got to **Settings** > **Profiles** > **Shell** and provide the path to `check.sh` (e.g.
`~/brews-ready/check.sh`) at **Startup** > **Run command**.
