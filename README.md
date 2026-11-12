# aux for Raven

Addon: `aux-addon` · Interface **11402** · Version **v1.2.5-raven**

## About

Base Classic aux (shirsig) functionality has been adapted toward **1.18**-level Auction House behavior and **RavenCraft 1.14.2** APIs. Stock Blizzard AH UI is hidden when aux opens (use the **Blizzard UI** button if needed).

## Known limitation — multi-page AH scan

**Raven 1.14.2 Auction House API only returns the first page of results** (`QueryAuctionItems` with `page > 0` never fires `AUCTION_ITEM_LIST_UPDATE` and can stick `CanSendAuctionQuery` until the AH is reopened). GetAll is not usable either.

So **aux cannot scan more than one page** (50 auctions) on this client. This is a **client/API limitation**, not an incomplete aux feature alone. Multi-page search/Scan will be fixed after the AH API is corrected or a workaround is proven.

## Status — not a final release

This is **not a finished, bug-free product**. Expect rough edges around scanning, pricing, and Turtle-like AH quirks.

## Bugs / feedback

If you find a problem, open an **Issue** in this repository:

- addon TOC version and client build;
- steps to reproduce at the Auction House;
- expected vs actual result;
- Lua errors / screenshots if available.

## Install

Copy the `aux-addon` folder into `_classic_era_\Interface\AddOns`, then `/reload`. Open the Auction House; use `/aux` for settings.
