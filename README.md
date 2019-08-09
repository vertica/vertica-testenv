# vertica-testenv
The first version of a full docker-based vertica test environment, including Kerberos.

# Prerequisites
Unix-like operating system, docker and at least 4 GB of free disk space.

## Setup

You can make a Kerberized database with `./vertica_testenv start`.

After you are done, stop the containers with `./vertica_testenv stop`. You can then reclaim disk space with `./vertica_testenv clean`.
