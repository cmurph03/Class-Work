% trials for Lab11

load fbnd;
load vowels;

%figure(1)
%energy_profile_vowel(fbnd,10,'vowels');
%energy_profile_speaker(fbnd,10,'vowels2','vowels_new2');
%metric_speaker_cycle(fbnd,'vowels','vowels2','vowels3');
%metric_speaker_plot(fbnd,1,2,['io'],'vowels');

%figure(2)
%energy_profile_vowel(fbnd, 10,'vowels_new2');
%figure(3)
%energy_profile_vowel(fbnd, 10,'vowels2');
%metric_vowel_plot(fbnd,E(1),E(2),['io'],'vowels','vowels2','vowels3');

%metric_vowel_cycle(fbnd,['io'],'vowels');


%Classifying Speaker 2
%metric_vowel_plot(fbnd,12,13,'vowels2');
%[0.0014 0.0860; 0.0003 0.1948]
% indexx1 = 'aeu' index 2 = 'io'
%metric_vowel_plot(fbnd,9,11,['io'],'vowels2');
%decV = [0.0865 0.1849; 0.0323 0.3144];
% index 1 = o,  index 2 = i
%metric_vowel_plot(fbnd,13,15,['aeu'],'vowels2')
%decV = [0.0208 0.3344; 0.0600 0.2470];
% index 1 = e,  index 2 = 'au'
%metric_vowel_plot(fbnd,8,14,['au'],'vowels2')
%decV = [0.0798 0.4159; 0.1184 0.4595];
%index 1 = a   index 2 = u






%Classifying tree for speaker 1
%split of into 'aeu' and 'io'
%metric_vowel_plot(fbnd,4,12,'vowels');
%decV = [0.0020 0.0002; 0.0020 0.0018];
% %index 2 is 'io', index 1 is 'aeu'
%split into 'i' and 'o'
%metric_vowel_plot(fbnd,9,11,['io'],'vowels');
%decV = [0.0615 0.0106; 0.0485 0.0197];
%index 2 is 'i', index 1 is 'o'
%split into 'a' and 'eu'
%metric_vowel_plot(fbnd,14,15,['aeu'],'vowels') 
%[0.0007 0.0003; 0.0005 0.0003]
%index 2 is 'eu', index 1 is 'a'
%split into 'e' and 'u'
%metric_vowel_plot(fbnd,11,15,['eu'],'vowels');
%[0.0001 0.0002; 0.0002 0.0001]
%index 2 is 'u' and index 1 is 'e'


%Classifying speaker
%metric_speaker_plot(fbnd,3,15,'vowels','vowels2','vowels3');
%decV = [-0.1193 0.2846; 0.1603 0.2861];
%index 1 is speaker 1&2 and index 2 is speakers 3
%metric_speaker_plot(fbnd,5,14,'vowels','vowels2');
% decV = [0.3947 0.1811; 0.1620 0.3204];
%index 1 is speaker 1, index 2 is speaker 2


%metric_vowel_cycle(fbnd,['eu'],'vowels3');

%Classifying Speaker 3

%metric_vowel_plot(fbnd,11,15,'vowels3');
%[0.0012 0.0023; 0.0044 0.0004]
% indexx1 = 'aeu' index 2 = 'io'
%metric_vowel_plot(fbnd,12,15,['io'],'vowels3');
%decV = [0.0142 0.0008; 0.0029 0.0007];
% index 1 = i,  index 2 = o
%metric_vowel_plot(fbnd,8,15,['aeu'],'vowels3')
%decV = [0.0438 0.0001; 0.0219 0.0013];
% index 1 = a  index 2 = 'eu'
metric_vowel_plot(fbnd,11,12,['eu'],'vowels3')
%decV = [0.0001 0.0001; 0.0001 0.0003];
%index 1 = a   index 2 = u
decV = select_decision_pts;

