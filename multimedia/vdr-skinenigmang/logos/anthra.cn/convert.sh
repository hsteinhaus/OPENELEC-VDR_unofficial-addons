find . -name "*.xpm"  -exec sh -c 'cat "{}" | xpmtoppm | ppmtoxpm -hexonly > "../anthra/{}" ' \;
