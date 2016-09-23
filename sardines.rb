require 'find'

Find.find('.') {|path|
  if %w{Read_me.txt Thumbs.db}.include?(File.basename(path))
    print "rm #{path}\n"
  end
  r = File.basename(path).split('.')
  if(r.size > 1)
    s = r[1..-1].join('.')
    if %w{shp.xml aux.xml aux}.include?(s)
      print "rm #{path}\n"
    end
  end
}
