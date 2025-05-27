# Generate the commit log table
TABLE=$(echo -e "| Date | Message |\n|--------|--------|------|---------|"
git log -n 5 --pretty=format:"| %ad | %s |" --date=short)

# Replace the section between markers in README.md
sed -i '' "/<!-- COMMITS_START -->/,/<!-- COMMITS_END -->/c\\
<!-- COMMITS_START -->\\
$TABLE\\
<!-- COMMITS_END -->" README.md
