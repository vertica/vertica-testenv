# vertica-testenv
The first version of a full docker-based vertica test environment, including Kerberos.

# Prerequisites
Unix-like operating system, docker and at least 4 GB of free disk space.

## Setup

You can make a Kerberized database with `./vertica_testenv start`. The databse name is `docker` and has two users: `dbadmin` and `user1`. The Kerberos server has three user principals: `user1, user2, user3`, and their password is just their username.

Kerberos has the host name `kerberos.example.com` and Vertica has the host name `vertica.example.com`.

You can create a sandbox to play with by running `./vertica_testenv sandbox`. This sandbox comes with Kerberos and hosts configured. For example, you can log in from the sandbox with `kinit user1` and `vsql -h vertica -U user1`.

If you want to change the containers, they are labeled as `$USER.[kdc|db|sandbox]` and you can run `docker exec -it <container name> /bin/bash` on them.

After you are done, stop the containers with `./vertica_testenv stop`. You can then reclaim disk space with `./vertica_testenv clean`.

## vertica-python support
Currently in development and encountering some directory-related bug. Will be done soon.
