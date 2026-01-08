// Chapter 2 Example 15

// FIGURE 2.53
// Transfer function
// example for G(s)
// and H ( s) .
>>numg=[6 0 1]; deng=[1 3 3 1];sysg=tf(numg,deng);
>>z=zero(sysg)

>>p=pole(sysg)
>>n1=[1 1]; n2=[1 2]; d1=[1 2*i]; d2=[1 -2*i]; d3=[1 3];
>>numh=conv(n1,n2); denh=conv(d1,conv(d2,d3));
>>sysh=tf(numh,denh)

>>sys=sysg/sysh

>>pzmap(sys)