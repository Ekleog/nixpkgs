{ lib
, python3
, fetchpatch
, pkgsCross
, avrdude
, dfu-programmer
, dfu-util
, gcc-arm-embedded
}:

let
  inherit (python3.pkgs) buildPythonApplication fetchPypi;
  qmk-dotty-dict = python3.pkgs.dotty-dict.overridePythonAttrs (old: rec {
    pname = "qmk_dotty_dict";
    version = "1.3.0.post1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "18kyzk9a00xbxjsph2a9p03zx05f9dw993n66mlamgv06qwiwq9v";
    };
  });
in
buildPythonApplication rec {
  pname = "qmk";
  version = "0.2.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "18lfsa4wn86j2004wdf4v5ch2qx6n64cas3jiihfb4hnsqibhnhx";
  };

  nativeBuildInputs = with python3.pkgs; [
    flake8
    nose2
    pep8-naming
    setuptools-scm
    yapf
  ];

  propagatedBuildInputs = with python3.pkgs; [
    appdirs
    argcomplete
    colorama
    #dotty-dict # See https://pypi.org/project/qmk-dotty-dict/
    qmk-dotty-dict
    hid
    hjson
    jsonschema
    milc
    pygments
    pyrsistent
    pyusb
  ] ++ [ # Binaries need to be in the path so this is in propagatedBuildInputs
    avrdude
    dfu-programmer
    dfu-util
    gcc-arm-embedded
    pkgsCross.avr.buildPackages.binutils
    pkgsCross.avr.buildPackages.gcc8
    pkgsCross.avr.libcCross
  ];

  # no tests implemented
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/qmk/qmk_cli";
    description = "A program to help users work with QMK Firmware";
    longDescription = ''
      qmk_cli is a companion tool to QMK firmware. With it, you can:

      - Interact with your qmk_firmware tree from any location
      - Use qmk clone to pull down anyone's qmk_firmware fork
      - Setup and work with your build environment:
        - qmk setup
        - qmk doctor
        - qmk compile
        - qmk console
        - qmk flash
        - qmk lint
      - ... and many more!
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ bhipple ekleog ];
  };
}
