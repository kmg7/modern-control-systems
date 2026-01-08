
// FIGURE 2.45
// Script to analyze
// the spring-mass-
// damper.

>>y0=0.15;
>>wn=sqrt(2);
>>zeta=1/(2*sqrt(2));
>>t=[0:0.1:10];

%Compute Unforced Response to an Initial Condition
c=(y0/sqrt(1-zeta^2));
y=c*exp(-zeta*wn*t).*sin(wn*sqrt(1-zeta^2)*t+acos(zeta));
%
bu=c*exp(-zeta*wn*t);bl=-bu;
%
plot(t,y,t,bu,'--',t,bl,'--'), grid
xlabel('Time (s)'), ylabel('y(t) (m)')
legend(['\omega_n=',num2str(wn),' \zeta=',num2str(zeta)])

// FIGURE 2.47
// Entering the
// polynomial
// p ( s ) = s3 + 3s 2 + 4
// and calculating its
// roots.
>>p=[1 3 0 4];
>>r=roots(p)
// r =
// -3.3553
// 0.1777+ 1.0773i
// 0.1777- 1.0773i
>>p=poly(r)

// FIGURE 2.48
// Using conv and
// polyval to ­multiply
// and evaluate
// the polynomials
// (3s2 + 2s + 1)
// ( s + 4).

>>p=[3 2 1]; q=[1 4];
>>n=conv(p,q)
// n=
// 3 14 9 4
>>value=polyval(n,-5)


// FIGURE 2.49
// Using the tf
// function to create
// transfer function
// objects and adding
// them using the tf
// operator.

>> num1=[10];den1=[1 2 5];
>> sys1=tf(num1,den1)
// Transfer function:
// 10
// -----------------
// s^2 + 2 s + 5
>> num2=[1];den2=[1 1];
>> sys2=tf(num2,den2)
// Transfer function:
// 1
// -------
// s + 1
>> sys=sys1+sys2
// Transfer function:
// s^2 + 12 s + 15
// ----------------------------
// s^3 + 3 s^2 + 7 s + 5

// FIGURE 2.50
// Using the pole
// and zero functions
// to compute the pole
// and zero ­locations of
// a linear system.

>> sys=tf([1 10],[1 2 1])
>> p=pole(sys)
>> z=zero(sys)

// FIGURE 2.51
// The pzmap
// function.
[P,Z]=pzmap(sys)