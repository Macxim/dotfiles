# Macxim's `dotfiles`

<div align="center">
    <img width="200" margin-bottom="10" src=".zas.gif">
  <h1>¡Zas!</h1>
</div>

> In Spanish, onomatopoeia used to imitate the sound of a blow, or the blow itself.
Also used repeatedly. ([source](http://lema.rae.es/drae/?val=zas))

## Hajimete [[?](http://jisho.org/word/%E5%88%9D%E3%82%81%E3%81%A6)]

```
$ curl -fsSL https://raw.github.com/Macxim/dotfiles/master/hajimete | zsh
```

## Commands & aliases

### `$ zas`

This command should update this repository, then trigger `zasca` (which is the heart of these _dotfiles_).

### `$ .f`

Open your dotfiles using `open` command (eg: on macOS, Finder.app).

### `$ e [file]`

Open a file/directory in your [configured editor](components/atom/editor.zsh) (Atom in my case).
If you don't provide any argument, this will open the current folder.


### `$ .fe`

Open your dotfiles in your [configured editor](components/atom/editor.zsh) (Atom in my case).

### `$ .symlinks`

Link all `*.symlink` files into your `~/`.
When you run this command, you will be asked if there are already existing files.

### `$ .submodules-update`

Update & commit updated submodules.


---

## Component definition

Here is what is automatically handled by this awesome [index.zsh](index.zsh) (inspired by [@holman's](https://github.com/holman) work).

- `component/*.zsh`: Any files ending in .zsh get loaded into your environment.
- `component/path.zsh`: Any file named `path.zsh` is _loaded first_ and is expected to setup $PATH or similar.
- `component/completion.zsh`: Any file named `completion.zsh` is _loaded last_ and is expected to setup autocomplete.
- `component/functions/`: component functions should be defined here.
- `component/setup`: component setup is done in this file.
- `component/*.symlink`: Any files ending in `*.symlink` get symlinked into your $HOME (_prefixed by `.`_). This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run `$ .symlinks`.

**Note: to setup one component only, just run `$ setup {component_name}`**

---

## Inspired by

- https://github.com/MoOx/dotfiles
- https://github.com/holman/dotfiles
- https://github.com/mathiasbynens/dotfiles
- https://github.com/necolas/dotfiles
- https://github.com/kud/my/
