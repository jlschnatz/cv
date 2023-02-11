## Personal CV
### Attribution
- made via the package `pagedown`
- forked from Jake Thompson [wjakethompson](https://github.com/wjakethompson/cv)

### Structure

```
.
├── R
│   └── skill_chart.R
├── README.md
├── bib
│   ├── conf.bib
│   ├── pubs.bib
│   ├── rpkg.bib
│   ├── tech.bib
│   └── work.bib
├── css
│   └── styles.css
├── cv.Rproj
├── data
│   └── cv-data.xlsx
├── img
│   ├── language_skill.jpeg
│   └── potrait_image.jpeg
├── index.Rmd
├── index.html
├── index.pdf
├── lib
│   ├── custom_printing.R
│   ├── parse-citations.R
│   └── str_wrap_html.R
└── render_rmd.sh
```

- R: skill_chart.R build plot of language and programming skills
- css: css style sheet
- data: all the personal data to dynamically build the cv
- img: images of skill plot and potrait photo
- lib: costum functions used in index.Rmd
- index.Rmd: RMarkdown document building the cv which is rendered to html/pdf via the render_rmd.sh script

### How to use

- add own scientific contributions to the .bib-files 
- insert own potrait photo into the img-folder named potrait_image.jpeg
- update excel sheets of cv_data.xlsx
- run render_rmd.sh bash script via the terminal

``` 
bash render_rmd.sh
./render_rmd.sh # after making the script executable
```


