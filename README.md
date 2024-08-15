# ColSci Mastodon Bot

<!-- badges: start -->
<!-- badges: end -->

This repository contains the source code, and the orchestration behind the 
follow Mastodon bots:

- https://botsin.space/@colsci_preprints (replaces the retired @colscipreprints twitter bot)

## How it works

Articles are pulled from bioRxiv via their API, filtered based on a list of
necessary keywords (stored in `yes.txt`) and a list of excluded keywords (stored
in `no.txt`).

Articles are then posted on Mastodon via the [rtoot R package](https://github.com/gesistsa/rtoot).

## Following the bot

You can follow the bot from any other Mastodon server. You do no need to create an account on botsin.space to follow the bot.

