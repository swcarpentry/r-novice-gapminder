#!/usr/bin/env ruby
# grab the "challenge" text from a .Rmd file
#  (in a set of lines that start with >)
#  and put each in the center of a slide

# grab input file name from command line
ifile = ARGV.length > 0 ? ARGV[0] : "ggplot2.Rmd"

# ofile name adds _slides
ofile = ifile.sub(/(\.\w+)$/, '_slides.Rmd')
#abort("file #{ofile} already exists") if File.exists?(ofile)

output = []

ifilep = File.open("../" + ifile)

ifilep.each do |line|
    if line =~ /^> ### Challenge/
        this_output = ''
        while !(ifilep.eof?) and (line2 = ifilep.readline()) =~ /^>/
            if line2 =~ /^>\s+$/
                line2 = "\n"
            else
                line2.sub!(/^>\s?/, "")
            end
            this_output += line2
        end
        output.push(this_output)
    end
end

ofilep = File.open(ofile, 'w')
ofilep.write("---\n")
ofilep.write("output: slidy_presentation\n")


challenge = 1
output.each do |ochunk|
    ofilep.write("---\n\n")
    ofilep.write("# Challenge #{challenge}\n\n")
    ofilep.write(ochunk)
    ofilep.write("\n")
    challenge += 1
end
