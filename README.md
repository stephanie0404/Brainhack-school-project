# Brainhack-school-project

---
type: "project" # DON'T TOUCH THIS ! :)
date: "2023-06-10" # Date your first upload your project.
# Title of your project (we like creative title)
title: "Predicting feedback perception in an online language learning task using EEG and machine learning"

# List the names of the collaborators within the [ ]. If alone, simple put your name within []
names: [Stephanie Fu, <a href="https://dylanscottlow.github.io/" target="blank">Dylan Scott Low</a>]

# Your project GitHub repository URL
github_repo: https://github.com/stephanie0404/Brainhack-school-project

# If you are working on a project that has website, indicate the full url including "https://" below or leave it empty.
website:

# List +- 4 keywords that best describe your project within []. Note that the project summary also involves a number of key words. Those are listed on top of the [github repository](https://github.com/PSY6983-2021/project_template), click `manage topics`.
# Please only lowercase letters
tags: [machine learning, duolingo, eeg, neurolinguistics, brainhack]

# Summarize your project in < ~75 words. This description will appear at the top of your page and on the list page with other projects..

summary: "In this project, we attempt to apply machine learning methods to the analysis of EEG data recorded while a participant completes language learning tasks on the popular online platform Duolingo. Specifically, we seek to determine if features in the EEG signal can serve to predict whether the participant has gotten a task right or wrong, at the moment when the participant receives feedback on their performance in the task. A k-nearest neighbours classifier achieves a 98% accuracy rate when predicting whether the participant got the answer right or wrong based on the EEG voltages from 8 electrodes."

# If you want to add a cover image (listpage and image in the right), add it to your directory and indicate the name
# below with the extension.
image: "pictures/Cz_sample_filtered.jpg"
---
<!-- This is an html comment and this won't appear in the rendered page. You are now editing the "content" area, the core of your description. Everything that you can do in markdown is allowed below. We added a couple of comments to guide your through documenting your progress. -->

## Project definition

### Background



### Tools

The project relied on the following tools:
 * R programming language (packages: tidyverse, ggplot2, readr)
 * Python programming language (libraries: pandas, scikit-learn, MNE Python)
 * Git/GitHub
 * Bash terminal

### Data

The data we used comes from a project titled <a href="" target="blank"><b>Data in Brief: Multimodal Duolingo Bio-Signal Dataset</b></a> by Notaro & Diamond (2018; click <a href="https://doi.org/10.1016/j.dib.2018.11.044" target="blank">here</a> for the corresponding article). As suggested by the title, this is a multimodal dataset. Four kinds of data were recorded: (1) EEG via a low-cost OpenBCI electrode cap, (2) Gazepoint-GP3 eye-tracking, (3) Autohotkey cursor movements and clicks, and (4) Autohotkey screen content data (screenshots taken when a click occurs). Data was recorded while participants (n = 22) were completing beginner German language lessons on the desktop version of Duolingo. Participants were either English native speakers or fluent in English.

Our project focused on (1) and (4), that is, the EEG and screenshot data. In particular, we analyse only the data of participant 1.

### Deliverables

At the end of this project, these files will be available:
 * A .txt file (data_labels_raw.txt) containing manually selected filenames (timestamps) of the screenshots corresponding to when the participant receives feedback on their Duolingo performance.
 * An R script (data_labels.r) for cleaning the raw filenames list (data_labels_raw.txt) into machine-readable format (data_labels_clean.txt).
 * A Jupyter notebook containing Python script for preprocessing the OpenBCI EEG data (high and low pass filtering).
 * An R script (data_labelling.r) for combining the filtered EEG data with the data_labels_clean.txt file.
 * A Juyter notebook containing Python script for running machine learning classifiers (e.g., MLP, kNN, random forest) on the labelled EEG data.

## Results

### Progress overview

At first, we thought preprocessing the data would be a simple matter. However, we quickly realised that the OpenBCI EEG format (formatted as a .txt file) is not a standard raw EEG format that could be easily imported in MNE Python. Solving this problem caused us some delays, but we eventually came up with a custom script to import the data in MNE Python. Another peculiarity we observed was that the OpenBCI set-up only consisted of 8 electrodes, as oppposed to the standard 32 channels.

Also, we initially intended to analyse the data of more than one participant in the data set, but realised that even data from one participant (recorded over about 58 minutes) was very large, and likely more than sufficient to train an ML model. The large size also delayed our work due to the long wait times when processing the data, sometimes leading to crashes which force us to start the process over again until it reaches fruition (an unfortunate symptom of running such analyses on weak personal machines).

### Tools I learned during this project

 * **MNE Python** We learnt how to filter raw EEG data during the preprocessing stage, as well as how to import EEG data even if not in a recognised standard raw format.
 * **Github workflow-** We got well-acquainted with using Git via the Bash terminal, and also some related tools like Datalad and Git LFS (Large File System).
 * **Bash Terminal** We gained a good understanding of how to use the Bast erminal in lieu of File Explorer (Windows)/Finder (Mac).

### Results

#### Figures and Plots

![Filtered Cz Channel during 1 second epoch](https://raw.githubusercontent.com/stephanie0404/Brainhack-school-project/main/pictures/Cz_sample_filtered.jpg)

You are currently reading the report template! I will let you judge whether it is useful or not. If you think there is something that could be improved, please do not hesitate to open an issue [here](https://github.com/PSY6983-2021/project_template/issues/) and let us know.

#### Discussion

##### Other projects
Here are other good examples of repositories:
- [Learning to manipulate biosignals with python](https://github.com/mtl-brainhack-school-2019/franclespinas-biosignals) by François Lespinasse
- [Run multivariate anaylysis to relate behavioral and electropyhysiological data](https://github.com/mtl-brainhack-school-2019/PLS_PV_Behaviour)
- [PET pipeline automation and structural MRI exploration](https://github.com/mtl-brainhack-school-2019/rwickens-sMRI-PET) by Rebekah Wickens
- [Working with PSG [EEG] data from Parkinson's patients](https://github.com/mtl-brainhack-school-2019/Soraya-sleep-data-in-PD-patients) by Cryomatrix
- [Exploring Brain Functional Activation in Adolescents Who Attempted Suicide](https://github.com/mtl-brainhack-school-2019/Anthony-Gifuni-repo) by Anthony Gifuni

#### Deliverable 3: Instructions

 To be made available soon.

## Conclusion and acknowledgement

The BHS team hope you will find this template helpful in documenting your project. Developping this template was a group effort, and benefitted from the feedback and ideas of all BHS students over the years.

You can also make submit your project to neurolibre https://neurolibre.org/. It is a preprint server for interactive data analyses. It is tailored for publishing interactive neuroscience notebooks that can seamlessly integrate data, text, code and figures.The submission instructions can be found here https://docs.neurolibre.org/en/latest/index.html and the jupyter book docs there https://jupyterbook.org/intro.html.
