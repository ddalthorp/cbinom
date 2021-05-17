require(cbinom)
###### qcbinom:

## p arg
# comparison with qbinom (and a look at bad numeric values)
p <- seq(-.1, 1.1, by = .1)
size <- 12
prob <- 0.4
plot(p, qcbinom(p, size = size, prob = prob))
points(p,qbinom(p, size = size, prob = prob) + 0.5, pch = "*", col = 3)
cbind(qcbinom(p, size = size, prob = prob), 0.5 + qbinom(p, size = size, prob = prob))

# behavior near the boundaries of the support
p <- seq(0, 0.0001, length = 200)
plot(p, qcbinom(p, size, prob)) # looks good
p <- 1 - p
plot(p, qcbinom(p, size, prob)) # extremely sharp bend...

# step back a little
p <- 1 - seq(0, 0.1, length = 1000)
plot(p, qcbinom(p, size, prob)) # makes sense
points(p, qbinom(p, size, prob), col = 2, pch = "*") # makes sense

# bad non-numeric values
qbinom("b", 12, .3)
qcbinom("b", 12, .3)

qbinom(NA, 12, .3)
qcbinom(NA, 12, .3)

qbinom(NaN, 12, .3)
qcbinom(NaN, 12, .3)

## size arg
# comparison with qbinom (and a look at bad values)
p <- .3
size <- seq(-0.1, 5, by = 0.01)
prob <- 0.4
plot(size, qcbinom(p, size = size, prob = prob))
# behavior near the boundaries of the support
size <- seq(0, .1, by = 0.0001)
plot(size, qcbinom(p, size, prob))
qcbinom(.3, Inf, .2)
# q is inverse of p?
pcbinom(qcbinom(p, size, prob), size, prob)

# bad non-numeric values
qbinom(.4, "b", .3)
qcbinom(.4, "b", .3)

qbinom(.4, NA, .3)
qcbinom(.4, NA, .3)

qbinom(.4, NaN, .3)
qcbinom(.4,NaN, .3)

## prob arg
# comparison with qbinom (and a look at bad values)
p <- .3
size <- 12
# prob > 1 should return NaN
# prob <= 0 should return NaN
qbinom(p, size, 1.1)
qcbinom(p, size, 1.1)
qbinom(p, size, -.1)
qcbinom(p, size, -.1)

prob <- seq(-0.1, 1.1, by  = 0.01)
plot(prob, qcbinom(p, size = size, prob = prob))
points(prob, qbinom(p, size = size, prob = prob), pch = "*", col = 2)
# behavior near the boundaries of the support
prob <- seq(0, .01, length = 200)
plot(prob, qcbinom(p, size, prob))
# q is inverse of p?
pcbinom(qcbinom(p, size, prob), size, prob) # when prob = 0,

## normal approximation
prob <- seq(0.01, .2, leng=100)
sz <- 12
pp <- log(.3)
plot(
  qnorm(pp, sz*prob + 0.5, sqrt(sz*(prob*(1-prob))), log = T),
  qcbinom(pp, sz, prob, log = T)
)
abline(a = 0, b=1)

### log scale
# p arg
p <- log(seq(-.1, 1.1, by = .1))
size <- 12
prob <- 0.4
plot(p, qcbinom(p, size = size, prob = prob, log = T))
points(p,qbinom(p, size = size, prob = prob, log = T) + 0.5, pch = "*", col = 3)
cbind(
  qcbinom(p, size = size, prob = prob, log = T),
  0.5 + qbinom(p, size = size, prob = prob, log = T)
)
# behavior near the boundaries of the support
p <- log(seq(0.00001, 0.0001, length = 200))
plot(p, qcbinom(p, size, prob, log = T)) # looks good
p <- log(1 - exp(p))

# lowertail
p <- seq(0, 1, by = .01)
size <- 12
prob <- 0.4
plot(p, qbinom(p, size, prob))
points(p, qbinom(p, size, prob, lower = F), col = 2)

plot(p, qcbinom(p, size, prob))
points(p, qcbinom(p, size, prob, lower = F), col = 2)



####### pcbinom:

## q arg
# comparison with qbinom (and a look at bad numeric values)
size <- 12
prob <- 0.4
q <- seq(-.1, size + 1.1, by = .1)
plot(q, pcbinom(q, size = size, prob = prob))
points(q, pbinom(q, size = size, prob = prob), pch = "*", col = 3)
cbind(pcbinom(q, size = size, prob = prob), pbinom(q, size = size, prob = prob))

# behavior near the boundaries of the support
q <- seq(0, 2, length = 200)
plot(q, pcbinom(q, size, prob)) # looks good
points(q, pbinom(q, size, prob), pch = "*", col = 3)

# step back a little
q <- seq(0, size + 1, length = 1000)
plot(q, pcbinom(q, size, prob)) # makes sense
points(q, pbinom(q, size, prob), col = 3, pch = "*") # makes sense

# bad non-numeric values
pbinom("b", 12, .3)
pcbinom("b", 12, .3)

pbinom(c(NA, 3), 12, .3)
pcbinom(c(NA, 3), 12, .3)

pbinom(c(NaN, 3, NA), c(12, 12, NaN), .3)
pcbinom(c(NaN, 3, NA), c(12, 12, NaN), .3)

## size arg
# comparison with pbinom (and a look at bad values)
size <- 0:10# seq(0, 5, length = 200)
q <- 1
prob <- 0.4
plot(size, pcbinom(q, size = size, prob = prob))
points(size, pbinom(q, size = size, prob = prob))
# behavior near the boundaries of the support
size <- seq(0, .1, length = 1000)
plot(size, pcbinom(q, size, prob))
pcbinom(31, Inf, .3)
# q is inverse of p?
pcbinom(pcbinom(q, size, prob), size, prob)

# bad non-numeric values
pbinom(.4, "b", .3)
pcbinom(.4, "b", .3)

pbinom(.4, NA, .3)
pcbinom(.4, NA, .3)

pbinom(.4, NaN, .3)
pcbinom(.4,NaN, .3)

## prob arg
# comparison with pbinom (and a look at bad values)
q <- 6
size <- 12
prob <- seq(-0.1, 1.1, length = 200)
plot(prob, pcbinom(q, size = size, prob = prob))
points(prob, pbinom(q, size = size, prob = prob), pch = "*", col = 2)
# behavior near the boundaries of the support
prob <- seq(0.0001, .001, length = 200)
plot(prob, pcbinom(q, size, prob))
points(prob, pbinom(q, size, prob))
# q is inverse of p?
qcbinom(pcbinom(q, size, prob, log=T), size, prob, log = T)

qbinom(pbinom(q, size, prob, log = T), size, prob, log = T)

### log scale
# q arg
q <- log(seq(-.1, 1.1, by = .1))
size <- 12
prob <- 0.4
plot(q, pcbinom(q, size = size, prob = prob, log = T))
points(q,pbinom(q, size = size, prob = prob, log = T) + 0.5, pch = "*", col = 3)
cbind(
  pcbinom(q, size = size, prob = prob, log = T),
  0.5 + pbinom(q, size = size, prob = prob, log = T)
)
# behavior near the boundaries of the support
p <- log(seq(0.00001, 0.0001, length = 200))
plot(p, pcbinom(p, size, prob, log = T)) # looks good
p <- log(1 - exp(p))

# lowertail
p <- seq(0, 1, by = .01)
size <- 12
prob <- 0.4
plot(p, pbinom(p, size, prob))
points(p, 1 - pbinom(p, size, prob, lower = F), col = 2)

plot(p, pcbinom(p, size, prob))
points(p, 1 - pcbinom(p, size, prob, lower = F), col = 2)

########### rcbinom
size <- 4
prob <- 0.2
mean(rcbinom(1000000, size, .2))
integrate(function(x) pbeta(.2, x, size - x + 1), lower = 0, upper = size + 1)$val

rbinom(-1, 14, .2)
rcbinom(-1, 14, .2)

rbinom(c(1,2,3), 14, .2)
rcbinom(c(1,2,3), 14, .2)

rbinom(NA, 14, .2)
rcbinom(NA, 14, .2)

rbinom(c(NA, NA), 14, .2)
rcbinom(c(NA, NA), 14, .2)

rbinom(5, -1:3*20, .4)
rcbinom(5, -1:3*20, .4)

rcbinom(6, c(NA, NaN, 3, 1, 16, 11), c(.4, .88, -.1))
rbinom(6, c(NA, NaN, 3, 1, 16, 11), c(.4, .88, -.1))


########### dcbinom
size <- 12
prob <- .3
x <- seq(0, size + 1, length = 200)
plot(x, dcbinom(x, size, prob))
points(x, exp(dcbinom(x, size, prob, log=T)), pch = "*", col =2)

plot(exp(dcbinom(x, size, prob, log=T)), dcbinom(x, size, prob))
abline(a=0, b =1, col = 2)

cbind(exp(dcbinom(x, size, prob, log=T)), dcbinom(x, size, prob))
