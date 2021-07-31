
# ~/.emacs.d

- [Package management](#package-management)
- [Evil](#evil)
  - ["Fix" the tab key for visibility cycling in Org and Evil mode](#evil-org-tab)
  - [Evil collection](#evil-collection)
- [Org-mode](#org-mode)
  - [Org Roam](#org-roam)
  - [Org Babel](#org-babel)
- [Flyspell](#flyspell)
- [Magit](#magit)
- [Elixir](#elixir)



<a id="package-management"></a>

## Package management

[`straight.el`](https://github.com/raxod502/straight.el) is a package manager for Emacs that locks package versions and downloads packages from Git repositories. The [Getting started](https://github.com/raxod502/straight.el#getting-started) section in its README provides the bootstrap code to place inside `init.el`:

```emacs-lisp
;; Package management: straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
```

To disable `package.el` (Emacs' default package manager) in favor of using `straight.el`, turn off `package-enable-at-startup` in `early-init.el`:

```emacs-lisp
;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)
```

To install a package for the current session, execute the `straight-use-package` command:

    M-x straight-use-package <RET> evil <RET>

To continue using the package in future sessions, add the `straight-use-package` call to `~/.emacs/init.el`:

```emacs-lisp
(straight-use-package 'evil)
```


<a id="evil"></a>

## Evil

[Evil](https://github.com/emacs-evil/evil) is a Vim emulator for emacs. Install it with `straight.el`, and turn `evil-mode` on:

```emacs-lisp
;; Vim emulation: evil
(straight-use-package 'evil)
(evil-mode 1)
```


<a id="evil-org-tab"></a>

### "Fix" the tab key for visibility cycling in Org and Evil mode

Every `TAB` press on a headline cycles through a different function<sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>:

1.  The first press folds the headline's subtree, showing only the headline itself
2.  The scond press shows the headline and its direct descendants, but keeps them folded
3.  The third press shows the headline's complete subtree

However, running Emacs with Evil mode in a terminal breaks the `TAB` key for cycling through header visibility in Org mode.

Most terminals map both `TAB` and `C-i` to `U+0009 (Character Tabulation)` for historical reasons, meaning they're recognised as the same keypress. Because of this, there is no way to map different functions to them inside Emacs.

Evil remaps `C-i` to `evil-jump-forward` to emulate Vim's jump lists feature<sup><a id="fnr.2" class="footref" href="#fn.2" role="doc-backlink">2</a></sup>, which overwrites the default mapping for the `TAB` key in Org mode.

To fix the tab key's functionality in Org mode, sacrifice Evil's `C-i` backward jumping by turning it off in your configuration with the `evil-want-C-i-jump` option. This option needs to be set *before* Evil is loaded to take effect, so put it in the early init file:

```emacs-lisp
;; Disable C-i to jump forward to restore TAB functionality in Org mode.
(setq evil-want-C-i-jump nil)
```


<a id="evil-collection"></a>

### Evil collection

[Evil collection](https://github.com/emacs-evil/evil-collection) is a collection of bindings for plugins.

It replaces Evil's `evil-integration`, which should be turned off through the `evil-want-keybinding` option before Evil collection is loaded<sup><a id="fnr.3" class="footref" href="#fn.3" role="doc-backlink">3</a></sup>.

```emacs-lisp
;; Vim bindings for plugins: evil-collection
(straight-use-package 'evil-collection)
(setq evil-want-keybinding nil)
(evil-collection-init)
```


<a id="org-mode"></a>

## Org-mode

[ox-gfm](https://github.com/larstvei/ox-gfm) is an Org export backend for GitHub-flavored Markdown.

```emacs-lisp
;; GitHub-flavored Markdown Org exporter: ox-gfm
(straight-use-package 'ox-gfm)
```


<a id="org-roam"></a>

### Org Roam

[Org-roam](https://github.com/org-roam/org-roam) is a knowledge management system. Set the directory for notes to `~/notes/`.

```emacs-lisp
;; Org-roam
(straight-use-package 'org-roam)
(setq org-roam-directory (file-truename "~/notes/"))
```


<a id="org-babel"></a>

### Org Babel

Add "shell" to Babel's code execution languages.

```emacs-lisp
;; Add "shell" to Babel's code execution languages.
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))
```


<a id="flyspell"></a>

## Flyspell

[Flyspell](https://www.emacswiki.org/emacs/FlySpell) is a minor mode that enables on-the-fly spell checking. It uses [GNU aspell](http://aspell.net), which is installed via Homebrew:

```shell
brew install aspell
```

To enable Flyspell in text-mode, add a hook:

```emacs-lisp
;; Spell checking: Flyspell
(add-hook 'text-mode-hook 'flyspell-mode)
```


<a id="magit"></a>

## Magit

[Magit](https://magit.vc) is an interface to Git.

```emacs-lisp
;; Git: magit
(straight-use-package 'magit)
```


<a id="elixir"></a>

## Elixir

```emacs-lisp
;; Elixir: elixir-mode
(straight-use-package 'elixir-mode)
```

Automatically format Elixir files on save.

```emacs-lisp
;; Format Elixir files on save
(add-hook 'elixir-mode-hook
	  (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
```

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> Vim and Evil don't have a direct equivalent to fold cycling, but they have three different commands that achieve the same result:

1.  `zf` folds the headline's subtree
2.  `zo` opens the headline's subtree to show its direct descendants
3.  `zO` opens the complete subtree

<sup><a id="fn.2" class="footnum" href="#fnr.2">2</a></sup> Vim and Evil remember jumps between lines and files in the "jump list". Because the jump locations are stored, you can use `C-o` to jump to a previous location, and `C-i` to jump back. For example:

1.  To move to the next empty line, press `}` in normal mode
2.  To jump back to where you came from, press `C-o`
3.  To jump back to that empty line, press `C-i`

<sup><a id="fn.3" class="footnum" href="#fnr.3">3</a></sup> Evil collection prints a warning if it's loaded without `evil-want-keybinding` turned off:

    Warning (evil-collection): Make sure to set `evil-want-keybinding' to nil before loading evil or evil-collection.
    
    See https://github.com/emacs-evil/evil-collection/issues/60 for more details.