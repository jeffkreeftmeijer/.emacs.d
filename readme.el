(use-package ox-gfm)

(use-package ox-extend
  :straight '(ox-extend
	      :type git
	      :host github
	      :repo "jeffkreeftmeijer/ox-extend.el"))

(use-package ox-md-title
  :straight '(ox-md-title
	      :type git
	      :host github
	      :repo "jeffkreeftmeijer/ox-md-title.el"))
