setup() {
  apt-get install curl -y
}

# Only testing things that setting droned_opts attribute would effect.
# No need to re-test what is covered in default test suite.

@test "listening on 443" {
  nc -z localhost 443
}

@test "GET /install" {
  curl localhost:443/install
}

@test "droned process has --port=:443 flag" {
  run pgrep -fl -- --port=:443
  echo "$output" | egrep "^[0-9]+ droned$"
}

@test "droned process has --workers=2 flag" {
  run pgrep -fl -- --port=:443
  echo "$output" | egrep "^[0-9]+ droned$"
}
