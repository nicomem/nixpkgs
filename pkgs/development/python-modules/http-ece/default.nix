{
  lib,
  buildPythonPackage,
  cryptography,
  fetchPypi,
  mock,
  nose,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "http-ece";
  version = "1.2.0";

  src = fetchPypi {
    pname = "http_ece";
    inherit version;
    sha256 = "sha256-tZIPjvuOG1+wJXE+Ozb9pUM2JiAQY0sm3B+Y+F0es94=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail '"nose",' "" \
      --replace-fail '"coverage",' ""
  '';

  propagatedBuildInputs = [ cryptography ];

  doCheck = pythonOlder "3.12";

  nativeCheckInputs = [
    mock
    nose
  ];

  meta = with lib; {
    description = "Encipher HTTP Messages";
    homepage = "https://github.com/martinthomson/encrypted-content-encoding";
    license = licenses.mit;
    maintainers = with maintainers; [ peterhoeg ];
  };
}
