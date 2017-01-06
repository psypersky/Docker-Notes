

##### Using Dockerfiles or Images
Knowing both solutions advantages and inconvenient is a good start. Because a mix of the two is probably a valid way to go.

Con: avoid the golden image dead end:

Using only commits is bad if you lose track of how to rebuild your image. You don't want to be in the state that you can't rebuild the image. This final state is here called the golden image as the image will be your only reference, starting point and ending point at each stage. If you loose it, you'll be in a lot of trouble since you can't rebuild it. The fatal dead end is that one day you'll need to rebuild a new one (because all system lib are obsolete for instance), and you'll have no idea what to install... ending in big loss of time.

As a side note, it's probable that using commits over commits would be nicer if the history log would be easily usable (consult diffs, and repeat them on other images) as it is in git: you'll notice that git don't have this dilemma.

Pro: slick upgrades to distribute

In the other hand, layering commits has some considerable advantage in term of distributed upgrades and thus in bandwidth and deploy time. If you start to handle docker images as a baker is handling pancakes (which is precisely what docker permits), or want to deploy tests version instantly, you'll be happier to send just a small update in the form of a small commit rather a whole new image. Especially when having continuous integration for your customers where bug fixes should be deployed soon and often.

Try to get the best of two worlds:

In these type of scenario, you'll probably want to tag major version of your images and they should come from Dockerfiles. And you can provide continuous integration versions thanks to commits based on the tagged version. This mitigates advantages and inconvenients of Dockerfiles and layering commits scenario. Here, the key point is that you never stop keeping track of your images by limiting the number of commits you'll allow to do on them.

So I guess it depends on your scenario, and you probably shouldn't try to find a single rule. However, there might be some real dead-ends you should really avoid (as ending up with a "golden image" scenario) whatever the solution.
