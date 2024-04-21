
# ~/.emacs.d

- [Installation](#orgf0925cb)
  - [Packages](#orgc073797)
- [Appearance](#org4cf221a)
  - [Frames](#orga01aee3)
  - [Fonts](#org4931536)
  - [Variable pitch](#orgdbd6df6)
  - [Themes](#org2bca859)
  - [Layout](#org0649c38)
- [Modal editing](#org0ad8172)
  - [Evil mode](#org62198be)
  - [Evil-collection](#orgc3ec33e)
  - [Evil-commentary](#orga163eee)
  - [Cursors](#org9170525)
- [Completion](#orgcdce0f4)
  - [Vertical completion](#org464c358)
  - [Contextual information](#org710d10a)
  - [Enhanced navigation commands](#org074c3c1)
  - [Pattern matching](#org25099c5)
  - [Minibuffer actions](#orga07a242)
  - [Minibuffer history](#orgd5a7d66)
  - [Completion at point](#orgcf296b7)
- [Development](#org4b3e1a1)
  - [Major modes](#org0d15e69)
  - [Environments](#org66dfa9c)
  - [Language servers](#orge935683)
- [Shell](#org00185da)
  - [Terminal emulation](#org48b767c)
  - [History](#org0b5a284)
- [Dired](#org9530648)
- [Org](#org8ac1a17)
- [Email](#orgb3c80af)
- [Enhancements](#orgf99e58c)
  - [Backups](#orgb10f24b)
  - [Key suggestions](#orgca7d5ca)
  - [Projects](#org5cc1e06)
- [Desktop](#org01c12a1)



<a id="orgf0925cb"></a>

## Installation

This whole Emacs configuration, including the configuration file and the included packages is a Nix [derivation](https://nixos.org/manual/nix/stable/language/derivations.html), which means it's installed as a Nix package. For example, to try out this Emacs configuration without affecting the rest of your system, run the following command:

```shell
nix run github:jeffkreeftmeijer/.emacs.d
```

This downloads and compiles Emacs, including dependencies and packages, and starts the resulting Emacs.app. This configuration inherits the system's Nixpkgs, meaning the exact version of Emacs and all packages are subject to the Nixpkgs channel used on the system.


<a id="orgc073797"></a>

### Packages

The following list of packages are added to Emacs through [Nixpkgs' unstable channel](https://search.nixos.org/packages?channel=unstable). In turn, Nixpkgs gets the packages from their git repositories through their [Melpa recipes](https://github.com/melpa/melpa/tree/master/recipes).

-   spacious-padding

-   magit

-   evil

-   evil-collection

-   evil-commentatry

-   vertico

-   marginalia

-   consult

-   orderless

-   embark

-   treesit-auto

-   dockerfile-mode

-   elixir-mode

-   git-modes

-   markdown-mode

-   nix-mode

-   rust-mode

-   typescript-mode

-   yaml-mode

-   direnv

-   which-key


<a id="org4cf221a"></a>

## Appearance


<a id="orga01aee3"></a>

### Frames

Disable the scroll bar, the tool bar, and the menu bar:

```emacs-lisp
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
```


<a id="org4931536"></a>

### Fonts

Use [Iosevka](https://typeof.net/Iosevka/) as a monospace font (*fixed* in Emacs lingo), and Iosevka's "Aile" variant as a (quasi-)proportional font (*variable-pitch* in Emacs lingo).

Both variants are used with their *regular* weights, *expanded* widths, and a height of 150 (15 points × 10):

```emacs-lisp
(defun jk/set-face-font (face family)
  (set-face-attribute
   face nil
   :family family :weight 'regular :width 'expanded :height 150))

(jk/set-face-font 'default "Iosevka")
(jk/set-face-font 'fixed-pitch "Iosevka")
(jk/set-face-font 'variable-pitch "Iosevka Aile")
```

The `face-font-family-alternatives` variable provides fallback fonts if the preferred fonts aren't available. This produces a font list akin to CSS font-families, starting with the preferred font and falling back to an option that is most likely to be available on any system. Having a list of fallback fonts like this removes the need to explicitly depend on fonts being available.

This configuration falls back to Apple's SF Mono and SF Pro if the Iosevka fonts aren't available. Since the Apple fonts need to be downloaded explicitly, they aren't more likely to be there than the Iosevka ones, but they're included as they were the previous favorite.

If the SF fonts aren't available, the fixed font falls back to Menlo before the default monospace font (which is most likely Courier). The variable pitch font falls back to SF Pro, Helvetica, and finally Arial:

```emacs-lisp
(custom-set-variables
  '(face-font-family-alternatives
  '  '(("Iosevka" "SF Mono" "Menlo" "monospace")
  '    ("Iosevka Aile" "SF Pro" "Helvetica" "Arial"))))
```


<a id="orgdbd6df6"></a>

### Variable pitch

To use proportional fonts (as opposed to monospaced fonts) for non-code text, enable `variable-pitch-mode` for selected modes. While this mode is enabled, the `default` font face inherits from `variable-pitch` instead of `fixed-pitch`.

An often-recommended approach is to hook into `text-mode`, which is the major mode most text-based modes inherit from:

```emacs-lisp
(add-hook 'text-mode-hook #'variable-pitch-mode))
```

Doing so automatically enables `variable-pitch-mode` thenever `text-mode` is enabled.

This works, but it's a bit too eager for my liking. The above configuration enables `variable-pitch-mode` when editing Org files, but also when writing commit messages and editing YAML files. I consider text in the latter two as code, so I'd prefer to have those displayed in a monospace font.

Instead of hooking into `text-mode`, explicitly select the modes to use proportional fonts in Org and Markdown mode:

```emacs-lisp
(add-hook 'org-mode-hook #'variable-pitch-mode)
(add-hook 'markdown-mode-hook #'variable-pitch-mode)
```


<a id="org2bca859"></a>

### Themes

The [Modus themes](https://protesilaos.com/emacs/modus-themes) are a set of beautiful and customizable themes, which are shipped with Emacs since version 28.

The modus themes consist of two types: Modus Operandi is a light theme, and Modus Vivendi is its dark counterpart. The tinted variants shift the background colors from white and black to a more pleasant light ochre and dark blue.

When using the version of the Modus themes that's included in Emacs, the themes need to be [explicitly required using `require-theme`](https://protesilaos.com/emacs/modus-themes#h:b66b128d-54a4-4265-b59f-4d1ea2feb073):

```emacs-lisp
(require-theme 'modus-themes)
```

To select `modus-operandi-tinted` as the default theme, load it with the `load-theme` function:

```emacs-lisp
(load-theme 'modus-operandi-tinted)
```

An interactive function named `modus-themes-toggle` switches between the light and dark themes. By default, the function switches between the non-tinted versions, but that can be overwritten to use the tinted versions through the `modus-themes-to-toggle` variable:

```emacs-lisp
(setq modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
```

1.  Switching between dark and light mode

    [Auto-dark](https://github.com/LionyxML/auto-dark-emacs) automatically switches between dark and light themes based on the operating system's appearance.
    
    ```emacs-lisp
    (auto-dark-mode 1)
    ```
    
    It uses the *wombat* and *leuven* themes by default, but these are configured to use the modus themes with the `auto-dark-light-theme` and `auto-dark-dark-theme` variables.
    
    ```emacs-lisp
    (setq (auto-dark-light-theme 'modus-operandi-tinted)
    (setq (auto-dark-dark-theme 'modus-vivendi-tinted))
    ```
    
    With auto-dark in place, Emacs' theme can be switched by toggling the system-wide dark mode instead of using `modus-themes-toggle`. The `jk/dark` and `jk/light` functions run an apple script to turn dark mode on and off from Emacs:
    
    ```emacs-lisp
    (defun jk/dark ()
      "Switch to macOS' dark appearance."
      (interactive)
      (do-applescript
       "tell application \"System Events\"
      tell appearance preferences
        set dark mode to true
      end tell
    end tell"))
    
    (defun jk/light ()
      "Switch to macOS' light appearance."
      (interactive)
      (do-applescript
       "tell application \"System Events\"
      tell appearance preferences
        set dark mode to false
      end tell
    end tell"))
    ```

2.  Customization

    The Modus themes can optionally inherit from the `fixed-pitch` face for some faces, which allows for turning on `variable-pitch-mode` while keeping some text monospaced. To turn it on, set `modus-themes-mixed-fonts`, but make sure it's set before loading one of the modus themes:
    
    ```emacs-lisp
    (setq modus-themes-mixed-fonts t)
    ```
    
    The Modus themes come with the option to use italic and bold constructs, which is turned off by default. Enabling produces italic type for comments and contextual information, and bold type in syntax highlighting.
    
    ```emacs-lisp
    (setq
     modus-themes-italic-constructs t
     modus-themes-bold-constructs t)
    ```
    
    Note that any configuration options to the themes themselves need to happen before the theme is loaded, or the theme needs to be reloaded through `load-theme` after setting the customizations.


<a id="org0649c38"></a>

### Layout

The [spacious-padding](https://protesilaos.com/emacs/spacious-padding) package adds spacing around windows and frames, as well as padding the mode line.

Turn on `spacious-padding-mode` to add spacing around windows and frames:

```emacs-lisp
(spacious-padding-mode 1)
```

Turn on `spacious-padding-subtile-mode-line` for a more subtile mode line:

```emacs-lisp
(setq spacious-padding-subtle-mode-line t)
```


<a id="org0ad8172"></a>

## Modal editing


<a id="org62198be"></a>

### Evil mode

Emacs is the best Vim emulator, and [Evil](https://github.com/emacs-evil/evil) is the best Vim mode. After installing Evil, turn on `evil-mode` globally:

```emacs-lisp
(evil-mode 1)
```


<a id="orgc3ec33e"></a>

### Evil-collection

For Vim-style key bindings to work everywhere (like magit, eshell, dired and [many more](https://github.com/emacs-evil/evil-collection/tree/master/modes)), add [evil-collection](https://github.com/emacs-evil/evil-collection). Initialize it by calling `evil-collection-init`:

```emacs-lisp
(evil-collection-init)
```

Evil-collection [requires `evil-want-keybinding` to be unset](https://github.com/emacs-evil/evil-collection/issues/60) before either Evil or evil-collection are loaded:

```emacs-lisp
(setq evil-want-keybinding nil)
```


<a id="orga163eee"></a>

### Evil-commentary

[Evil-commentary](https://github.com/linktohack/evil-commentary) is an Evil port of [vim-commentary](https://github.com/tpope/vim-commentary) which adds key bindings to call Emacs’ built in `comment-or-uncomment-region` function. Turn it on by calling `evil-commentary-mode`:

```emacs-lisp
(evil-commentary-mode 1)
```


<a id="org9170525"></a>

### Cursors

An example of an essential difference between Emacs and Vim is how they handle the location of the cursor (named point in Emacs). In Vim, the cursor is *on* a character, while Emacs' point is before it. In Evil mode, the cursor changes between a box in "normal mode" to a bar in "insert mode". Because Emacs is always in a kind of insert mode, make the cursor a bar:

```emacs-lisp
(setq-default cursor-type 'bar)
```


<a id="orgcdce0f4"></a>

## Completion


<a id="org464c358"></a>

### Vertical completion

[Vertico](https://github.com/minad/vertico) is a vertical completion library, based on Emacs' default completion system.

```emacs-lisp
(vertico-mode 1)
```


<a id="org710d10a"></a>

### Contextual information

[Marginalia](https://github.com/minad/marginalia) adds extra contextual information to minibuffer completions. For example, besides just showing command names when executing `M-x`, the package adds a description of the command and the key binding.

```emacs-lisp
(marginalia-mode 1)
```


<a id="org074c3c1"></a>

### Enhanced navigation commands

[Consult](https://github.com/minad/consult) provides enhancements to built-in search and navigation commands. There is [a long list of available commands](https://github.com/minad/consult?tab=readme-ov-file#available-commands), but this configuration mostly uses Consult for buffer switching with previews.

1.  Replace `switch-to-buffer` (`C-x b`) with `consult-buffer`:
    
    ```emacs-lisp
    (global-set-key (kbd "C-x b") 'consult-buffer)
    ```

2.  Replace `project-switch-to-buffer` (`C-x p b`) with `consult-project-buffer`:
    
    ```emacs-lisp
    (global-set-key (kbd "C-x p b") 'consult-project-buffer)
    ```

3.  Replace `goto-line` (`M-g g` and `M-g M-g`) with `consult-goto-line`:
    
    ```emacs-lisp
    (global-set-key (kbd "M-g g") 'consult-goto-line)
    (global-set-key (kbd "M-g M-g") 'consult-goto-line)
    ```

4.  Replace `project-find-regexp` (`C-x p g`) with `consult-grep`:
    
    ```emacs-lisp
    (global-set-key (kbd "C-x p g") 'consult-grep)
    ```


<a id="org25099c5"></a>

### Pattern matching

[Orderless](https://github.com/oantolin/orderless) is a completion style that divides the search pattern in space-separated components, and matches regardless of their order. After installing it, add it as a completion style by setting `completion-styles`:

```emacs-lisp
(setq completion-styles '(orderless basic))
```


<a id="orga07a242"></a>

### Minibuffer actions

[Embark](https://github.com/oantolin/embark) adds actions to minibuffer results. For example, when switching buffers with `switch-to-buffer` or `consult-buffer`, pressing `C-.` opens Embark's list of key bindings. From there, you can act on results in the minibuffer. In this exampke, pressing `k` kills the currently selected buffer.

```emacs-lisp
(global-set-key (kbd "C-.") 'embark-act)
```


<a id="orgd5a7d66"></a>

### Minibuffer history

Emacs' `savehist` feature saves minibuffer history to `~/emacs.d/history`. The history is then used to order vertical completion suggestions.

```emacs-lisp
(savehist-mode 1)
```


<a id="orgcf296b7"></a>

### Completion at point

Emacs 30 includes `completion-preview.el`, since [e82d807a2845673e2d55a27915661b2f1374b89a](https://git.savannah.gnu.org/cgit/emacs.git/commit/lisp/completion-preview.el?id=e82d807a2845673e2d55a27915661b2f1374b89a), which adds grayed-out completion previews while typing, akin to the autocomplete in the Fish shell.

```emacs-lisp
(global-completion-preview-mode 1)
```


<a id="org4b3e1a1"></a>

## Development


<a id="org0d15e69"></a>

### Major modes

The [treesit-auto](https://github.com/renzmann/treesit-auto) package automatically installs and uses the tree-sitter equivalent of installed major modes. For example, it automatically installs and uses `rust-ts-mode` when a Rust file is opened and `rust-mode` is installed.

To turn it on globally, enable `global-treesit-auto-mode`:

```emacs-lisp
(global-treesit-auto-mode 1)
```

To automatically install missing major modes, enable `treesit-auto-install`. To have the package prompt before installing, set the variable to `'prompt`:

```emacs-lisp
(custom-set-variables
  '(treesit-auto-install 'prompt))
```


<a id="org66dfa9c"></a>

### Environments

Programming environments set up with [Nix](https://nixos.org) and [direnv](https://direnv.net) alter the environment and available programs based on the current directory. To provide access to programs on a per-directory level, use the [Emacs direnv package](https://github.com/wbolster/emacs-direnv):

```emacs-lisp
(direnv-mode 1)
```


<a id="orge935683"></a>

### Language servers

Eglot is Emacs' built-in Language Server Protocol client. Language servers are added through the `eglot-server-programs` variable:

```emacs-lisp
(add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) "rust-analyzer"))
(add-to-list 'eglot-server-programs '((elixir-ts-mode elixir-mode) "elixir-ls"))
```

Start eglot automatically for Rust files:

```emacs-lisp
(add-hook 'rust-mode #'eglot-ensure))
(add-hook 'rust-ts-mode #'eglot-ensure))
```


<a id="org00185da"></a>

## Shell


<a id="org48b767c"></a>

### Terminal emulation

Use [Eat](https://codeberg.org/akib/emacs-eat/) (Emulate A Terminal) as a terminal emulator. If Eat prints ["garbled" text](https://elpa.nongnu.org/nongnu-devel/doc/eat.html#Garbled-Text), run `M-x eat-compile-terminfo`, then restart the Eat buffer.

Aside from starting the terminal emulator with `M-x eat` and `M-x eat-project`, Eat adds terminal emulation to Eshell with `eat-eshell-mode`. This allows Eshell to run full screen terminal applications.

```emacs-lisp
(eat-eshell-mode 1)
```

Because Eat now handles full screen terminal applications, Eshell no longer has to run programs in a term buffer. Therefor, the `eshell-visual-commands` list can be unset.

```emacs-lisp
(setq eshell-visual-commands nil)
```

Now, an application like `top` will run in the Eshell buffer without a separate term buffer having to be opened.


<a id="org0b5a284"></a>

### History

[Atuin](https://atuin.sh) is a cross-shell utility that stores shell history in a SQLite database. The [eshell-atuin](https://sqrtminusone.xyz/packages/eshell-atuin/) package adds support for both reading from and writing to the history from Eshell.

```emacs-lisp
(eshell-atuin-mode)
```

To read the history in Eshell, bind the `<up>` key to `eshell-atuin-history`, which opens the shell history in the minibuffer. Also unset the `<down>` key, which was bound to `eshell-next-input` for cycling through history in reverse:

```emacs-lisp
(keymap-set eshell-hist-mode-map "<up>" 'eshell-atuin-history)
(keymap-unset eshell-hist-mode-map "<down>")
```

By default, eshell-atuin only shows commands that completed succesfully. To show all commands, change the `eshell-atuin-search-options` variable from `("--exit" "0")` to `nil`:

```emacs-lisp
(setq eshell-atuin-search-options nil)
```

Shell history completion is different from other kinds of completion for two reasons:

1.  Other completion options are presented in a list from top to bottom, with the search prompt at the top. Because `eshell-atuin-history` is opened by pressing the `<up>` key and history is searched backward, the list is reversed by using `vertico-reverse`.

2.  The command history shouldn't be ordered, as that's already handled by Atuin. Instead of ordering the list again, pass `identity` as the `vertico-sort-function`.

Using `vertico-multiform`, which is enabled through `vertico-multiform-mode`, set the above options specifically for the `eshell-atuin-history` function:

```emacs-lisp
(vertico-multiform-mode 1)
(setq vertico-multiform-commands
      '((eshell-atuin-history
	 reverse
	 (vertico-sort-function . identity))))
```


<a id="org9530648"></a>

## Dired

```emacs-lisp
(dirvish-override-dired-mode)
```


<a id="org8ac1a17"></a>

## Org

k


<a id="orgb3c80af"></a>

## Email

Use [notmuch.el](https://notmuchmail.org/notmuch-emacs/) to read email.


<a id="orgf99e58c"></a>

## Enhancements

This section covers general enhancements to Emacs which don't warrant their own section.


<a id="orgb10f24b"></a>

### Backups

Emacs automatically generates [backups](https://www.gnu.org/software/emacs/manual/html_node/emacs/Backup.html) for files not stored in version control. Instead of storing them in the files' directories, put everything in `~/.emacs.d/backups`:

```emacs-lisp
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
```


<a id="orgca7d5ca"></a>

### Key suggestions

With [which-key](https://github.com/justbur/emacs-which-key), Emacs shows suggestions when pausing during an incomplete keypress, which is especially useful when trying to learn Emacs' key bindings. By default, Emacs only shows the already-typed portion of the command, which doesn't help to find the next key to press.

```emacs-lisp
(which-key-mode 1)
```


<a id="org5cc1e06"></a>

### Projects

By default, `project.el` only takes projects into account that have a `.git` directory. Use [project-x](https://github.com/karthink/project-x) to allow for projects that are not under version control, and projects nested within other projects.

Project-x is not on any of the pacakge managers, so this configuration assumes it's installed manually for now. Also, this configuration re-sets `project-find-functions` to try `project-x-try-local` before `project-try-vc` to make it work for projects nested within directories under version control.

```emacs-lisp
(project-x-mode 1)
(setq project-find-functions '(project-x-try-local project-try-vc))
```

With project-x enabled, Emacs will recognise directories with a `.project` file as project directories.<sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>


<a id="org01c12a1"></a>

## Desktop

Enable [`desktop-save-mode`](https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html#Saving-Emacs-Sessions) to save Emacs' state between sessions.

```emacs-lisp
(desktop-save-mode 1)
```

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> Apparently, [`project.el` now supports identifying projects based on a special file in its directory root](https://github.com/karthink/project-x/issues/5#issuecomment-1522535927). Project-x should be obsolete for this purpose, but I haven't figured it out yet.