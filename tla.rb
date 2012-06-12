#!/usr/bin/env ruby

require 'pp'

START_TLA = "CDA";    # is in the big part of the graph
AVOID_BACKWARDS = 15  # number of recently seen entries to avoid, if possible

STDOUT.sync = true

def different_chars(tla1, tla2)
	diff = 0
	diff += 1 if tla1[0] != tla2[0]
	diff += 1 if tla1[1] != tla2[1]
	diff += 1 if tla1[2] != tla2[2]
	diff
end

def find_targets(tla, tlas)
	tlas.map { |e| [ e, different_chars(tla, e) ] }.select { |e| e[1] == 1 }.map { |e| e[0] }
end

TLAS = File.readlines('tlas.txt').map { |e| e.chomp.upcase }.uniq

tlas_seen = [ "   ", "   " ]

tla = START_TLA
while true
	puts " " + tlas_seen[-2] + "  " + tlas_seen[-1] + "  " + tla + " "
	tlas_seen << tla
	targets = find_targets(tla, TLAS)
	#if tlas_seen.size > AVOID_BACKWARDS && targets.size > 1 then
		(0..[tlas_seen.size-1, AVOID_BACKWARDS-1].max).each do |i|
			#puts "tlas seen big enough, and target size >= 1, removing #{tlas_seen[-2-i]}"
			if targets.size > 1 then
				targets = targets - [ tlas_seen[-2-i] ]
			end
		end
	#end
	tla = targets[rand(targets.size)]
	sleep 5
end

