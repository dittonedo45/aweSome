def FilterUpTohere (a)
  go=true
  return a.filter {
    |x|
    (go=false) if (/^#/=~x)
    x=~/^-/ and go
  }
end
def Show_Info(x)
    (FilterUpTohere x[1..]).each {
      |y|
      next if not /^-\s*\[[^\]]+\]\s*\(([^\)]+)\)\s+-\s+(.*)$/i=~y
      b=((/^-\s*\[([^\]]+)\]\s*\(([^\)]+)\)\s+-\s+(.*)$/i).match y)
      puts ({"group"=>x[0],
       "name"=>b[1],
       "url"=>b[2],
       "description"=>b[3]
      })
      p("robert", "#{b[1]} #{b[3]}")
      #printf "%19s | %19s | %s\n",x[0].gsub(/^#*/,''),b[1],b[2]
    }
end
(((File.read "README.md").split "\n").slice_before {|x| /^#[^#]/=~x })
  .each {
  |x|
  next if (x[0].empty?) or (not (x[0]=~/^#/))
  Show_Info x
  x[0]=[x[0]]
  h=x[0]
  (x[1..].slice_before {|x| /^##[^#]/=~x })
    .each {
    |x|
    next if (x[0].empty?) or (not (x[0]=~/^#/))
    hh=h+[x[0]]
    x[0]=hh
    Show_Info x
    (x[1..].slice_before {|x| /^###[^#]/=~x })
      .each {
      |x|
      next if (x[0].empty?) or (not (x[0]=~/^#/))
      x[0]=hh+[x[0]]
      Show_Info x
    }
  }
}
