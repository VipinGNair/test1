
function gfcs = poly(m)
if m == 1 
    i = [];
else
    i = 1;
end

n = 2^m - 1;
gfcs = [];                   % used for the output
ind = ones(1, n - 1);      % used to register unprocessed numbers.

while ~isempty(i)

   % to process numbers that have not been done before.
   ind(i) = 0;             % mark the register
   s = i;
   v = s;
   pk = rem(2*s, n);       % the next candidate

   % build cyclotomic coset containing s=i
   while (pk > s)
          ind(pk) = 0;    % mark the register
          v = [v pk];     % recruit the number
          pk = rem(pk * 2, n);    % the next candidate
   end;

   % append the coset to gfcs
   [m_cs, n_cs] = size(gfcs);
   [m_v, n_v ]  = size(v);
   if (n_cs == n_v) || (m_cs == 0)
          gfcs = [gfcs; v];
   elseif (n_cs > n_v)
          gfcs = [gfcs; [v, ones(1, n_cs - n_v) * 0]];
   else
          % this case should not happen, in general.
          gfcs = [[gfcs, ones(m_cs, n_v - n_cs) * 0]; v];
   end;
   i = find(ind == 1,1,'first');        % the next number.

end;

% add the number "0" to the first coset
[m_cs, n_cs] = size(gfcs);
gfcs = [[0, ones(1, n_cs - 1) * 0]; gfcs];

