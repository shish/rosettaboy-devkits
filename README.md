Rosettaboy Devkits
==================
![](https://byob.yarr.is/shish/rosettaboy-devkits/go-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/nim-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/ocaml-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/php-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/pypy-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/python-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/rust-version)
![](https://byob.yarr.is/shish/rosettaboy-devkits/zig-version)

Because building PHP over and over again takes too much CPU time...

* I need a single docker image with the ability to run a whole bunch of different language toolkits at the same time
* Building 10 different runtimes every time I run `docker build` for a totally unrelated change is pain
* Even if I use different layers in a single dockerfile, that doesn't help anybody else (or me when I clean the layer cache)

So:

* Have a bunch of docker files, all using the same base (debian unstable)
* Each dockerfile builds one language runtime and installs it into `~/.${language}`
* We have a new layer which inherits from the empty base and copies that folder
* These docker builds give us eg `rosettaboy-devkit-pypy` which contains `~/.pypy`, `rosettaboy-devkit-rust` which contains `~/.rustup` and `~/.cargo`, etc
* Rosettaboy can then make use of these pre-built off-the-shelf compatible-with-each-other toolkits like `COPY --from=rosettaboy-devkit-pypy ~/.pypy ~/.pypy`
