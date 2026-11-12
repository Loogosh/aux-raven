# aux for Raven 1.14.2

Base: Classic aux **v1.2.3** (shirsig). Target: RavenCraft `1.14.2` + Turtle-like AH.

Not the Turtle 1.12 fork in `F:\wow ai\aux-addon` (HearthDB / Aux-Revamped). That stays on `twmoa_1180`.

## Why Classic base

| API | Raven (measured) | Classic aux | Turtle 1.12 fork |
|---|---|---|---|
| `GetAuctionItemInfo` | **18** returns, `has_all_info` | matches | Vanilla 13-field unpack |
| `QueryAuctionItems` | Classic arg order + category filters | matches | Vanilla class/subclass indices |
| `PostAuction` | present (duration 1/2/3 → 2/8/24h) | matches | `StartAuction` + minutes |
| `AuctionCategories` | after `AuctionFrame_LoadUI` | used | absent |

## Raven / 1.18 AH notes

- Page size **50**; one outstanding list query; ~client `CanSendAuctionQuery` gate.
- **No GetAll** dump on server (client may still report `canQueryAll`). Scan button pages.
- Owners arrive as GUID → name resolve; default `/aux ignore owner` on.
- Durations: client codes `1/2/3` → **2h / 8h / 24h**.
- Deposit: use live `GetAuctionDeposit` / UI formula; no Turtle `×0.6` hack in this port.

## Raven patches (`raven.lua` + edits)

1. Early `AuctionFrame_LoadUI` so `AuctionCategories` exists for filters.
2. Force `get_all = false` in scan path.
3. Do not nil `_G.AuctionFrame_Show` (coexist with TSM).
4. Skip «WoW Token» category in dropdowns/suggestions.
5. Map `Weapon`/`Weapons` → class index 1.
6. Drop unused `require 'aux.core.stack'`.

## Deploy

```
Source:  F:\wow ai\1.14\Addons\aux-addon\
Client:  F:\Game\WOW Turtle\1_14\3\_classic_era_\Interface\AddOns\aux-addon\
```

`/reload` after copy. Open AH → aux frame; `/aux` for settings.

## Optional later

Layer Turtle-fork HearthDB market features via `F:\wow ai\aux-addon\tools\PORT_ORDER.txt`, rewriting `module`/`arg1`/`StartAuction` onto this Classic base + `LibRavenDB`.
