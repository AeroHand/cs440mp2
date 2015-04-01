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
    pre[i][0]=0
    for token in string.gmatch(prereq[i], "[^%s]+") do
      pre[i][0]=pre[i][0]+1
      pre[i][pre[i][0]]=tonumber(token)
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


function next_season(temp)
  if temp==1 then
    return 2
  else
    return 1
  end
end

function axb(frontier, cn, curcre ,curgold , curseason, ftn, prec)
  --if it reaches the largest credit
  curcre=curcre+cou[frontier[cn]][3]
  if curcre>maxcounum then
    try next season
    curseason=next_season(curseason)
    axb(frontier,cn,0,curgold,curseason)
    return
  end

  --if we cant affort that much cost
  curgold=curgold+cou[frontier[cn]][curseason]
  if curgold>cost then
    nextseason=next_season(curseason)
    --try next season if it costs less
    if cou[frontier[cn]][curseason]<cou[frontier[cn]][nextseason] then
      axb(frontier,cn,0,curgold-cou[frontier[cn]][curseason],nextseason)
    end  
    return
  end  
  
  --choose the course
  --move it out from frontier, check if any courses could be added into frontier
  for i=1,counum do
    for j=1,prec[i][0] do
      if prec[i][j]==frontier[cn] then
        for k=j,(prec[i][0]-1) do
          prec[i][k]=prec[i][k+1]
        end
        prec[i][0]=prec[i][0]-1
        if prec[i][0]==0 then
          ftn=ftn+1
          frontier[ftn]=i
        end
      end
    end
  end
  
  

end  



--main	
f="2.1input.txt"
getFile(f)
tbc={}
temp=0
for i=1,counum do
  if pre[i][0]==0 then
    temp=temp+1
    tbc[temp]=i
  end  
end

axb(tbc,1,0,0, 1,temp,pre)


