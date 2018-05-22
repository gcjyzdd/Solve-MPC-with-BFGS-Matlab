# Solve MPC with BFGS Matlab

## Examples

Run `main.m` to solve model predictive control using bfgs and you get the result as the following:

<div style="text-align:center"><img src ='./images/demo1.jpg' /></div>

## Real time performance

Run `bfgs_script` to generate C code and a mexed version `bfgs`.

Before code generation:

```
Average time consumption is: 0.061
```

After code generation:

```
Average time consumption is: 0.007
```

