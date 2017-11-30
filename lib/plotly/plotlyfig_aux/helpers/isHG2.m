function check = isHG2
%check for HG2 update
check = false;
if( ~exist( 'OCTAVE_VERSION', 'builtin' ) )
  check = ~verLessThan('matlab','8.4.0');
end

end
