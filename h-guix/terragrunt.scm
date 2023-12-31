(define-module (h-guix terragrunt)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy))

(define-public terragrunt
  (package
   (name "terragrunt")
   (version "0.54.12")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/gruntwork-io/terragrunt/releases/download/v" version
                                "/terragrunt_linux_amd64"))
            (sha256
             (base32
              "0lvxp0g4yb85xw8chn5bmlag4wbh7rff7cl49c5pzx2jxvm67zkh"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan '(("terragrunt_linux_amd64" "bin/terragrunt"))
      #:phases
      (modify-phases %standard-phases
                     (add-before 'install 'chmod
                                 (lambda _
                                   (chmod "terragrunt_linux_amd64" #o0755))))))
   (synopsis "Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules.")
   (description
    "Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules.")
   (home-page "https://terragrunt.gruntwork.io/")
   (license license:expat)))
