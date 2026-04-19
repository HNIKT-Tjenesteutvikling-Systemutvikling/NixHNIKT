{
  lib,
  stdenv,
  fetchurl,
  bison,
  cmake,
  pkg-config,
  icu,
  libedit,
  libevent,
  lz4,
  ncurses,
  openssl,
  protobuf_21,
  re2,
  readline,
  zlib,
  zstd,
  libfido2,
  cctools,
  darwin,
  numactl,
  libtirpc,
  rpcsvc-proto,
  curl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mysql";
  version = "8.0.40";

  src = fetchurl {
    url = "https://dev.mysql.com/get/Downloads/MySQL-${lib.versions.majorMinor finalAttrs.version}/mysql-${finalAttrs.version}.tar.gz";
    hash = "sha256-At/ZQ/lnQvf5zXiFWzJwjqTfVIycFK+Sc4F/O72dIrI=";
  };

  nativeBuildInputs = [
    bison
    cmake
    pkg-config
  ]
  ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [ rpcsvc-proto ];

  patches = [
    ./no-force-outline-atomics.patch
  ];

  postPatch = ''
    substituteInPlace cmake/libutils.cmake --replace /usr/bin/libtool libtool
    substituteInPlace cmake/os/Darwin.cmake --replace /usr/bin/libtool libtool
  '';

  buildInputs = [
    (curl.override { inherit openssl; })
    icu
    libedit
    libevent
    lz4
    ncurses
    openssl
    protobuf_21
    re2
    readline
    zlib
    zstd
    libfido2
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    numactl
    libtirpc
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    cctools
    darwin.developer_cmds
    darwin.DarwinTools
  ];

  outputs = [
    "out"
    "static"
  ];

  cmakeFlags = [
    "-DFORCE_UNSUPPORTED_COMPILER=1"
    "-DWITH_ROUTER=OFF"
    "-DWITH_SYSTEM_LIBS=ON"
    "-DWITH_UNIT_TESTS=OFF"
    "-DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock"
    "-DMYSQL_DATADIR=/var/lib/mysql"
    "-DINSTALL_INFODIR=share/mysql/docs"
    "-DINSTALL_MANDIR=share/man"
    "-DINSTALL_PLUGINDIR=lib/mysql/plugin"
    "-DINSTALL_INCLUDEDIR=include/mysql"
    "-DINSTALL_DOCREADMEDIR=share/mysql"
    "-DINSTALL_SUPPORTFILESDIR=share/mysql"
    "-DINSTALL_MYSQLSHAREDIR=share/mysql"
    "-DINSTALL_MYSQLTESTDIR="
    "-DINSTALL_DOCDIR=share/mysql/docs"
    "-DINSTALL_SHAREDIR=share/mysql"
  ];

  postInstall = ''
    moveToOutput "lib/*.a" $static
    so=${stdenv.hostPlatform.extensions.sharedLibrary}
    ln -s libmysqlclient$so $out/lib/libmysqlclient_r$so
  '';

  passthru = {
    client = finalAttrs.finalPackage;
    connector-c = finalAttrs.finalPackage;
    server = finalAttrs.finalPackage;
    mysqlVersion = lib.versions.majorMinor finalAttrs.version;
  };

  meta = {
    homepage = "https://www.mysql.com/";
    description = "MySQL 8.0 (legacy)";
    license = lib.licenses.gpl2;
    maintainers = with lib.maintainers; [ Gako358 ];
    platforms = lib.platforms.unix;
  };
})
