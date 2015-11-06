% Inside Git
% Alexander Bauer
% November 11, 2015

#

# So You've Heard of Git
Git is

- for version control of text
- distributed
- fast
- resistant to corruption and tampering

# What does Git Need to Do?
- Be able to save changes
    - quickly
    - including metadata like message, time, author, *etc.*
    - with a unique global identifier
- Be able to revert to any saved state
    - quickly
    - from any repository
    - using a global identifier
- Be able to send across the network
    - so that collaborators have a complete copy
- Avoid corruption or tampering

# The Paradigm
- A repository is a history of revisions
- Revisions are represented as "commits" and identified by "references"
- Each commit contains
    - A unique identifier
    - Metadata, such as author, timestamp, message
    - All tracked files at that point
- A reference is an ID or name that points to a commit

# Storing arbitrary data
- All history data in Git is an "object"
- Just a file
- Has a header `<type> <length>\0`
- Type may be `commit`, `tree`, or `blob`
- Named and identified using the SHA-1 of its contents
- Compressed using zlib

```
blob 135\x00
.PHONY: all clean

git.html: git.md slides.css
	pandoc --standalone --to dzslides $^ --output $@
...
```

# What is a Commit?
- Just an object
- Commit ID is just the object's filename
- Contains author, committer, parent, message
- Root tree ID

```
$ git cat-file -p c42f971

tree 3ae5304f1b1fe9daee6c54263cac76423c3a7cff
parent 0d6fb7e982bbb4d12348da36c934cafc37dbd81c
author Alexander Bauer <sasha@linux.com> 1446840627 -0500
committer Alexander Bauer <sasha@linux.com> 1446840627 -0500

Clarify Makefile
```

# What is a Tree?
- Just an object
- Represents a directory during one revision
- Contains other trees and "blobs"

```
$ git cat-file -p 3ae5304

100644 blob 2d19fc7...	.gitignore
100644 blob c744e9b...	Makefile
100644 blob 2a2cc88...	git.md
040000 tree 7841614...	images
```

# What is a Blob?
- Just an object
- Represents a file during one revision
- Same content as of the file it represents

```
$ git cat-file -p c744e9b

.PHONY: all clean

git.html: git.md slides.css
	pandoc --standalone --to dzslides $^ --output $@
...
```

# Ensuring Uniqueness
- Blobs
    - depend only on the file content
    - are reused across many revisions
    - change ID if *any* file content changes

# Ensuring Uniqueness
- Trees
    - depend on any trees and blobs underneath
    - are reused if their subtrees and blobs do not change
    - change ID if *any* subtree or blob changes ID

# Ensuring Uniqueness
- Commits
    - depend on metadata, and the root repository tree
    - are never reused, will always change ID
    - change ID if any metadata changes
    - change ID because the root tree must change ID

# Properties of a Commit
- Commit includes metadata
- Commit includes ID of root tree
    - Root tree and its subtrees contain all blobs for that revision
    - Blobs represent file contents
    - Can rebuild entire state at revision from root tree ID
- Commit includes ID of parent commit
    - Each parent commit contains its own root tree
    - Can traverse backwards in history
    - Can compare different commits (produce diffs, changelogs, *etc*)
    - Can ensure from just one commit that all of history is correct

# Results of Commit Properties
- Each commit has all files for a revision
- Only stores new copies of files when they change
- Can "branch" with multiple commits refer to the same parent
- Can "merge" with one commit refer to multiple parents
- Objects can be serialized over the network
- Sharing a commit ID ensures that all of history is the same

# What are References?
- Can take be any of:
    - `HEAD`
    - branch name
    - tag name
    - commit*ish*
- Resolves to one commit ID
- Each kind is just a file

# Kinds of References
- `HEAD`
    - contains either a branch identifier or a commit ID
    - always the reference to the "checked out" revision
- branches
    - contain one commit ID
    - are updated to refer to new commits (by `git commit`)
- tags
    - contain one commit ID
    - never change

# Putting it All Together
- We can have one or more branches or tags
- Can traverse anywhere in history
- Store complete copies of files, not diffs
- Can serialize all of history over the network
- Can share commit IDs and be sure history is correct

[git logo]: https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png
[github repository image]: images/githubrepositoryimage.png
