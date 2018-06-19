# Google Java Format Pre-Commit Hook

A git pre-commit script that formats java code according to the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html), using the [Google Java Format](https://github.com/google/google-java-format) library.

## Installing

To use this pre-commit script, clone this repo locally, and then link the `pre-commit.sh` script from this repo as the `.git/hooks/pre-commit` script in your java project:
```bash
cd ~/my-libraries
git clone https://github.com/justinludwig/gjfpc-hook.git
cd ~/my-projects/some-java-project
ln -s ~/my-libraries/gjfpc-hook/pre-commit.sh .git/hooks/pre-commit
```

## Details

The script automatically downloads the google-java-format jar from the [Google Java Format](https://github.com/google/google-java-format) project to your `~/.local/share/java` directory on first run. It then calls this jar to format the entire contents of each staged file with a `.java` extension when git calls it for pre-commit processing.

If formatting fails, the commit will be aborted. If formatting succeeds, the file will be re-staged (to include any formatting changes in the commit). To avoid committing un-staged hunks, you must [skip](#skipping) the script for the commit.

## Formatting

To run the google-java-format jar independently of the pre-commit hook, run the `format.sh` script:
```bash
~/my-libraries/gjfpc-hook/format.sh --help
```

You can also link the formatting script to a local bin directory, either in your home folder:
```bash
ln -s ~/my-libraries/gjfpc-hook/format.sh ~/.local/bin/google-java-format
```

Or another bin directory on your PATH:
```bash
sudo ln -s ~/my-libraries/gjfpc-hook/format.sh /local/usr/bin/google-java-format
```

And then run the script simply as `google-java-format`:
```bash
google-java-format --help
```

## Skipping

To skip formatting a single commit, use the `--no-verify` flag (`-n` for short):
```bash
git commit --no-verify
```

To skip a series of commits -- like when rebasing or merging -- set the `NO_VERIFY` environment variable in your shell to be not empty, make the commits, and then set `NO_VERIFY` back to empty:
```bash
export NO_VERIFY=1
git rebase -i master
export NO_VERIFY=
```
