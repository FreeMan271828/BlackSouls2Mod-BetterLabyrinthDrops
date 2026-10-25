# BLACK SOULS II · 魔书 Mod v3.0 ｜ Magic Book Mod v3.0

[中文](#中文) · [English](#english)

> 适用游戏：**BLACK SOULS II v4.4**（RGSS3 / RPG Maker VX ACE，简体中文版）
> Tested on: **BLACK SOULS II v4.4** (RGSS3 / RPG Maker VX Ace, Simplified Chinese release)
>
> 本仓库只提供**补丁脚本**，不包含游戏本体。
> This repository contains a **patcher script** only — no game data is distributed.

---

## 中文

### 简介

这是一个轻量的数据修正 Mod，只改混沌迷宫里「魔书」的两件事：

1. **出现率**：深度（DEPTH）达到 **7 及以上** 时，由原版 **1/6** 提升到 **1/2（50%）**；深度 ≤ 6 保持原版 1/6 不变。
2. **掉落**：原来按深度分 11 个池（每池 15～63 种书），统一改为**固定 8 种书、每种 1/8**。

除上述两点外，脚本（Scripts）、地图、敌人、物品属性、陷阱形态等**全部保持原版**。

### 改动一览

| 项目 | 原版 | 本 Mod |
| --- | --- | --- |
| 魔书出现率（DEPTH ≥ 7） | 1/6（≈16.7%） | **1/2（50%）** |
| 魔书出现率（DEPTH ≤ 6） | 1/6 | 保持 1/6 |
| 魔书掉落 | 11 个深度池，每池 15/22/30/39/55/63 种 | **固定 8 种，各 1/8** |
| 陷阱形态「魔書ミミック」 | 1/15 | 保持原版 1/15 |
| 其它数据（脚本/地图/敌人/物品属性） | — | 未改动 |

> 关于深度：混沌迷宫每约 20 层判定一次深度提升（10 / 30 / 50 / … / 130 层），所以「深度 7」大约从第 130 层左右开始。

### 掉落列表（8 种，各 1/8）

| # | 物品 | Item | Item ID |
| --- | --- | --- | --- |
| 1 | 魔书【黑之斩击】 | Magic Book: Black Slash | 374 |
| 2 | 魔书【混沌爆炎】 | Magic Book: Chaos Blaze | 359 |
| 3 | 魔书【皇家红茶】 | Magic Book: Royal Black Tea | 369 |
| 4 | 魔书【觉醒】 | Magic Book: Awakening | 375 |
| 5 | 魔书【黑之波动】 | Magic Book: Black Wave | 373 |
| 6 | 圣书【圣骑士的御旗】 | Holy Book: Paladin's Banner | 372 |
| 7 | 圣书【卡塔丽娜的车轮】 | Holy Book: Catalina's Wheel | 371 |
| 8 | 魔书【神速之舞】 | Magic Book: Dance of Speed | 370 |

### 原理

- 「魔书」是混沌迷宫每层地图上的事件，由开关 **674「魔書出現」** 控制是否出现。
- 换层时公共事件 **#276「次の階層へ」** 会掷一次 `变量118 = rand(1..6)`，只有命中 1 才打开开关 674 → 原版 **1/6**。
  - Mod 在 #276 中插入深度判断（**变量 117 = 深度 DEPTH**）：`DEPTH >= 7` 时改用 `rand(1..2)` → **1/2**，否则保持 `rand(1..6)` → 1/6。
- 魔书给书由公共事件 **#280「魔書中身」** 处理（原本有 11 个按深度区分的池）。
  - Mod 把每个池的随机范围改为 `rand(1..8)`，并把前 8 个分支的物品 ID 换成上表 8 种。
- 动手范围：只重写 `Game.rgss3a` 内的 **`Data\CommonEvents.rvdata2`** 一个文件。

### 安装

**整包替换（从 Releases 下载）**

1. 完全退出游戏。
2. 从本仓库的 **Releases** 页面下载打好补丁的 `Game.rgss3a`（约 515 MB）。
3. 把这个文件放进游戏根目录（和 `Game.exe` 同一层）。
4. 双击本仓库的 `install.bat`（或把游戏目录拖到它上面）：
   它会先把你的原档备份成 `Game.rgss3a.orig.bak`，再替换成打好补丁的档案。
5. 启动游戏即可。

> 手动替换也可以：先备份原 `Game.rgss3a`，再用下载的档案覆盖同名文件。

### 卸载

双击 `uninstall.bat`，它会把 `Game.rgss3a.orig.bak` 还原回 `Game.rgss3a`。

### 校验值

| 档案 | 大小 | MD5 |
| --- | --- | --- |
| 原版 `Game.rgss3a` | 537,579,676 | `c75786318b41e6692a9f6fa191613b4e` |
| 打好补丁的 `Game.rgss3a` | 540,157,884 | `3d1b807357225b1681a6c0a37a84a597` |
| 原版 `CommonEvents.rvdata2` | 2,578,086 | `7582117602d857d7f50b1c2d6ea4982a` |
| 修改后 `CommonEvents.rvdata2` | 2,578,208 | `76b93668100eb646ac7aa68d5d5aa55a` |

### 常见问题（FAQ）

- **启动时报 `脚本 'steam_acheivement' 第 82 行: 发生 RuntimeError。LoadLibrary: steam_api`**
  这不是本 Mod 的内容。该报错来自某些带 **Steam 成就脚本**的「整合/汉化整包」，在非 Steam 环境启动时会去找 `steam_api.dll`。本 Mod v3.0 **不含该脚本**——用本工具对你自己的原版档案打补丁不会出现。若遇到它，说明当前 `Game.rgss3a` 是那种整包，换回原版档案再打补丁即可。
- **报 `读取加密数据失败`**：档案复制不完整（大小不对）。重新复制，或重新用脚本打补丁。
- **打完补丁但没感觉变化**：先确认游戏进程已完全退出再重开；确认运行的是同一个目录下的 `Game.rgss3a`（不是别的副本/模拟器缓存）；确认没有多个副本同时在用。
- **安卓 / JoiPlay**：在电脑上对 `Game.rgss3a` 打完补丁后，再把文件复制到手机游戏目录覆盖（先备份手机上的原档）。
- **报 `unsupported game build`**：你的游戏版本与 v4.4 数据结构不同。可以加 `--force` 强制尝试，但**不保证可用**；结构不匹配时脚本会直接失败，不会写出半成品。

### 兼容性与限制

- 仅针对 **BLACK SOULS II v4.4（简体中文版）** 的 `CommonEvents.rvdata2` 结构编写，并通过 MD5 校验确认基底版本。
- 补丁只改事件数据，**不影响存档**；卸载/回滚随时可做。
- 请勿在打补丁过程中运行游戏；不要同时安装多个来源的整包。

### 免责声明

本项目为个人兴趣制作的非官方 Mod，与游戏原作者无关。请支持正版。本仓库不包含任何游戏本体资源；修改前请自行备份档案，风险自负。

### 更新日志

- **v3.0**：魔书出现率（DEPTH ≥ 7）改为 1/2；掉落统一为固定 8 种（各 1/8）；提供整包替换（install.bat / uninstall.bat）。
- **v2.1（旧版，不再提供）**：基于另一份游戏整包，出现率 1/3，且带有 Steam 成就脚本（非 Steam 环境会报 `steam_api` 错误）。

---

## English

### Overview

A small data-only mod for the **Chaos Dungeon magic book** in *BLACK SOULS II*. It changes exactly two things:

1. **Spawn rate**: at **DEPTH ≥ 7** it goes from the vanilla **1/6** to **1/2 (50%)**; at DEPTH ≤ 6 it stays 1/6.
2. **Drop pool**: the 11 depth-based pools (15/22/30/39/55/63 entries each) are replaced by a **fixed set of 8 books, 1/8 each**.

Everything else — scripts, maps, enemies, item stats, the 1/15 mimic ("trap") form — is untouched.

### Changes

| | Vanilla | This mod |
| --- | --- | --- |
| Magic-book spawn (DEPTH ≥ 7) | 1/6 (≈16.7%) | **1/2 (50%)** |
| Magic-book spawn (DEPTH ≤ 6) | 1/6 | 1/6 |
| Drop | 11 depth pools (15/22/30/39/55/63 books) | **fixed 8 books, 1/8 each** |
| Mimic form (魔書ミミック) | 1/15 | 1/15 (unchanged) |
| Scripts / maps / enemies / item stats | — | unchanged |

> Depth increases roughly every 20 floors (at floors 10 / 30 / 50 / … / 130), so DEPTH 7 starts around floor ~130.

### Drop list (8 books, 1/8 each)

| # | Item | ID |
| --- | --- | --- |
| 1 | 魔书【黑之斩击】 Magic Book: Black Slash | 374 |
| 2 | 魔书【混沌爆炎】 Magic Book: Chaos Blaze | 359 |
| 3 | 魔书【皇家红茶】 Magic Book: Royal Black Tea | 369 |
| 4 | 魔书【觉醒】 Magic Book: Awakening | 375 |
| 5 | 魔书【黑之波动】 Magic Book: Black Wave | 373 |
| 6 | 圣书【圣骑士的御旗】 Holy Book: Paladin's Banner | 372 |
| 7 | 圣书【卡塔丽娜的车轮】 Holy Book: Catalina's Wheel | 371 |
| 8 | 魔书【神速之舞】 Magic Book: Dance of Speed | 370 |

### How it works

- The magic book is a map event on every Chaos Dungeon floor, gated by switch **674 ("魔書出現")**.
- On floor transition, common event **#276 「次の階層へ」** rolls `variable 118 = rand(1..6)` and only turns switch 674 on when the roll is 1 → vanilla **1/6**.
  - The mod inserts a depth check (variable 117 = **DEPTH**): when `DEPTH >= 7` it uses `rand(1..2)` → **1/2**, otherwise `rand(1..6)` → 1/6.
- The reward is handled by common event **#280 「魔書中身」** (originally 11 depth-based pools).
  - The mod changes every pool to `rand(1..8)` and remaps branches 1–8 to the items above.
- Only **`Data\CommonEvents.rvdata2`** inside `Game.rgss3a` is rewritten.

### Installation

**Whole-archive replacement (download from Releases)**

1. Close the game completely.
2. Download the patched `Game.rgss3a` from the **Releases** page (about 515 MB).
3. Put it in the game folder (next to `Game.exe`).
4. Run `install.bat` (or drag the game folder onto it). It backs up your original
   archive as `Game.rgss3a.orig.bak` and then replaces it.
5. Start the game.

### Uninstall

Run `uninstall.bat` — it restores `Game.rgss3a.orig.bak`.

### Checksums

| File | Size | MD5 |
| --- | --- | --- |
| vanilla `Game.rgss3a` | 537,579,676 | `c75786318b41e6692a9f6fa191613b4e` |
| patched `Game.rgss3a` | 540,157,884 | `3d1b807357225b1681a6c0a37a84a597` |
| vanilla `CommonEvents.rvdata2` | 2,578,086 | `7582117602d857d7f50b1c2d6ea4982a` |
| patched `CommonEvents.rvdata2` | 2,578,208 | `76b93668100eb646ac7aa68d5d5aa55a` |

### FAQ / Troubleshooting

- **`Script 'steam_acheivement' line 82: RuntimeError. LoadLibrary: steam_api` on startup.**
  Not part of this mod. That error comes from certain repackaged builds that include a
  **Steam achievements script** and try to load `steam_api.dll` outside Steam. This mod does
  **not** contain that script — patching your own untouched archive won't produce it. If you
  see it, your `Game.rgss3a` is such a repack; restore your original archive and run the patcher on it.
- **`读取加密数据失败` (failed to read encrypted data)**: the archive copy is incomplete (wrong size). Re-copy or re-patch.
- **No visible change after patching**: make sure the game process was fully closed before patching, that you are launching the *same* `Game.rgss3a` you patched.
- **Android / JoiPlay**: patch `Game.rgss3a` on a PC first, then copy it into the game folder on the phone (back up the phone copy first).
- **`unsupported game build`**: your game data differs from v4.4. `--force` exists but is unsupported; if the structure doesn't match, the script fails cleanly instead of writing a broken archive.

### Compatibility & notes

- Written for the **BLACK SOULS II v4.4 (Simplified Chinese)** `CommonEvents.rvdata2` layout; the base file is verified by MD5.
- The mod touches event data only; **save files are unaffected** and it can be reverted at any time.
- Don't patch while the game is running, and don't mix archives from multiple sources.

### Disclaimer

Unofficial fan mod, not affiliated with the game's authors. Please support the official release.
This repository ships **no game assets**. Back up your files before patching — use at your own risk.

### Changelog

- **v3.0**: spawn rate at DEPTH ≥ 7 → 1/2; fixed 8-book drop pool (1/8 each); whole-archive install/uninstall scripts.
- **v2.1 (legacy, no longer provided)**: based on a different repacked build, 1/3 spawn rate, and included a Steam achievements script (crashes with `steam_api` outside Steam).
