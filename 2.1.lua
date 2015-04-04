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
  pre={}
  for i=1,counum do
    prereq[i]=f:read("*line")
    pre[i]={}
    tttt=-1
    for token in string.gmatch(prereq[i], "[^%s]+") do
      tttt=tttt+1
      pre[i][tttt]=tonumber(token)
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

function maxed(a,b)
  if a>b then
    return a
  else
    return b
  end
end    
    

function getorder(n)
  if order[n] then
    return order[n]
  end
  if pre[n][0]==0 then
    return 1
  end
  local max=0
  for i=1,pre[n][0] do
    max=maxed(max,getorder(pre[n][i])+1)
  end
  return max
end    

function no(n)
  temp=true
  for i=1,m do
    if mm[i]==n then
      print(mm[i],"equal",n)
      temp=false
    end
  end    
  return temp
end

function noob(n)
  if order[n]==1 then
    if no(n) then
      print("add",n)
      m=m+1
      mm[m]=n
      return
    end  
  end
  for i=1,pre[n][0] do
    noob(pre[n][i])
  end  
end

--main  
f="2.1input.txt"
getFile(f)

--get a proper order of the courses
order={}
--record courses that must be taken
must={}

for i=1,counum do
  --course without prerequest
  order[i]=getorder(i)
end  

for i=1,counum do
  print("course",i,"order",order[i])
end  

for i=1,m do
  noob(mm[i])
end

for i=1,m do
  print(mm[i])
end