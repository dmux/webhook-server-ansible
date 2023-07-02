# webook-server-ansible

> A simple server to receive webhooks and execute ansible playbooks

[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/miguelmota/go-webhook-server/master/LICENSE)

## Install

Installing from Go:

```bash
go get -u github.com/dmux/webhook-server-ansible/cmd/wsa
```

Installing pre-compiled binary:

```bash
$ wget https://github.com/dmux/webhook-server-ansible/releases/download/v0.0.9/wsa.0.9_Linux_x86_64.tar.gz
$ tar -xvzf wsa.0.9_Linux_x86_64.tar.gz wsa
$ chmod +x wsa
sudo mv wsa /usr/local/bin/wsa
```

## Usage

```bash
wsa --help
```

## Getting started

Example of setting up a [Github](https://developer.github.com/webhooks/creating/) webhook:

```bash
$ export SECRET_TOKEN=mysecret
$ wsa -port=8080 -path=/postreceive -command='ansible-playbook -connection=local --inventory 127.0.0.1 --limit 127.0.0.1 playbook.yml -i ansible_hosts'

Method: GET
Path: /postreceive
Command: echo "hello world"
Listening on port 8080
```

```bash
$ curl "http://localhost:8080/postreceive" -X 'X-Hub-Signature: sha1=33f9d709782f62b8b4a0178586c65ab098a39fe2'
hello world
```

Example of how to use bash script as the command:

```bash
$ cat > command.sh
#!/bin/bash
echo 'hello world'
^C

$ chmod +x command.sh

$ wsa -path=/postreceive -command=$(pwd)/command.sh
```

Example of how to read the payload in bash:

```bash
$ cat > command.sh
#!/bin/bash

payload=$(</dev/stdin)

echo $payload | jq '.' | cat
^C

$ wsa -method=POST -command=$(pwd)/command.sh
```

## License

[MIT](LICENSE)
