# BLACK SOULS II — Magic Book Mod v3.0

A small patch for **BLACK SOULS II v4.4** (RGSS3 / RPG Maker VX Ace).
It only changes the magic book in the Chaos Dungeon.

Chinese version: [README.zh-CN.md](README.zh-CN.md)

## What it changes

| | Vanilla | This mod |
| --- | --- | --- |
| Spawn rate at **DEPTH 7+** | 1/6 (about 17%) | **1/2 (50%)** |
| Spawn rate at DEPTH 0–6 | 1/6 | 1/6 |
| Drop | 11 depth pools (15–63 books each) | **8 books, 1/8 each** |
| Mimic form (1/15) | 1/15 | 1/15 |

Nothing else is changed: scripts, maps, enemies, item stats and save files stay the same.

## The 8 books

| # | Item (CN) | Item (EN) |
| --- | --- | --- |
| 1 | 魔书【黑之斩击】 | Magic Book: Black Slash |
| 2 | 魔书【混沌爆炎】 | Magic Book: Chaos Blaze |
| 3 | 魔书【皇家红茶】 | Magic Book: Royal Black Tea |
| 4 | 魔书【觉醒】 | Magic Book: Awakening |
| 5 | 魔书【黑之波动】 | Magic Book: Black Wave |
| 6 | 圣书【圣骑士的御旗】 | Holy Book: Paladin's Banner |
| 7 | 圣书【卡塔丽娜的车轮】 | Holy Book: Catalina's Wheel |
| 8 | 魔书【神速之舞】 | Magic Book: Dance of Speed |

## Files

| File | What it is |
| --- | --- |
| `Game.rgss3a` | the patched game archive — download it from **Releases** (about 515 MB) |
| `install.bat` | backs up your archive and installs the patched one |
| `uninstall.bat` | restores your original archive |

## Install

1. Close the game completely.
2. Download `Game.rgss3a` from the **Releases** page.
3. Put it in the game folder (the folder that has `Game.exe`).
4. Double-click `install.bat`
   (or drag the game folder onto it).
   It saves your original as `Game.rgss3a.orig.bak` and then replaces the archive.
5. Start the game.

## Uninstall

Double-click `uninstall.bat`. It puts `Game.rgss3a.orig.bak` back.

## Verify

| File | Size | MD5 |
| --- | --- | --- |
| Original Game.rgss3a | 537,579,676 | `c75786318b41e6692a9f6fa191613b4e` |
| Patched Game.rgss3a | 540,157,884 | `3d1b807357225b1681a6c0a37a84a597` |

## Notes

- This repository has no game files. **You must own the game.**
- If the game shows `LoadLibrary: steam_api`, your `Game.rgss3a` is a different
  repack with a Steam script. Use your own original archive with this patch instead.
- If the game shows `读取加密数据失败` (failed to read encrypted data), the download
  is incomplete. Download again and check the size above.
- Android / JoiPlay: after installing on a PC, copy the patched `Game.rgss3a` to the
  game folder on the phone (back up the old one first).
- Save files are not changed.

## Disclaimer

Unofficial fan mod, not affiliated with the game's authors. Back up your files before
installing. Use at your own risk.
