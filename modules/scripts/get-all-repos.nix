{ pkgs, ... }:

let
in
pkgs.writeShellScriptBin "get-all-repos" ''
  set -e

  run_build_flag=false
  if [ "x$1" = "xcomplete" ]; then
    echo "Running in complete mode: cloning and building all projects."
    run_build_flag=true
  else
    echo "Running in clone-only mode: only cloning projects if they don't exist."
  fi

  cd $HOME/Projects/workspace

  clone_and_build() {
    local dir="$1"
    local repo="$2"
    local should_build="$3"

    if [ -d "$dir" ]; then
      echo "$dir already exists, skipping clone"
    else
      echo "Cloning $dir..."
      git clone "$repo" "$dir"
    fi

    if [ "x$run_build_flag" = "xtrue" ] && [ "$should_build" = true ]; then
      cd "$(realpath "$dir")"
      direnv allow .
      eval "$(direnv export bash)"
      mvn clean install -DskipTests
      cd ..
    elif [ "x$run_build_flag" = "xtrue" ] && [ "$should_build" = false ]; then
      cd "$(realpath "$dir")"
      direnv allow .
      eval "$(direnv export bash)"
      cd ..
    elif [ "x$run_build_flag" = "xtrue" ] && [ "$should_build" = none ]; then
      echo "Skipping $repo_name due to build_flag=none"
      continue
    fi
  }

  # List of repos: "dir_name repo_url should_build"
  repos=(
    "ablanor git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-ablanor.git true"
    "deformitet git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/deformitet.git true"
    "dokumentasjon_kvalreg git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalitetsregister-dokumentasjon.git none"
    "ethirgast git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-ethirgast.git true"
    "itp git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-itp.git true"
    "kodeverk git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-kodeverk-api.git false"
    "langmek git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-langmek.git true"
    "nmkp git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nmkp.git false"
    "laparoskopi git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-laparoskopi.git true"
    "muskel git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-muskel.git true"
    "nakke git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nakke.git true"
    "norgast git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-norgast.git true"
    "noric git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-noric.git true"
    "norspis git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-norspis.git true"
    "nra git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nra.git true"
    "oqr6 git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/oqr6.git true"
    "roskva git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/roskva.git none"
    "rygg git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-rygg.git true"
    "smerte git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-smerte.git true"
  )

  for entry in "''${repos[@]}"; do
    dir="$(echo "$entry" | awk '{print $1}')"
    url="$(echo "$entry" | awk '{print $2}')"
    should_build="$(echo "$entry" | awk '{print $3}')"
    clone_and_build "$dir" "$url" "$should_build"
  done

  if [ "x$run_build_flag" = "xtrue" ]; then
    echo "All repositories have been cloned and built successfully."
  else
    echo "All repositories have been cloned successfully."
  fi
''
