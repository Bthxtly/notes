#set page(fill: rgb("f2e5bc"))

= The derivative of $f(x)=a^x$
We use the definition of derivatives here
$
  f'(x) & = lim_(h->0) (f(x+h)-f(x)) / h            \
        & = lim_(h->0) (a^(x+h)-a^x) / h            \
        & = lim_(h->0) (a^x (a^h - 1)) / h          \
        & = a^x dot lim_(h->0) (a^h - 1) / h        \
        & = a^x dot lim_(h->0) (e^(h ln a) - 1) / h \ $

Then, we apply L'Hôpital's rule to the second part
$
  lim_(h->0) (e^(h ln a) - 1) / h & = lim_(h->0) (e^(h ln a) - 1)' / h'    \
                                  & = lim_(h->0) (ln a dot e^(h ln a)) / 1 \
                                  & = lim_(h->0) (ln a dot a^h)            \
                                  & = ln a $

So
$ (a^x)' = a^x dot ln a $

= The derivative of $f(x)=log_a x$
Since this function is the inverse function of $g(x)=a^x$, that is,
$f^(-1)(x)=a^x$
$
  f'(x) & = 1 / ((f^(-1))'(f(x)))      \
        & = 1 / ((f^(-1))'(log_a x))   \
        & = 1 / (a^(log_a x) dot ln a) \
        & = 1 / (x dot ln a) $

So $ (log_a x)' = 1 / (x dot ln a) $

= The derivative of $f(x)=arcsin x$
$
  (arcsin x)' & = 1 / (cos(arcsin x))                 \
              & = 1 / (sqrt(1 - sin^2(arcsin x)))     \
              & = 1 / sqrt(1 - x^2), #h(10pt) |x| < 1 $

= The derivative of $f(x)=op("arcsec") x$
$
  (op("arcsec") x)' & = 1 / (sec(op("arcsec")x)tan(op("arcsec")x)) \
                    & = 1 / (|x|sqrt(sec(op("arcsec")x)^2 - 1))    \
                    & = 1 / (|x|sqrt(x^2 - 1)), #h(10pt) |x| > 1 $

= The derivative of $f(x)=arctan x$
$
  (arcsin x)' & = 1 / (sec^2(arctan x))     \
              & = 1 / (tan^2(arctan x) + 1) \
              & = 1 / (1 + x^2) $

= The antiderivative of $f(x)=sin^2 x$
$ integral sin^2 x & = integral (1 - cos 2x) / 2 dif x                    \
                   & = 1 / 2 integral dif x - 1 / 2 integral cos 2x dif x \
                   & = x / 2 - (sin 2x) / 4 +C $

= The antiderivative of $f(x)=cos^2 x$
$ integral cos^2 x & = integral (cos 2x + 1) / 2 dif x                    \
                   & = 1 / 2 integral dif x + 1 / 2 integral cos 2x dif x \
                   & = x / 2 + (sin 2x) / 4 +C $
