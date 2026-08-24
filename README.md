# omarchy-dynamic-wallpaper

Omarchy plugin that changes the desktop background through the day, using your
own folder of images. During the last minutes of each hour it asks the Omarchy
background shell to blend toward the next image, so the change reads more like
the day passing than a wallpaper swap.

Requires Omarchy 4 or later. No images are bundled — bring your own.

## Install

```bash
omarchy plugin add https://github.com/mateCreations/omarchy-dynamic-wallpaper --enable
```

Then drop any images into `~/.config/omarchy/backgrounds/dynamic/`:

```bash
mkdir -p ~/.config/omarchy/backgrounds/dynamic
cp ~/Pictures/my-wallpapers/*.jpg ~/.config/omarchy/backgrounds/dynamic/
omarchy restart shell
```

That is the whole setup. `.jpg`, `.jpeg`, `.png`, and `.webp` are picked up.

## How images map to the day

Images are used in filename order and spread evenly across 24 hours. Two
images change every twelve hours, four change every six, twenty-four change
every hour. Name them so they sort in the order you want them to appear:

```
~/.config/omarchy/backgrounds/dynamic/
├── 01-dawn.jpg     # 00h → 05h
├── 02-noon.jpg     # 06h → 11h
├── 03-dusk.jpg     # 12h → 17h
└── 04-night.jpg    # 18h → 23h
```

Naming files after the hour works too: a set of `0.jpg` through `23.jpg`
gives one image per hour.

## Options

Both are environment variables read by `bin/dynamic-wallpaper`:

- `DYNAMIC_WALLPAPER_SET` — folder to use, either an absolute path or a name
  under `~/.config/omarchy/backgrounds`. Defaults to `dynamic`.
- `DYNAMIC_WALLPAPER_TRANSITION_MINUTES` — length of the crossfade into the
  next image, in minutes. Defaults to `5`; set `0` to switch instantly.

The script can also be run by hand against any folder:

```bash
~/.config/omarchy/plugins/harbefas.dynamic-wallpaper/bin/dynamic-wallpaper ~/Pictures/some-set
```

## Requirements

A standard Linux userland only: `bash`, `awk`, `find`, and `date`. The plugin
makes no network requests, installs no system service, and needs no elevated
privileges. It writes exactly one path outside its own directory, the Omarchy
background state link at `~/.local/state/omarchy/current/background`, which is
the supported way to set the current background.

## Remove

```bash
omarchy plugin remove harbefas.dynamic-wallpaper
```

Your images in `~/.config/omarchy/backgrounds/dynamic/` are left untouched;
delete that folder yourself if you want it gone. Pick a new background through
the Omarchy menu afterwards to replace the last one this plugin set.

## License

MIT

Part of the [mateCreations](https://github.com/mateCreations) ecosystem.
