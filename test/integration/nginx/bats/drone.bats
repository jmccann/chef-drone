setup() {
  apt-get install curl -y
}

@test "drone installed" {
  which drone
}

@test "droned installed" {
  which droned
}

@test "drone running" {
  status drone
}

@test "drone service set to start" {
  status drone | grep start
}

@test "nginx running" {
  service nginx status | grep running
}

@test "nginx installed" {
  which nginx
}

@test "listening on 80,443,5000" {
  nc -z localhost 5000
  nc -z localhost 80
  nc -z localhost 443
}

@test "GET /install" {
  curl -k https://localhost/install
  curl localhost:5000/install
}
