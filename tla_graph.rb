#!/usr/bin/env ruby

require 'pp'

def different_chars(tla1, tla2)
	diff = 0
	diff += 1 if tla1[0] != tla2[0]
	diff += 1 if tla1[1] != tla2[1]
	diff += 1 if tla1[2] != tla2[2]
	diff
end

TLAS = File.readlines('tlas.txt').map { |e| e.chomp.upcase }.uniq

puts "digraph tlas {"
TLAS.each do |tla|
	puts tla + ";"
	TLAS.map { |e| [ e, different_chars(tla, e) ] }.select { |e| e[1] == 1 }.map { |e| e[0] }.each do |target|
		puts "#{tla} -> #{target}"
	end
end
puts "}"
