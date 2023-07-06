% Δυαδικά νευρωνικά δίκτυα για τυπωμένα ηλεκτρονικά
% Παναγιώτης Παπανικολάου
% 7 Ιουλίου 2023

---
header-includes:
 - \usepackage{fontawesome5}
 - \usecolortheme{whale}
---

# Εισαγωγή

## Τυπωμένα ηλεκτρονικά \faIcon{print} \faIcon{microchip}
### Κανονική εκτύπωση με ειδικά μελάνια

![](../../../Downloads/membranekeyboard.jpeg)

## Τυπωμένα ηλεκτρονικά \faIcon{print} \faIcon{microchip}
- Αντένες
- Αισθητήρες
- LED
- Transistors
- Μπαταρίες
- Ηλιακά πάνελ

## Τυπωμένα ηλεκτρονικά \faIcon{print} \faIcon{microchip}
- Πολύ φτηνά \faIcon{thumbs-up}
- Πολύ μεγάλη έκταση/κατανάλωση  \faIcon{thumbs-down}

![](../../../Downloads/processcomparison.png){height=70%}

## Ubiquitous computing \faIcon{globe}
### Υπολογιστικά στοιχεία **στα πάντα**.

## Εκτυπωμένo machine learning
- Πολλές εφαρμογές classification
- Δύσκολα υλοποιήσιμο

## Δυαδικά νευρωνικά δίκτυα(ΒΝΝ) 
- Weights/activations $\in \{-1,1\}$
- 1 bit quantization

![](../../../Downloads/bnn.png){ width=70% }

## Δυαδικά νευρωνικά δίκτυα(ΒΝΝ) 
Multiply-accumulate $\to$ XNOR-popcount

- Χαμηλές απαιτήσεις \faIcon{thumbs-up}
- Λιγότερο αξιόπιστα \faIcon{thumbs-down}

## Προηγούμενες εργασίες

- Αναλογικοί νευρώνες  

- Bespoke decision trees, SVMs  

- Bespoke approximate MLPs  

- Stochastic computing  

- Sea of gates  

## Στόχος \faIcon{bullseye}

### Εξέταση ΒΝΝ ως προς την υποστήριξη τυπωμένου ML

### Υλοποίηση framework για αυτόματη δημιουργία τυπωμένου ΒΝΝ από dataset

## Framework
![](xx.pdf){height=90%}

## Datasets

- Cardio \faIcon{heartbeat}

- GasId \faIcon{smog}

- Pendigits \faIcon{edit}

- HAR \faIcon{walking}

- Redwine \faIcon{wine-glass}

- Whitewine \faIcon{wine-glass}

## Models

| Dataset     |    full precision |    BNN |    TNN |  MLPC   |
|:------------|------------------:|-------:|-------:|:--------|
| cardio      |                92 |     88 |     90 | 88      |
| gasId       |                90 |     81 |     88 | -       |
| Har         |                74 |     51 |     52 | -       |
| pendigits   |                99 |     87 |     92 | 94      |
| redwine     |                60 |     54 |     58 | 56      |
| whitewine   |                57 |     51 |     50 | 54      |

## Παράλληλη υλοποίηση
1. Χωρισμένα θετικά/αρνητικά στοιχεία
![](tikz2/bnnpar.pdf)

## Παράλληλη υλοποίηση
2. Ενιαίο άθροισμα
![](tikz2/bnnparsign.pdf)
