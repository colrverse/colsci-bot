# ColSci Preprint Bot
<!-- badges: start -->
<!-- badges: end -->

This repository contains the source code, and the orchestration behind the 
follow Mastodon bot:

- https://mastodon.social/@colscipreprints@feedsin.space (replaces the retired @colscipreprints twitter bot)

## How it works

Articles are pulled daily from bioRxiv via their API, filtered based on a list of
necessary keywords (stored in `yes.txt`) and a list of excluded keywords (stored
in `no.txt`).

Articles are then posted on the [quarto website](https://colrverse.github.io/colsci-bot), and posted on mastodon via the feedsin.space service.

## Following the bot

### On Mastodon

You can follow the bot from any other Mastodon server. You do no need to create an account on feedsin.space to follow the bot.

### Via RSS

The preprints are also available via an RSS feed: https://colrverse.github.io/colsci-bot/index.xml
