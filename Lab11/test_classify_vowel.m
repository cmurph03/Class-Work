%test classify_vowel
load vowels_new3
x = 15;

A = strings(1,x);
E = strings(1,x);
I = strings(1,x);
O = strings(1,x);
U = strings(1,x);

for n = 1:x
    A(n) = classify_vowel(t,Ma(n,:));
    E(n) = classify_vowel(t,Me(n,:));
    I(n) = classify_vowel(t,Mi(n,:));
    O(n) = classify_vowel(t,Mo(n,:));
    U(n) = classify_vowel(t,Mu(n,:));
end
R = [A;E;I;O;U];
table(R);