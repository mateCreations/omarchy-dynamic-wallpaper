# omarchy-dynamic-wallpaper

Dynamic wallpaper for [Omarchy](https://omarchy.org) — automatically changes based on the time of day.

Images are named by hour (`0.jpg`, `6.jpg`, `12.jpg`, etc.) and the script picks the closest match for the current time. Runs hourly via a systemd timer.

Includes **cliffs** as an example wallpaper set with 24 images (one per hour).

Requires Omarchy 4 or later — the background is applied with `omarchy-theme-bg-set`.

## Installation

```bash
git clone https://github.com/mateCreations/omarchy-dynamic-wallpaper
cd omarchy-dynamic-wallpaper
```

Copy the script:

```bash
cp dynamic-wallpaper ~/.local/bin/
chmod +x ~/.local/bin/dynamic-wallpaper
```

Copy your wallpaper set:

```bash
cp -r backgrounds/cliffs ~/.config/omarchy/backgrounds/
```

Copy and enable the systemd units:

```bash
cp systemd/dynamic-wallpaper.* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now dynamic-wallpaper.timer
```

## Usage

```bash
# Run manually with a wallpaper set
dynamic-wallpaper cliffs

# Check timer status
systemctl --user status dynamic-wallpaper.timer
```

## Adding your own wallpaper set

Create a folder under `~/.config/omarchy/backgrounds/<name>/` and add images named by hour:

```
~/.config/omarchy/backgrounds/my-set/
├── 0.jpg    # midnight → 5h
├── 6.jpg    # 6h → 11h
├── 12.jpg   # 12h → 17h
└── 18.jpg   # 18h → 23h
```

You don't need an image for every hour — the script picks the closest one that is ≤ the current hour.

Then update the service to use your set:

```ini
# ~/.config/systemd/user/dynamic-wallpaper.service
ExecStart=%h/.local/bin/dynamic-wallpaper my-set
```

Part of the [mateCreations](https://github.com/mateCreations) ecosystem.
