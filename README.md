fieldfunds
==========

Contains public financial info from the Field Museum in a more [usable form](https://raw.github.com/bomeara/fieldfunds/master/FieldMuseum.txt). Note that this came from info in auditing reports [posted by the Field Museum](http://fieldmuseum.org/about/annual-reports) (as of right now (May 23, 2013) only 2005-2011 are available). I also include sample code to parse the information and do a few plots. Note that I record expenses as negative values, so rows can be added to get net growth/loss without having to parse the rownames to know whether an item is an expense or a revenue. This does require taking absolute value for other plots (such as expenditures changing through time).

The Field Museum is a great museum with a proud history, but [news reports](http://articles.chicagotribune.com/2012-12-19/news/chi-field-museum-to-cut-staff-overhaul-operations-and-limit-research-scope-20121218_1_natural-history-museum-field-museum-museum-officials) suggest it will be substantially cutting back on research and staff to try to fight deficits. I wanted to dig into the budget to see why this is happening, despite the improving economy, and created this code and data. I decided to post this so that those with better skills at making plots and those with more knowledge of museum financing can do more with it. Note that I have checked the raw data after I transcribed it, but there still may be errors. All my code and scripts are licensed under [CC0](http://creativecommons.org/publicdomain/zero/1.0/) as much as possible; I do not know what license the original Field Museum data were released under, but I believe this is fair use.

Some sample plots (I'm hoping others will do better with these data):

*Percent change in funding:*
[![Percent change in funding](https://github.com/bomeara/fieldfunds/blob/master/PercentSpendingChange.png?raw=true)](#percentchange)

Highlights include the growth of marketing (costing over twice as much as in 2005) and administrative costs while funds for exhibitions, collections, research, education, and conservation have all decreased. See [here](https://github.com/bomeara/fieldfunds/blob/master/MonetarySpendingChange.png?raw=true) for the change in dollar terms instead of as a percentage (for example, the total expenditure for marketing and administration went up by $3.0M while expenditure for collections and research dropped by $2.9M from 2005 to 2011).


*Effect of investment returns:*
[![Investment returns](https://github.com/bomeara/fieldfunds/blob/master/AssetsVsInvestment.png?raw=true)](#investment)

The Field Museum budget has many costs (education, collections, cost to get donors, etc.) and inputs (grants, sponsorships, admissions, etc.). This plot suggests that much of the growth or decline of net assets is being driven by investment returns.


*Effect of marketing (linear regression)*
[![Marketing impact](https://github.com/bomeara/fieldfunds/blob/master/MarketingImpact.png?raw=true)](#marketing)

This suggests that marketing doesn't pay off well, but note this doesn't control for other factors; maybe more marketing makes the losses less bad in down years, for example.

