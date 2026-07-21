{ pkgs, ... }:

pkgs.writeShellScriptBin "get-all-repos" ''

  WORKSPACE_DIR="/home/dev/Projects/workspace"
  if [ ! -d "$WORKSPACE_DIR" ]; then
    echo "Creating workspace directory: $WORKSPACE_DIR"
    mkdir -p "$WORKSPACE_DIR"
  fi

  cd "$WORKSPACE_DIR"

  clone_repo() {
    local dir="$1"
    local repo="$2"

    if [ -d "$dir" ]; then
      echo "✓ $dir already exists, skipping clone"
      return 0
    fi

    echo "→ Cloning $dir..."
    if git clone "$repo" "$dir"; then
      echo "✓ Successfully cloned $dir"
      return 0
    else
      echo "✗ Failed to clone $dir"
      return 1
    fi
  }

  repos=(
    "ablanor git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-ablanor.git"
    "deformitet git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/deformitet.git"
    "dokumentasjon_kvalreg git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalitetsregister-dokumentasjon.git"
    "ethirgast git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-ethirgast.git"
    "itp git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-itp.git"
    "kodeverk git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-kodeverk-api.git"
    "langmek git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-langmek.git"
    "nmkp git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nmkp.git"
    "laparoskopi git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-laparoskopi.git"
    "muskel git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-muskel.git"
    "nakke git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nakke.git"
    "norgast git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-norgast.git"
    "noric git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-noric.git"
    "norspis git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-norspis.git"
    "nra git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-nra.git"
    "oqr6 git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/oqr6.git"
    "roskva git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/roskva.git"
    "rygg git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-rygg.git"
    "smerte git@github.com:HNIKT-Tjenesteutvikling-Systemutvikling/kvalreg-smerte.git"
  )

  echo "========================================="
  echo "Git Repository Cloner"
  echo "Workspace: $WORKSPACE_DIR"
  echo "Total repositories: ''${#repos[@]}"
  echo "========================================="
  echo ""

  success_count=0
  skip_count=0
  fail_count=0

  for entry in "''${repos[@]}"; do
    dir="$(echo "$entry" | awk '{print $1}')"
    url="$(echo "$entry" | awk '{print $2}')"

    if clone_repo "$dir" "$url"; then
      if [ -d "$dir" ]; then
        ((skip_count++))
      else
        ((success_count++))
      fi
    else
      ((fail_count++))
    fi
  done

  echo ""
  echo "========================================="
  echo "Summary:"
  echo "  • Cloned: $success_count"
  echo "  • Skipped (already exist): $skip_count"
  echo "  • Failed: $fail_count"
  echo "========================================="

  if [ $fail_count -eq 0 ]; then
    echo "✓ All repositories processed successfully!"
  else
    echo "⚠ Some repositories failed to clone. Check the output above."
    exit 1
  fi
''
