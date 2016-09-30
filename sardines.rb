require 'find'
LIMIT = 85 * 1024 * 1024

large_files = []
Find.find('.') {|path|
  if %w{Read_me.txt Readme.txt Thumbs.db}.include?(File.basename(path))
    print "rm #{path}\n"
  end
  r = File.basename(path).split('.')
  if(r.size > 1)
    s = r[1..-1].join('.')
    if %w{shp.xml aux.xml aux gz sbx sbn}.include?(s)
      print "rm #{path}\n"
    end
  end
  if(File.size(path).to_f  / LIMIT > 1)
    print "split -b 85m #{path} #{path}.\n"
    print "rm #{path}\n"
    large_files << path
  end
}
if(large_files.size > 0)
  File.open('.gitignore', 'w') {|w|
    large_files.each {|path|
      w.print path, "\n"
    }
  }
  $stderr.print ".gitignore written.\n"
  File.open('unsplit.sh', 'w') {|w|
    large_files.each {|path|
      w.print "cat #{path}* > #{path}\n"
    }
  }
  $stderr.print "unsplit.sh written.\n"
end
