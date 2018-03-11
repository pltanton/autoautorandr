{ stdenv, mkDerivation, base, udev, select, text }: 

mkDerivation {
  pname = "autoautorandr";
  version = "1.0.0";
  
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base udev select text ];

  license = stdenv.lib.licenses.mit;
}
