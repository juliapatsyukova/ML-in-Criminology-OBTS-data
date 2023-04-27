# ML-in-Criminology-OBTS-data

The Offender Based Transaction Statistics (OBTS) series was designed by the Bureau of Justice Statistics to collect information tracking adult offenders from the point of entry into the criminal justice system (typically by arrest), through final disposition, regardless of whether the offender is convicted or acquitted. Collected by individual states from existing data, the datasets include all cases that reached disposition during the calendar year. Using the individual adult offender as the unit for analysis, selected information is provided about the offender and his or her arrest, prosecution, and court disposition. Examples of variables included are arrest and level of arrest charge, date of arrest, charge filed by the prosecutor, prosecutor or grand jury disposition, type of counsel, type of trial, court disposition, sentence type, and minimum and maximum sentence length. Dates of disposition of each stage of the process allow for tracking of time spent at each stage.

Source: [Offender Based Transaction Statistics (OBTS) Series] (https://www.icpsr.umich.edu/web/NACJD/series/78#:~:text=Offender%20Based%20Transaction%20Statistics%20(OBTS)%20studies%20are%20designed%20to%20collect,offender%20is%20convicted%20or%20acquitted).

This site was built using [GitHub Pages](https://pages.github.com/).

## Comments on EDA and Data Preprocessing

Our objective is to track cases and identify institutional trajectories, i.e., movements between elements of the criminal justice system, such as police, prosecution, pre-trial hearings, and court hearings. For this purpose, we performed some data relabelling.

Firstly, we marked cases that were not transferred further (from police to prosecution, from prosecution and pre-trial hearings to court hearings) as "case closed/on hold". We based this relabelling on two variables: V17 (police disposition) and V27 (prosecution disposition).

In the police disposition column (V17), 96.6% of cases are marked as "not disposed by police". Others are either "Transfer to other law enforcement agency" or "Released". Upon examining the data points after subsetting based on this column, we concluded that "not disposed by police" means that the case was handed over to the prosecutor. Therefore, we can consider this attribute (V17) as indicating whether the cases were disposed or not disposed (i.e., transferred or not transferred further). To put it simply, "case was not disposed" = "case was transferred further" and "case disposed" = "case was not transferred further". It is essential to note that the information in columns V18-V21 refers not to the date of transfer or how much time has passed between arrest and transfer but to the date of police disposition (not transfer) and how much time has passed between arrest and this disposition (not transfer). The information in columns V22-V23 refers to both cases that were disposed and those that were not disposed by the police.

The term "disposition by the police" is somewhat vague. It usually refers to how a criminal case or incident was handled by law enforcement and whether it was pursued further by the prosecutor's office or the court system. Typically, "disposed by police" means that the police have closed the case without any further legal action due to different reasons (not enough evidence, the case can be resolved through other means, such as a warning). It is crucial to note that cases disposed by police are not necessarily "closed" in the sense that they are fully resolved. If new evidence or information becomes available, or if the case is reopened later, it may still be possible for charges to be filed or legal action to be taken. There is no clear distinction in categories if cases disposed by police are on hold or closed. We must keep this in mind when examining the data in V22-V23 as the information there represents both cases that were disposed of (not transferred further) and those that were not disposed of (transferred further).

We marked every data point equal to "not disposed by police" as "case closed/on hold" (within this particular institutional trajectory) in every other column starting in the Prosecution/Grand Jury segment.

We applied the same logic to "prosecution disposition". There attributes V28-V31 refer not to the date of transfer or how much time has passed between arrest and transfer but to the date of prosecution disposition (not transfer) and how much time has passed between arrest and this disposition (not transfer). The information in columns V32-V33 refers to both cases that were disposed and those that were not disposed by the prosecution. We marked every data point equal to "not disposed by prosecution" as "case closed/on hold" (within this particular institutional trajectory) in every other column starting in the Court disposition segment.


This relabelling allowed us to differentiate between natural missing values, which indicate that there was no information about some attribute for an unknown reason, and fictional missing values, which indicate that the reason we do not have any information about some attributes is because the case was disposed (not transferred further). The first missing values are marked as NA, while the second ones look like "case closed/on hold."
