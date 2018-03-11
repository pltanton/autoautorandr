{ stdenv, mkDerivation, base, udev, select, text, autorandr }: 

mkDerivation {
  pname = "autoautorandr";
  version = "1.0.0";
  
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base udev select text ];
  executableSystemDepends = [ autorandr ];

  license = stdenv.lib.licenses.mit;
}
