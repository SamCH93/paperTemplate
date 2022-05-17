(TeX-add-style-hook
 "paper"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "a4paper" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("babel" "english") ("xcolor" "dvipsnames") ("natbib" "round") ("appendix" "title") ("setspace" "onehalfspacing") ("caption" "labelfont=bf" "font=small")))
   (TeX-run-style-hooks
    "latex2e"
    "defs"
    "article"
    "art11"
    "fontenc"
    "inputenc"
    "babel"
    "xcolor"
    "amsmath"
    "amssymb"
    "doi"
    "natbib"
    "booktabs"
    "appendix"
    "nameref"
    "setspace"
    "caption"
    "geometry"
    "hyperref"
    "fancyhdr")
   (TeX-add-symbols
    "longtitle"
    "shorttitle"
    "subtitle"
    "longauthors"
    "shortauthors"
    "affiliation"
    "mail")
   (LaTeX-add-labels
    "fig:figure"
    "appendix:xxxx")
   (LaTeX-add-bibliographies
    "bibliography"))
 :latex)

