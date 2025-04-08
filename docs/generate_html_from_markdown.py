import markdown
from mdx_gfm import GithubFlavoredMarkdownExtension
import argparse

parser = argparse.ArgumentParser(
    prog="Html from MD file",
    description="Generate Github style Html from Markdown file",
)

parser.add_argument("filename")
parser.add_argument("-o", "--out")

args = parser.parse_args()

with open(args.filename, "r") as f:
    source = f.read()
    html = markdown.markdown(source, extensions=[GithubFlavoredMarkdownExtension()])

if args.out:
    outfile = args.out
else:
    outfile = args.filename.replace(".md", ".html")

header = """
<!DOCTYPE html>
<head>
  <link rel="stylesheet" href="github_markdown.css">
</head>
"""
with open(outfile, "w") as f:
    f.write(header + html)
