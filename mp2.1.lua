function getFile(file_name)
  local f = assert(io.open(file_name, 'r'))
  counum=f:read("*number")
  mincounum=f:read("*number")
  maxcounum=f:read("*number")

  cou={}
  for i=1,counum do
    cou[i]={}
    cou[i][1]=f:read("*number")  --fall cost
    cou[i][2]=f:read("*number")  --spring cost
    cou[i][3]=f:read("*number")  --credit
  end

  trash=f:read("*line")
  prereq={}
  for i=1,counum do
    prereq[i]=f:read("*line")
    for token in string.gmatch(prereq[i], "[^%s]+") do
      print(token)
      
    end  

  end  
  
  m=f:read("*number")
  mm={}
  for i=1,m do
    mm[i]=f:read("*number")


  end

  cost=f:read("*number")

  f:close()
end


function axb()
  
end  



--main	
f="2.1input.txt"
getFile(f)
l={}



