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

@test "listening on 80,5000" {
  nc -z localhost 5000
  nc -z localhost 80
}

@test "GET /install" {
  curl localhost/install
  curl localhost:5000/install
}
