function v = bolzano_verifier(f, a, b)
	v = (subs(f, a) * subs(f, b) <= 0);
end
