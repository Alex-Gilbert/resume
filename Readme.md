# LaTeX Resume with Nix

This repository contains a professional LaTeX resume with a reproducible devenv environment for easy building.

## Prerequisites

- [devenv](https://devenv.sh)

## Quick Start

1. Clone this repository:

   ```bash
   git clone <your-repository-url>
   cd resume
   ```

2. Enter the development environment:

   ```bash
   cd resume
   devenv shell
   ```

3. Replace Alexander Gilbert with your name (unless you're also Alexander Gilbert, in which case, cool name!):

   ```bash
   sed -i 's/Alexander Gilbert/{YOUR-NAME-HERE}/g' resume.tex
   ```

4. Build your resume:

   ```bash
   build-resume
   ```

5. View your resume:
   ```bash
   view-resume
   ```

## Available Commands

Inside the development environment:

- `build-resume` - Compile the LaTeX file to PDF (output is stored in the `build` directory)
- `clean` - Remove generated files
- `view-resume` - Open the generated PDF in a viewer
- `live-edit` - Begin live editing

## Customization

1. Edit `resume.tex` to update your resume information
2. Run `build-resume` to generate the updated PDF
3. If you need additional LaTeX packages, add them to the `texlive.combine` section in `devenv.nix`

## Live Editing

Live editing can be started by invoking `live-edit` in the [devenv](https://devenv.sh) environment. Changes to `resume.tex` will result in the preview being updated live. This allows you to start the live-edit session and make edits to `resume.tex` in any external text editor you prefer.
