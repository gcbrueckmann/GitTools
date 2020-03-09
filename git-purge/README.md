git-purge
=========

Automatically delete local branches when their remote tracking branches have gone.

## Options

| Option | Description |
|-|-|
| `-f` | Allow deleting branches irrespective of their merged status. |
| `-l` | List branches eligible for purging, but do not purge them. |
| `-h` | Show this help. |

## Examples
### Listing Candidate Branches

To list branches that are candidates for deletion, run:

```
git-purge -l
```

### Automatically Deleting Branches

To automatically delete branches whose remote tracking branches have gone, run:

```
git-purge
```

#### Deleting Unmerged Branches

By default `git-purge` will not delete unmerged local branches. To delete them anyway, use the `-f` option:

```
git-purge -f
```
