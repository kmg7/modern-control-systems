clc;
A = [0 1; 0 0];
B = [0; 1];
P = [-1+ 1j; -1- 1j];

K = acker(A, B, P);
K