# Specification

Kampu law is a project aim to make the law of Cambodia more accessible to everyone.

## Goal

The project goal is to:
- Make all legislation of Cambodia accessible via a website or app.
- Make it easy to access the structured data of Cambodia legislation (in JSON, SQL and/or more...).
- New bill can be presented as a "Pull Request".
  - When the bill is accepted and become a law, the PR is merged.
  - When the bill is rejected, the PR is rejected.
- Make it possible to discuss about a legislation or article (imagine a forum or subreddit).

## Technical detail

The project consists of multiple parts which can be described below:

1. A tool that can download all legislation pdf from: http://national-assembly.org.kh/group-law/53
2. A tool that can extract information from the pdf:
  - One of the proposed solution is to:
    - Convert the pdf to images.
    - Use an OCR tool to extract sentences from the images.
    - Organized the sentences to a structured data (manual or automatic base on reality).
  - Another is to extract the sentences from the pdf directly, but remember the khmer unicode in pdf are mostly broken.
3. A tool that convert the structured data to presentable data (Markdown and/or HTML).
4. A web application that can be hosted to make the presentable data accessible via a domain.


### Future features
- Integrate a forum-like feature into the web application, where one can discuss about a legislation or article.
- Implement a mobile application.

## Inspiration
There's a similar project but with German Law: https://github.com/bundestag/gesetze (Use google translate if you want to read it).

Though the features and the implementation are slightly different, the
end goal is the same, to make the law more accessible.

## Special thanks to
`Y3VsdHVyZSBpcyBkb3duc3RyZWFtIGZyb20gbGF3`