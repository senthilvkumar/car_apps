Prediction of mpg for mtcars dataset
========================================================
author: Senthil Kumar V.
date: Feb 22nd 2015
- https://senthilvkumar.shinyapps.io/cars_app/
- mtcars has 10 features for mpg
- Minimal linear model: mpg ~ wt
- Optimal linear model: Trim down full model to get 
the highest adjusted R squared value

Minimal model & Its prediction
========================================================


```r
data(mtcars)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am,levels=c(0,1))

mod_min <- lm(mpg ~ wt, data = mtcars)
summary(mod_min)

res_min <- predict(mod_min,data.frame(wt=3.22),
                   interval="confidence")
```

Optimal model & Its prediction
========================================================


```r
mod_full <- lm(mpg ~ ., data = mtcars)
mod_opt <- step(mod_full, direction = "both")
summary(mod_opt)
res_opt <- predict(mod_opt,
            data.frame(cyl=factor(4,levels=c(4,6,8)),
            hp=147,wt=3.22,
            am=factor(1,levels=c(0,1))),
            interval="confidence")
```

Sample results from the two models
========================================================


```r
round(res_min,2)
```

```
    fit   lwr   upr
1 20.08 18.98 21.18
```

```r
round(res_opt,2)
```

```
    fit   lwr   upr
1 22.76 20.07 25.45
```

Stat. significane of the Optimal model
========================================================


```r
anova(mod_min,mod_opt)
```

```
Analysis of Variance Table

Model 1: mpg ~ wt
Model 2: mpg ~ cyl + hp + wt + am
  Res.Df    RSS Df Sum of Sq      F   Pr(>F)   
1     30 278.32                                
2     26 151.03  4     127.3 5.4787 0.002456 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
