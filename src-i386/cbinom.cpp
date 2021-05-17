#include <Rcpp.h>
#include <cmath>

using namespace Rcpp;
const double eps = DBL_EPSILON;
double pcbinom(double x, double n, double p,
    bool lowertail = true, bool logp = false){
  if (x < eps){
    if (lowertail && !logp){
      return(0);
    } else if (lowertail && logp){
      return(R_NegInf);
    } else if (!lowertail && !logp) {
      return(1);
    } else if (!lowertail && logp){
      return(0);
    }
  }
  if (x > n + 1 - eps){
    if (lowertail && !logp){
      return(1);
    } else if (lowertail && logp){
      return(0);
    } else if (!lowertail && !logp){
      return(0);
    } else if (!lowertail && logp){
      return(R_NegInf);
    }
  }
  return(R::pbeta(p, x, n - x + 1, 1 - lowertail, logp));
}

// [[Rcpp::export]]
NumericVector qcbinomC(NumericVector p, NumericVector m, NumericVector g,
  bool lowertail = true, bool logp = false, bool rcb = false){
  int n = int(p.size());
  if (!rcb){//if random, length = length(p); otherwise, length = maxlen(p, m, g)
    n = std::max(n, int(m.size()));
    n = std::max(n, int(g.size()));
  }
  double tol = sqrt(eps);
  NumericVector x(n);
  double x0, x1, x2, f0, f1, sz, prob;
  double minx = 2 * eps;
  for (int i = 0; i < n; i++){
    prob = g[i%g.size()];
    sz = m[i%m.size()];
    if (!logp){
      p[i] = log(p[i]);
    }
    if (p[i] == R_NegInf){
      x[i] = 0;
      continue;
    }
    if (p[i] >= log(1 - eps)){
      x[i] = sz + 1;
      continue;
    }
    x0 = R::qnorm(p[i%p.size()], sz * prob + 0.5, sqrt(sz*(prob*(1 - prob))),
      lowertail, 1);
    x0 = fmax(fmin(x0, sz + 1 - minx), minx);
    f0 = pcbinom(x0, sz, prob, lowertail, 1) - p[i%p.size()];
    if (f0 <= 0){
      x1 = fmin(x0 + 0.1, sz + 1 - minx);
    } else {
      x1 = fmax(x0 - 0.1, minx);
    }
    f1 = pcbinom(x1, sz, prob, lowertail, 1) - p[i%p.size()];
    x2 = x1 - f1 *(x1 - x0)/(f1 - f0);
    if (fabs(x2 -  x1) < tol){
      x[i] = x2;
      continue;
    }
    x0 = x1;
    x1 = x2;
    while (1){
      f0 = f1;
      f1 = pcbinom(x1, sz, prob, lowertail, 1) - p[i%p.size()];
  		x2 = x1 - f1 * (x1 - x0)/(f1 - f0);
      x2 = fmax(fmin(x2, sz + 1 - minx), minx);
      x0 = x1;
      x1 = x2;
      if (fabs(x0 - x1) <= tol){
        x[i] = x1;
        break;
      }
    }
  }
  return(x);
}

// [[Rcpp::export]]
NumericMatrix dcblp(NumericVector x, NumericVector m, NumericVector g){
// intermediate calculations for dcbinom (called from R)
  int n = x.size();
  double xi, mi, gi;
  n = std::max(n, int(m.size()));
  n = std::max(n, int(g.size()));
  NumericMatrix f(n, 3);
  double h = 1e-5;
  for (int i = 0; i < n; i++){
    xi = x[i%x.size()];
    mi = m[i%m.size()];
    gi = g[i%g.size()];
    if (xi <= eps) {
      f(i, 0) = R_NegInf;
      f(i, 1) = R_NegInf;
      f(i, 2) = h;
    } else if (xi > mi + 1) {
      f(i, 0) = 0;
      f(i, 1) = 0;
      f(i, 2) = h;
    } else if (xi >= h && xi <= mi + 1 - h){
      f(i, 0) = pcbinom(xi + h, mi, gi, 1, 1);
      f(i, 1) = pcbinom(xi - h, mi, gi, 1, 1);
      f(i, 2) = 2 * h;
    } else if (xi <= h) {
      f(i, 0) = pcbinom(xi + h, mi, gi, 1, 1);
      f(i, 1) = pcbinom(xi, mi, gi, 1, 1);
      f(i, 2) = h;
    } else {
      f(i, 0) = pcbinom(xi, mi, gi, 1, 1);
      f(i, 1) = pcbinom(xi - h, mi, gi, 1, 1);
      f(i, 2) = h;
    }
  }
  return(f);
}
