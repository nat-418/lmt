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
