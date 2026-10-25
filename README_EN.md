# BLACK SOULS II — Magic Book Mod v3.0

A small patch for **BLACK SOULS II v4.4** (RGSS3 / RPG Maker VX Ace).
It only touches the magic book in the Chaos Dungeon.

## What it changes

- **Spawn rate**: the magic book now has a **50%** chance to appear at **DEPTH 7 and above**.
  At DEPTH 0–6 it stays at the original **1/6**.
- **Drop**: the book gives **one of 8 books**, each with a **1/8** chance.
  The original depth-based pools are removed.
- Nothing else is changed: scripts, maps, enemies, items and the 1/15 mimic form stay vanilla.

## The 8 books

| # | Item (CN) | Item (EN) |
| --- | --- | --- |
| 1 | 魔书【黑之斩击】 | Black Slash |
| 2 | 魔书【混沌爆炎】 | Chaos Blaze |
| 3 | 魔书【皇家红茶】 | Royal Black Tea |
| 4 | 魔书【觉醒】 | Awakening |
| 5 | 魔书【黑之波动】 | Black Wave |
| 6 | 圣书【圣骑士的御旗】 | Paladin's Banner |
| 7 | 圣书【卡塔丽娜的车轮】 | Catalina's Wheel |
| 8 | 魔书【神速之舞】 | Dance of Speed |

## Requirements

- BLACK SOULS II v4.4 (Simplified Chinese release)
- Python 3.8+
- `pip install rubymarshal`

## Install

1. Close the game.
2. Run the patcher on your own copy:

```bash
python tools/apply_mod.py "D:\Game\BLACK SOULS II\Game.rgss3a"
```

The script makes a backup (`Game.rgss3a.orig.bak`) and checks the result.

## Uninstall

```bash
python tools/apply_mod.py --restore "D:\Game\BLACK SOULS II\Game.rgss3a"
```

## Check status / checksums

```bash
python tools/apply_mod.py --info "D:\Game\BLACK SOULS II\Game.rgss3a"
```

| File | Size | MD5 |
| --- | --- | --- |
| Original Game.rgss3a | 537,579,676 | `c75786318b41e6692a9f6fa191613b4e` |
| Patched Game.rgss3a | 540,157,884 | `3d1b807357225b1681a6c0a37a84a597` |

## Notes

- This repository contains **no game files**. You need your own copy of the game.
- If you get `LoadLibrary: steam_api`, your `Game.rgss3a` is a repack with a Steam
  achievement script. This mod does not use Steam. Restore your original archive and patch it again.
- If you get `读取加密数据失败` (failed to read encrypted data), the file copy is
  incomplete. Copy it again (check the size).
- Android / JoiPlay: patch on a PC, then copy `Game.rgss3a` to the phone.
- The patch changes event data only. Save files are not affected.

## Disclaimer

Fan-made mod. Not official. Back up your files before patching. Use at your own risk.
