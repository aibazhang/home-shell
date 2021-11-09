
cd ~/projects/zhdt-wiki
# Copy shell config
cp ~/.config/fish/config.fish .

# Add Poster of Routine
routine_name=(
    "Guitar 11"
    "English 13"
    "Coding 14"
    "Reading 16"
)

# Issue
for i in "${routine_name[@]}"; do
    rn=(${i[@]})
    github_poster issue --issue_number ${rn[1]} --repo_name $NOTEBOOK_REPO_NAME --github_token $NOTEBOOK_GITHUB_TOKEN --me ${rn[0]} --special-color2 "#33C6A4"
    # python ~/projects/GithubPoster/cli.py --type issue --github_issue_number ${rn[1]} --github_repo_name $NOTEBOOK_REPO_NAME --github_token $NOTEBOOK_GITHUB_TOKEN --me ${rn[0]} --special-color2 "#33C6A4"
    cp ./OUT_FOLDER/issue.svg "private/日記/${rn[0]}.svg"
done
rm -rf ./OUT_FOLDER

# Strava
# python ~/projects/GithubPoster/cli.py --type strava --strava_client_id $STRAVE_CLIENT_ID  --strava_client_secret $STRAVA_CLIENT_SECRET  --strava_refresh_token $STRAVE_REFRESH_TOKEN --year 2021 --me "JC"

# Add Diary
cd "private/日記/"
bash create_new_diary.sh
cd ~/projects/zhdt-wiki

# Git
git checkout master
git pull origin master
git add -A
git commit -m "`date +%Y%m%d%H%M`"
git push origin master