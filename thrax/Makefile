g2p_gd.far: g2p_gd.grm util.far
	thraxcompiler --input_grammar=$< --output_far=$@

util.far: util.grm byte.far
	thraxcompiler --input_grammar=$< --output_far=$@

byte.far: byte.grm 
	thraxcompiler --input_grammar=$< --output_far=$@

clean:
	rm -f util.far byte.far
