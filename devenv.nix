{ pkgs, lib, config, inputs, ... }:

{
  packages = [
    pkgs.git
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
      # Base LaTeX installation
        scheme-medium

        # Build tool for LaTeX
        latexmk

        # Required packages
        fancyhdr titlesec enumitem hyperref marvosym babel tabulary fontawesome5
        sourcesanspro multirow collection-fontsrecommended preprint geometry
        ly1;
    })
    pkgs.evince
    pkgs.poppler_utils
    pkgs.entr
    pkgs.inotify-tools
  ];

  # Shell configuration
  enterShell = ''
    echo "LaTeX Resume Environment"
    echo "========================"
    echo ""
    echo "Available commands:"
    echo "  build-resume   - Compile the resume to PDF"
    echo "  clean          - Remove generated files"
    echo "  view-resume    - Open the generated PDF"
    echo "  live-edit      - Open the generated PDF and start live editing"
    echo ""
  '';

  # Custom scripts
  scripts.build-resume.exec = ''
    echo "Building resume..."
    mkdir -p build
    latexmk -pdf -outdir=build resume.tex
    echo "Resume built: resume.pdf"
  '';

  scripts.clean.exec = ''
    echo "Cleaning up generated files..."
    rm -f build
    echo "Done."
  '';

  scripts.view-resume.exec = ''
    if [ -f resume.pdf ]; then
      echo "Opening resume.pdf..."
      evince ./build/resume.pdf &
    else
      echo "Error: resume.pdf not found. Run 'build-resume' first."
      exit 1
    fi
  '';

  scripts.live-edit.exec = ''
    ./scripts/resume-live-editing.sh
  '';
}
