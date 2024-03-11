[A, B, C, D] = linmod('SYS2_1')


Co = ctrb (A,B)
unctr = length (A) - rank (Co) ; %Число неуправляемых мод
if unctr == 0
   disp ( 'Система полностью управляема' )
else 
   T = 'Число неуправляемых мод равняется';
   disp ([T unctr])	
end
