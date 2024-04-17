#  Nix
Nix is a package manager designed to allow for completely reproducible builds. It allows for developers to have reproducible build environments in order to ensure consistency. For more information, see <https://nixos.org/>.

## Nix shell
Nix development shells can be used to get development environments which can be accessed using the `nix-shell` command.

Firstly, we must define a function. Nix expressions are written in a functional language (also called Nix) and use the function as their basic unit. This one takes a parameter called `pkgs` with a default value of the primary Nix package collection.
```nix shell.nix+=
{ pkgs ? import <nixpkgs> {} }:
```

Now, we can create a shell using the `pkgs.mkShell` function. This function creates the shell that will be accessed and defines properties of it. In our case, we use the `buildInputs` parameter to include our build dependencies (ie. Golang) in this shell.
```nix shell.nix+=
pkgs.mkShell {
  buildInputs = with pkgs; [ go ];
}
```
## Nix package

We can build the project using Nix as well. Nix provides a dedicated function
for building Go projects.
```nix package.nix+=
{ buildGoModule }:

buildGoModule {
  pname = "lmt";
  version = "0.0.0";

  src = ./.;

  vendorHash = null;

  meta = {
    description = "Literate markdown tangler";
    homepage = "https://github.com/nat-418/lmt";
  };
}
```
By default, the `nix-build` command looks for a `default.nix`. We use the
`callPackage` pattern of having this file call the `package.nix` file,
because that follows how the upstream Nixpkgs repository works. Put simply,
the `callPackage` function gives our package what it needs.
```nix default.nix+=
{ pkgs ? import <nixpkgs> {} }:

{
  lmt = pkgs.callPackage ./package.nix {};
}
```
Now when running a `nix-build` you will find a `result` symlink to the
Nix store path containing the built binary.
