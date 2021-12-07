# Speaker_Identification
Term Project for DSP Course, IIT KGP

This project develops a speaker identification system using frequency components of voice signals.

We use a k-nearest neighbour classifer for speaker classification.
Two feature vector(FV) encodings are analysed for this purpose:
1. Pass through custom uniform/non uniformly spaced filter banks, and use energies of outputs as FVs.
2. Use MFCC coefficients and pitch as FVs

We use a CNN to detect if the correct numerical code has been spoken.

MFCC Coefficients are used as FVs for the CNN.

Joint Contributors: Ayan Chakraborty, A Jaaneshwaran