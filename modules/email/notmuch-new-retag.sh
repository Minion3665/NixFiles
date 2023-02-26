#!/usr/bin/env sh

# Tag messages that are in our inbox with inbox
# Note we don't tag everything inbox: this is to stop stuff like shared folders
# coming up in inbox as that adds >100k messages and makes everything very slow
notmuch tag +inbox -new -- tag:new folder:"collabora/Inbox"

# Finally, remove all the rest of the new tags so that this isn't run again
notmuch tag -new -- tag:new
