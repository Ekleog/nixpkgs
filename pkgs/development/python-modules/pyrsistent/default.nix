{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, six
, pytestCheckHook
, hypothesis
}:

buildPythonPackage rec {
  pname = "pyrsistent";
  version = "0.18.0";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "0jzbc3m427wg3r6vxgmcw5517fqpnpakidm7885r1hpq2q97hg3p";
  };

  propagatedBuildInputs = [ six ];

  checkInputs = [ pytestCheckHook hypothesis ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'pytest<5' 'pytest' \
      --replace 'hypothesis<5' 'hypothesis'
  '';

  pythonImportsCheck = [ "pyrsistent" ];

  meta = with lib; {
    homepage = "https://github.com/tobgu/pyrsistent/";
    description = "Persistent/Functional/Immutable data structures";
    license = licenses.mit;
    maintainers = with maintainers; [ desiderius ];
  };

}
