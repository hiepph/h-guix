(define-module (h-guix kind)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy))

(define-public kind
  (package
   (name "kind")
   (version "0.20.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/kubernetes-sigs/kind/releases/download/v" version
                                "/kind-linux-amd64"))
            (sha256
             (base32
              "1v9x953a5n0l3kz78wm29yh11vz56nmlvhi7xzcjscyksq9p4fji"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan '(("kind-linux-amd64" "bin/kind"))
      #:phases
      (modify-phases %standard-phases
        (add-before 'install 'chmod
            (lambda _
              (chmod "kind-linux-amd64" #o0755))))))
   (synopsis "Kubernetes IN Docker - local clusters for testing Kubernetes ")
   (description
    "Kubernetes IN Docker - local clusters for testing Kubernetes")
   (home-page "https://kind.sigs.k8s.io/")
   (license license:expat)))
