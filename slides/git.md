% Inside Git
% Alexander Bauer
% November 11, 2015

![][git logo]

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
- A repository contains a list of commits and references
- Each commit contains
    - A unique identifier
    - A discrete unit of change
    - Metadata
    - All tracked files at that point
- A branch or tag is just a commit id

# What Should a Repository Look Like?
![][github repository image]


[git logo]: http://git-scm.com/images/logos/download/Git-Logo-2Color.png
[github repository image]: githubrepositoryimage.png
