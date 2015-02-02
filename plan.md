Lesson plans
===

Guidelines
---
Each lesson must be stored in its own separate repository with a 
gh-pages branch. The lesson template repository can be found here:
https://github.com/swcarpentry/lesson-template

Lesson
---
See: https://github.com/swcarpentry/lesson-template/blob/gh-pages/LAYOUT.md

A lesson has:
 - prerequisites
 - a series of topics (10-15 minute lessons followed by exercises)
 - Motivation slides
 - A reference guide
 - A page of general discussions
 - An instructor guide

Schedule
---
 4 x 90 minute blocks
 gives time for 24 x 15 minute topics
 or 6 lessons with 4 topics each.
 or 8 lessons with 3 topics each.


Topic: Introduction to RStudio and Reproducible workflows
---
 - Explain and show the various panes in R.
 - Principles for reproducibility (Separation of style and content).
    -- See: http://resbaz.github.io/2014-r-materials/lessons/20-projects/

 - Introduce Projects in R
   - install `packrat`
      - explain libraries
   - Create a new project for the bootcamp
   - Show packrat/ folder
   - explain `packrat::bundle()` 
      -- we'll use this at the end to bundle up the whole course.
   - install `ProjectTemplate`, initialise project with both.
 - Explain what just happened
   - Open README
   - explain folders
   - show `packrat::status()`
   - modify .gitignore to ignore data/ and munge/ directories
 - Upload gapminder data set
 - Run `load.project`, explain what happened
 - Show config
  - add `packrat` to libraries
  - set load_libraries to TRUE
 - Run `load.project`
  - Install missing libraries
  - run `packrat::status()`
 - Show git integration.


Topic: Introduction to R
---
 - http://resbaz.github.io/2014-r-materials/lessons/01-intro_r/r-basics.html
 - merged with http://swcarpentry.github.io/r-novice-inflammation/01-starting-with-data.html
 - Reading tabular data

Topic: Seeking help
---
 - Show helpfile for read.table
 - http://resbaz.github.io/2014-r-materials/lessons/01-intro_r/seeking-help.html
 - Stackoverflow
 - CRAN Task views

Topic: Data Structures in R
---
 - http://resbaz.github.io/2014-r-materials/lessons/01-intro_r/data-structures.html
 - Needs exercises

Topic: Subsetting Data
---
 - http://resbaz.github.io/2014-r-materials/lessons/01-intro_r/subsetting.html

Topic: Vectorisation
---
 - http://resbaz.github.io/2014-r-materials/lessons/01-intro_r/vectorisation.html

Topic: Functions:
---
 - http://swcarpentry.github.io/r-novice-inflammation/02-func-R.html
 - merge with http://resbaz.github.io/2014-r-materials/lessons/10-functions/




