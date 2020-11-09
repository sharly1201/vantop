#第一步---------------------------
#!/bin/sh

git filter-branch -f --env-filter '

OLD_EMAILs=("liaohongdong" "liaohongdong")
OLD_Names=("hongdong.liao@vantopgroup.com" "hongdong.liao@vantopgroup.com")

CORRECT_NAME="sharly"
CORRECT_EMAIL="sharly1201@gmail.com"

for old_Email in ${OLD_EMAILs[*]}; do
    if [ "$GIT_COMMITTER_EMAIL" = "$old_Email" ]; then
        echo 替换COMMITTER Email "$GIT_AUTHOR_NAME" 为 "$CORRECT_NAME" "$CORRECT_EMAIL"
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$old_Email" ]; then
        echo 替换AUTHOR Email "$GIT_AUTHOR_NAME" 为 "$CORRECT_NAME" "$CORRECT_EMAIL"
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
done

for name in ${OLD_Names[*]}; do
    if [ "$GIT_AUTHOR_NAME" = ${name} ]; then
        echo 替换Name "$GIT_AUTHOR_NAME" 为 "$CORRECT_NAME" "$CORRECT_EMAIL"
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
done

' --tag-name-filter cat -- --branches --tags

#第二步-------------------------------
git push --force --tags origin 'refs/heads/*'