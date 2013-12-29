# Noodle in Go

From the `noodle` repo's root directory:

```bash
$ cd go/
$ history 0 | go run noodle.go
$ diff ../files/expected.txt <(go run noodle.go < ../files/history.txt)
```
