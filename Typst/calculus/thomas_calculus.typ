#import "@preview/cetz:0.3.4"

// https://stackoverflow.com/questions/78272599/show-current-heading-number-and-body-in-page-header
#set page(
  // header: context {
  //   let selector = selector(heading).before(here())
  //   let level = counter(selector)
  //   let headings = query(selector)
  //
  //   if headings.len() == 0 {
  //     return
  //   }
  //
  //   let heading = headings.last()
  //
  //   level.display(heading.numbering)
  //   h(1em)
  //   heading.body
  // },
  fill: rgb("f2e5bc"),
)

#set heading(numbering: "1.")

#show heading.where(level: 2): it => text(
  size: 11pt,
  weight: "bold",
  style: "italic",
  line(length: 100%) + underline(it),
)

#show "Proof": name => [
  #text("Proof", weight: "bold", font: "FreeSans")
  #h(10pt)
]

#align(
  center,
  text(size: 17pt, font: "Nimbus Roman")[*Thomas' Calculus*],
)

= Preliminaries
This chapter is too easy, but still worth a figure drawn with `CeTZ`:
// trigonometric functions
#grid(
  columns: 2,
  gutter: 10pt,
  cetz.canvas({
    import cetz.draw: *
    set-style(stroke: blue)
    line((0, 0), (4, 0), name: "adj")
    line((4, 0), (4, 3), name: "opp")
    line((4, 3), (0, 0), name: "hyp")
    content("adj", [adjacent], padding: .1, anchor: "north")
    content("opp", [opposite], padding: .1, anchor: "west")
    content("hyp", [hypotenuse], padding: .2, anchor: "east")

    line((3.7, 0), (3.7, 0.3), (4, 0.3), stroke: black + .4pt)
    arc(
      (1, 0),
      start: 0deg,
      stop: 19deg,
      radius: 2,
      stroke: red,
      name: "arc",
      mark: (end: "straight", stroke: red + .4pt),
    )
    content(
      ("arc.start", 50%, "arc.end"),
      [$theta$],
      padding: .2,
      anchor: "west",
    )
  }), grid(
    columns: 2,
    gutter: 10pt,
    $
      bold("sine: ")    & sin theta = "opp" / "hyp" \
      bold("cosine: ")  & cos theta = "adj" / "hyp" \
      bold("tangent: ") & sin theta = "opp" / "adj" $, $
      bold("cosecant: ")  & csc theta = "hyp" / "opp" \
      bold("secant: ")    & sec theta = "hyp" / "adj" \
      bold("cotangent: ") & cot theta = "adj" / "opp" $,
  ),
)

= Limits and Continuity

== Limits of Function Values
Let $f(x)$ be defined on an open interval about $x_0$, _except possibly at $x_0$
itself_. If $f(x)$ gets arbitrarily close to $L$ (as close to $L$ as we like)
for all $x$ sufficiently close to $x_0$, we say that $f$ approaches the *limit*
$L$ as x approaches $x_0$, and we write $ lim_(x arrow x_0)f(x) = L $

== Definition of Limit
Let $f(x)$ be defined on an open interval about $c$, except possibly at $c$
itself. We say that the *limit of $f(x)$ as $x$ approaches $c$ is the number
$L$*, and write
$ lim_(x arrow c)f(x) = L, $
if, for every number $epsilon$ > 0,
there exist a corresponding number $delta$ > 0 such that for all $x$,
$ 0 < |x - c| < delta #h(20pt) => #h(20pt) |f(x) - L| < epsilon. $

== Definition of Limits involving Infinity
1. We say that $f(x)$ has the *limit $L$ as $x$ approaches Infinity* and write
$ lim_(x arrow infinity)f(x) = L $
if, for every number $epsilon$ > 0, there exists a corresponding number $M$
such that for all $x$,
$ x > M #h(20pt) => #h(20pt) |f(x) - L| < epsilon. $
2. We say that $f(x)$ has the *limit L as $x$ approaches minus infinity* and write
$ lim_(x arrow minus infinity)f(x) = L $
if, for every number $epsilon$ > 0, there exists a corresponding number $N$
such that for all $x$,
$ x < N #h(20pt) => #h(20pt) |f(x) - L| < epsilon. $

== Limits Involving $(sin theta)$/$theta$
$ lim_(x arrow 0)(sin theta) / theta = 1 #h(20pt) (theta "in radians") $
Proof Consider @lim_sin_theta_div_theta. Notice that
$ "area" triangle "OAP" < "area" "sector" "OAP" < "area" triangle "OAT". $
Then express these areas in terms of $theta$, and thus,
$ 1 / 2 sin theta < 1 / 2 theta < 1 / 2 tan theta. $
So
$ 1 > (sin theta) / theta > cos theta. $
Since $lim_(theta arrow 0^plus)cos theta = 1$, the Sandwich Theorem gives
$ lim_(theta arrow 0^plus)(sin theta) / theta = 1. $
Because $(sin theta) / theta$ is an even function, so
$ lim_(theta arrow 0^plus)(sin theta) / theta =
    lim_(theta arrow 0^minus)(sin theta) / theta = 1. $
So $lim_(x arrow 0)(sin theta) / theta = 1$
#figure(
  caption: [
    The proof of $display(lim_(theta arrow 0)(sin theta) / theta = 1)$
  ],
  cetz.canvas({
    import cetz.draw: *
    set-style(stroke: 0.4pt)
    scale(4)
    // x, y axes
    line(
      (-0.1, 0),
      (1.2, 0),
      mark: (end: "straight", length: 0.05, width: 0.05),
      name: "x_axis",
    )
    line(
      (0, -0.1),
      (0, 1.2),
      mark: (end: "straight", length: 0.05, width: 0.05),
      name: "y_axis",
    )
    // arcs and the slope line
    arc((1, 0), start: 0deg, stop: 90deg)
    let degree = 45deg
    let len = 0.707
    let corner_len = 0.05
    let arc_len = 0.2
    line((0, 0), (1, 1), name: "slope")
    arc((arc_len, 0), start: 0deg, stop: degree, radius: arc_len, name: "arc")
    // lines
    line((len, len), (1, 0))
    line((0, 0), (len, 0), name: "cos", stroke: red + 1.2pt)
    line((len, 0), (len, len), name: "sin", stroke: blue + 1.2pt)
    line((1, 0), (1, 1), name: "tan", stroke: yellow + 1.2pt)
    line((len - corner_len, 0), (rel: (0, corner_len)), (rel: (corner_len, 0)))
    line((1 + corner_len, 0), (rel: (0, corner_len)), (rel: (-corner_len, 0)))
    // contents
    content((0, 0), "O", padding: 0.2, anchor: "north-east", name: "O")
    content((len, len), "P", padding: 0.2, anchor: "south", name: "P")
    content((1, 1), "T", padding: 0.2, anchor: "south", name: "T")
    content((len, 0), "Q", padding: 0.2, anchor: "north", name: "Q")
    content((1, 0), "A(1, 0)", padding: 0.2, anchor: "north", name: "A")
    content((0, 1), "1", padding: 0.2, anchor: "east")
    content("x_axis.end", [$x$], padding: 0.1, anchor: "west")
    content("y_axis.end", [$y$], padding: 0.1, anchor: "south")
    content(("O", 50%, "P"), "1", padding: 0.2, anchor: "south")
    content("sin", [$sin theta$], padding: 0.1, anchor: "east")
    content("cos", [$cos theta$], padding: 0.1, anchor: "south")
    content("tan", [$tan theta$], padding: 0.1, anchor: "west")
    content(
      ("arc.start", 80%, "arc.end"),
      [$theta$],
      padding: 0.2,
      anchor: "west",
    )
  }),
) <lim_sin_theta_div_theta>

== Definition of Continuity
Let $c$ be a real number on the $x$-axis.\
The function is *continuous at $c$* if $ lim_(x arrow c)f(x) = f(c). $
The function is *right-continuous at $c$ (or continuous from the right)* if
$ lim_(x arrow c^plus)f(x) = f(c). $
The function is *left-continuous at $c$ (or continuous from the left)* if
$ lim_(x arrow c^minus)f(x) = f(c). $

== Continuity Test
A function $f(x)$ is continuous at a point $x=c$ if and only if it meets the
following three conditions.
#grid(
  columns: 2,
  gutter: 40pt,
  [
    + $f(c)$ exists
    + $lim_(x arrow c)f(x)$ exists
    + $lim_(x arrow c)f(x)=f(c)$
  ], [
    ($c$ lies in the domain of $f$).\
    ($f$ has a limit as $x arrow c$).\
    (the limit equals the function value).\
  ],
)

== Some kinds of discontinuities
#grid(
  columns: 2,
  gutter: 10pt,
  [
    - removable discontinuity
    - jump discontinuity
    - infinite discontinuity
    - oscillating discontinuity
  ], [
    ($x^2 / x$ at $0$)\
    ($floor.l x floor.r$ at $1$)\
    ($1 / x^2$ at $0$)\
    ($sin 1 / x$ at $0$\)
  ],
)

= Derivatives

== Definition of the derivative of functions
The *derivative* of the function $f(x)$ with respect to the variable $x$ is the
function $f'$ whose value at $x$ is
$ f'(x) = lim_(h arrow 0)(f(x+h) - f(x)) / h $
or, alternatively
$ f'(x) = lim_(z arrow x)(f(z) - f(x)) / (z - x) $
provided the limit exists.

== The derivatives of some trigonometric functions
- $dif / (dif x) (tan x) = sec^2 x$\
- $dif / (dif x) (cot x) = -csc^2 x$\
- $dif / (dif x) (sec x) = sec x tan x$\
- $dif / (dif x) (csc x) = -csc x cot x$,

== The Chain Rule
If $f(u)$ is differentiable at the point $u=g(x)$ and $g(x)$ is differentiable
at $x$, then the composite function $(f circle.stroked.small g)(x) = f(g(x))$ is
differentiable at $x$, and
$ (f circle.small g)'(x) = f'(g(x)) dot g'(x). $
In Leibniz's notation, if $y=f(u)$ and $u = g(x)$, then
$ (dif y) / (dif x) = (dif y) / (dif u) dot (dif u) / (dif x), $
where $(dif y) / (dif u)$ is evaluated at $u = g(x)$.

== Implicit Differentiation
1. #[Differentiate both sides of the equation with respect to $x$, treating $y$
  as a differentiable function of $x$.]
2. #[
    Collect the terms with $(dif y) / (dif x)$ on one side of the equation and
    solve for $(dif y) / (dif x)$
  ]

== The Number $e$ as a Limit
The number $e$ can be calculated as the limit
$ e = lim_(x->0)(1+x)^(1 / x) $

== The Derivative Rule for Inverses
If $f$ has an interval $I$ as domain and $f'(x)$ exists and is never zero
on $I$, the $f^(-1)$ is differentiable at every point in its domain. The value of
$(f^(-1))'$ at a point $b$ in the domain of $f^(-1)$ is the reciprocal of the
value of $f'$ at the point $a=f^(-1)(b)$:
$ (f^(-1))'(b) = 1 / (f'(f^(-1)(b))) $
or
$ lr((dif f^(-1)) / (dif x)|)_(x=b) = display(1 / display(lr((dif f) / (dif x)|)))_(x=f^(-1)(b)) $

== Derivatives of the inverse trigonometric functions
$ dif(sin^(-1)u) / (dif x) = 1 / sqrt(1-u^2) (dif u) / (dif x), #h(10pt) |u| < 1 $
$ dif(cos^(-1)u) / (dif x) = - 1 / sqrt(1-u^2) (dif u) / (dif x), #h(10pt) |u| < 1 $
$ dif(sec^(-1)u) / (dif x) = 1 / (|u|sqrt(u^2-1)) (dif u) / (dif x), #h(10pt) |u| > 1 $
$ dif(csc^(-1)u) / (dif x) = - 1 / (|u|sqrt(u^2-1)) (dif u) / (dif x), #h(10pt) |u| > 1 $
$ dif(tan^(-1)u) / (dif x) = 1 / (1+u^2) (dif u) / (dif x) $
$ dif(cot^(-1)u) / (dif x) = - 1 / (1+u^2) (dif u) / (dif x) $

= Applications of Derivatives

== Definition of Critical Point
An interior point of the domain of a function $f$ where $f'$ is zero or
undefined is a *critical point* of $f$.

== The Extreme Value Theorem
If $f$ is continuous on a closed interval $[a, b]$, then $f$ attains both an
absolute maximum value $M$ and an absolute minimum value $m$ in $[a, b]$. That
is, there are numbers $x_1$ and $x_2$ in $[a, b]$ with $f(x_1)=m$, $f(x_2)=M$,
and $m <= f(x) <= M$ for every other $x$ in $[a, b]$.

== Rolle's Theorem
Suppose that $y = f(x)$ is continuous at every point of the closed interval
$[a, b]$ and differentiable at every point of its interior $(a, b)$. If
$ f(a) = f(b), $
then there is at least one number $c$ in $(a, b)$ at which
$ f'(c) = 0. $
Proof
Being continuous, $f$ assumes absolute maximum and minimum values on $[a, b]$.
These can occur only
+ at interior points where $f'$ is zero,
+ at interior points where $f'$ doesn't exist,
+ at the endpoints of the function's domain, in this case $a$ and $b$.
The rest proof is easy.

== The Mean Value Theorem
Suppose $y = f(x)$ is continuous on a closed interval $[a, b]$ and
differentiable on the interval's interior $(a, b)$. Then there is at least one
point $c$ in $(a, b)$at which
$ (f(b) - f(a)) / (b - a) = f'(c). $
It's easy to proof, simply let $g(x) = f(x) - f(a) - (x-a) / (b-a) (f(b)-f(a))$,
then it comes to Rolle's Theorem since $g(a) = g(b) = 0$.

== Definition of Concavity and The Second Derivative Test for Concavity
The graph of a differentiable function $y=f(x)$ is\
*#numbering("a)", 1) concave up* on an open interval $I$
if $f'$ is increasing on $I$ ($f'' > 0$ on $I$)\
*#numbering("a)", 2) concave down* on an open interval $I$
if $f'$ is decreasing on $I$ ($f'' < 0$ on $I$)\

== Definition of Point of Inflection
A point where the graph of a function has a tangent line and where the
concavity changes is a *point of inflection*. It mostly exists where $y''=0$,
but sometime not, and may occur where $y''$ doesn't exist.

== L'Hôpital's Rule (Stronger Form)
Suppose that $f(a) = g(a) = 0$, that $f$ and $g$ are differentiable on an open
interval $I$ containing $a$, and that $g'(x) != 0$ on $I$ if $x != a$. Then
$ lim_(x -> a)(f(x)) / (g(x)) = lim_(x -> a)(f'(x)) / (g'(x)), $
assuming that the limit on the right side exists.

The proof requires
#link(<cauchys_mean_value_theorem>)[#underline("Cauchy's Theorem")], a Mean
Value Theorem involving two functions instead of one.

Proof
Suppose $x>a$. Then $g'(x) != 0$, and we can apply Cauchy's Mean Value Theorem
to the closed interval from $a$ to $x$, so
$ (f'(c)) / (g'(c)) = (f(x) - f(a)) / (g(x)-g(a)). $
But $f(a) = g(a) = 0$, so
$ (f'(c)) / (g'(c)) = f(x) / g(x). $
As $x$ approaches $a$, $c$ approaches $a$. Therefore,
$ lim_(x->a^+)f(x) / g(x) = lim_(c->a^+)(f'(x)) / (g'(c)) =
    lim_(x->a^+)(f'(x)) / (g'(x)) $
It similar when $x<a$,
$ lim_(x->a)f(x) / g(x) = lim_(x->a)(f'(x)) / (g'(x)) $

The L'Hôpital's Rule applies to the indeterminate form $infinity / infinity$ as
well as to $0 / 0$. Not proved here.

== Cauchy's Mean Value Theorem <cauchys_mean_value_theorem>
Suppose functions $f$ and $g$ are continuous on $[a, b]$ and differentiable
throughout $(a, b)$ and also suppose $g'(x) != 0$ throughout $(a, b)$. Then
there exist a number $c$ in $(a, b)$ at which
$ (f'(c)) / (g'(c)) = (f(b) - f(a)) / (g(b) - g(a)). $

Proof
According to the Mean Value Theorem, $g(a) != g(b)$, otherwise
$ g'(c) = (g(b) - g(a)) / (b-a) = 0. $
Then, we apply the Mean Value Theorem to the function
$ F(x) = f(x) - f(a) - (f(b) - f(a)) / (g(b) - g(b)) [g(x) - g(a)]. $
of which $F(b) = F(a) = 0$, so there exists $c$
$ F'(c) = f'(c) - (f(b) - f(a)) / (g(b)-g(a))[g'(c)] = 0, $
or
$ (f'(c)) / (g'(c)) = (f(b) - f(a)) / (g(b) - g(a)). $

== Newton's Method
// TODO: complete this section
pass.

== Definition of Antiderivative
A function $F$ is an *antiderivative* of $f$ on an interval $I$ if $F'(x) =
    f(x)$ for all $x$ in $I$.

Here are some basic and important antiderivatives.
#table(
  columns: 2,
  inset: 10pt,
  align: center,
  table.header([*Function*], [*General antiderivative*]),
  $x^n$,                              $display((x^(n+1)) / (n+1) + C), n != -1$,
  $sin k x$,                          $display(-1 / k cos k x + C)$,
  $cos k x$,                          $display(1 / k sin k x + C)$,
  $sec^2 k x$,                        $display(1 / k tan k x + C)$,
  $csc^2 k x$,                        $display(-1 / k cot k x + C)$,
  $sec k x tan k x$,                  $display(1 / k sec k x + C)$,
  $csc k x cot k x$,                  $display(-1 / k csc k x + C)$,
  $e^(k x)$,                          $display(1 / k e^(k x) + C)$,
  $display(1 / x)$,                   $display(ln |x| + C), x != 0$,
  $display(1 / (sqrt(1-k^2 x^2)))$,   $display(1 / k sin^(-1) k x + C)$,
  $display(1 / (1+k^2 x^2))$,         $display(1 / k tan^(-1) k x + C)$,
  $display(1 / (x sqrt(k^2 x^2-1)))$, $display(sec^(-1) k x + C), k x > 1$,
  $a^(k x)$,                          $display((1 / (k ln a))a^(k x)+C), a>0, a!=1$,
)

== Definition of Indefinite Integral and Integrand
The set of all antiderivatives of $f$ is the *indefinite integral* of $f$ with
respect to $x$, denoted by
$ integral f(x) dif x. $
The symbol $integral$ is an *integral sign*.The function $f$ is the
*integrand* of the integral, and $x$ is the *variable of integration*.

= Integration

== Formulas for the sums of the squares and cubes
$ sum_(k=1)^n k^2 = (n (n+1) (2n+1)) / 6 $
$ sum_(k=1)^n k^3 = ((n (n+1)) / 2)^2 $

== Riemann Sums
Consider an arbitrary function $f$ defined on a closed interval $[a, b]$. We
subdivide the interval $[a, b]$ into subintervals, not necessarily of equal
widths. To do so, we choose $n-1$ points ${x_1, x_2, x_3, ..., x_(n-1)}$
between $a$ and $b$ and satisfying
$ a < x_1 < x_2 < x_3 < ... < x_(n-1) < b. $
To make the notation consistent, we denote $a$ by $x_0$ and b by $x_n$, so that
$ a = x_0 < x_1 < x_2 < x_3 < ... < x_(n-1) < x_n = b. $
The set
$ P = {x_0, x_1, x_2, x_3, ..., x_(n-1), x_n} $
is called a *partition* of $[a, b]$.

In each subinterval $[x_(k-1), x_k]$ we choose a point $c_k$, and we have
$ S_p = sum_(k=1)^n f(c_k) Delta x_k. $
The $S_p$ is called a *Riemann sum for $f$ on the interval $[a, b]$*. And we
define the *norm* of a partition $P$, written $||P||$, to be the largest of all
the subinterval widths, that is, the maximum of $Delta x_k$.

== The Definite Integral as a Limit of Riemann Sum
Let $f(x)$ be a function defined on a closed interval $[a, b]$. We say that a
number $I$ is the *definite integral of $f$ over $[a, b]$* and that $I$ is the
limit of the Riemann sums $Sigma_(k=1)^n f(c_k) Delta x_k$ is the following
condition is satisfied:

Given any number $epsilon > 0$ there is a corresponding number $delta > 0$ such
that for every partition $P = {x_0, x_1, x_2, ..., x_(n-1), x_n}$ of $[a, b]$
with $||P|| < delta$ and any choice of $c_k$ in $[x_(k-1), x_k]$, we have
$ abs(sum_(k=1)^n f(c_k) Delta x_k -I) < epsilon. $

== Notation of the Definite Integral
The symbol for the number $I$ in the definition of the definite integral is
$ integral_a^b f(x) dif x $
which is read as "the integral from a to b of $f$ of $x$ dee $x$".

== The Existence of Definite Integrals
A continuous function is integrable. That is, if a function $f$ is continuous
on an interval $[a, b]$, the its definite integral over $[a, b]$ exists.

== The Average or Mean Value of a Function
If $f$ is integrable on $[a, b]$, then its *average value on $[a, b]$*, also
called its *mean value*, is
$ "av"(f) = a / (b-a) integral_a^b f(x) dif x. $
, dalle 14 alle 18

== The Mean Value Theorem for Definite Integral
If $f$ is continuous on $[a, b]$, then at some point $c$ in $[a, b]$,
$ f(c) = 1 / (b-a) integral_a^b f(x) dif x. $

Proof
If we divide both sides of the Max-in Inequality
$ "min"f dot (b-a) <= integral_a^b f(x) dif x <= "max"f dot (b-a) $
by $(b-a)$, we obtain
$ "min"f <= 1 / (b-a) integral_a^b f(x) dif x <= "max"f. $
Since $f$ is continuous, $f$ must assume every value between min $f$ and max
$f$. It must therefore assume the value $1 / (b-a) integral_a^b f(x) dif x$ at
some point $c$ in $[a, b]$.

== The Fundamental Theorem of Calculus
If $f(t)$ is an integrable function over a finite interval $I$, then the
integral from any fixed number $a in I$ to another number $x in I$ defines a
new function $F$ whose value at $x$ is
$ F(x) = integral_a^x f(t) dif t. $
Then, at every value of $x$,
$ dif / (dif x) F(x) = dif / (dif x) integral_a^x f(t) dif t = f(x). $
To calculate $display(integral_a^b f(x) dif x)$, we let
$ G(x) = integral_a^x f(t) dif t. $
Thus
$ integral_a^b f(x) dif x & = [G(b) + C] - [G(a) + C]                           \
                          & = integral_a^b f(x) dif x - integral_a^a f(x) dif x \
                          & = integral_a^b f(x) dif x.                          \ $
The usual notation for $F(b) - F(a)$ is
$ lr(F(x)], size: #200%)_a^b #h(10pt) "or" #h(10pt) lr([F(x)], size: #200%)_a^b, $
depending on whether $F$ has one or more terms.

== The Substitution Rule
If $u = g(x)$ is a differentiable function whose range is an interval $I$ and
$f$ is continuous on $I$, then
$ integral (f(g(x))g'(x)) dif x = integral f(u) dif u. $

== Substitution in Definite Integrals
If $g'$ is continuous on the interval $[a, b]$ and $f$ is continuous on the
range of $g$, then
$ integral_a^b f(g(x)) dot g'(x) dif x = integral_g(a)^g(b) f(u) dif u $

= Applications of Definite Integrals
