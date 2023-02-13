#!/usr/bin/env sh

# Tag messages that are in our trash with deleted. These don't necessarily need
# to be new messages. For speed we won't tag anything that we have already
# tagged.
notmuch tag +deleted -- folder:"collabora/Trash" and not tag:deleted

# Tag messages that are in our inbox with inbox
# Note we don't tag everything inbox: this is to stop stuff like shared folders
# coming up in inbox as that adds >100k messages and makes everything very slow
notmuch tag +inbox -new -- tag:new folder:"collabora/Inbox"

# Finally, remove all the rest of the new tags so that this isn't run again
notmuch tag -new -- tag:new
