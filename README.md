# Etherpad

Docker configuration for the Etherpad application

## Adding a submodule with a specific tag or commit

If you want to pin your submodule to a specific tag or commit, the process involves two steps:

### Checkout the specific tag or commit

Navigate to the submodule directory and checkout the desired tag or commit:

```
cd etherpad-lite
git checkout <tag_or_commit_sha>
```

Then, go back to your main project directory and commit the changes:

```
cd ..
git commit -am "Update Etherpad submodule to tag/commit xyz"
```
