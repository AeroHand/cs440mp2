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


function next_season(temp)
  if temp==1 then
    return 2
  else
    return 1
  end
end

function axb(ftsz, cn, curcre ,curgold , curseason, ftn, prec,gcn,gc, cursem, semt, semc)
  --if it reaches the largest credit
  local frontier=ftsz
  curcre=curcre+cou[frontier[cn]][3]
  if curcre>maxcounum then
    --try next season
       
    curseason=next_season(curseason)
    axb(frontier,cn,0,curgold,curseason,ftn,prec,gcn,gc,cursem,semt+1,1)
    return
  end

  --if we cant affort that much cost
  curgold=curgold+cou[frontier[cn]][curseason]
  if curgold>cost then
    nextseason=next_season(curseason)
         
    --try next season if it costs less
    if cou[frontier[cn]][curseason]<cou[frontier[cn]][nextseason] then
      axb(frontier,cn,0,curgold-cou[frontier[cn]][curseason],nextseason,ftn,prec,gcn,gc,cursem,semt+1,1)
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
        --this course is ready to be pick
        if prec[i][0]==0 then
          ftn=ftn+1
          frontier[ftn]=i
        end
      end
    end
  end
  --push it to current semester
  semc=semc+1
  cursem[semt][semc]=frontier[cn]

  --check if we could graduate
  for i=1,gcn do
    if gc[i]==frontier[cn] then
      for k=i,(gcn-1) do
        gc[k]=gc[k+1]
      end  
      gcn=gcn-1

      local tempa=""
      for i=1,gcn do
        tempa=tempa..tostring(gc[i]).." "
      end  
      print("course left:",tempa)

      if gcn==0 then
        sn=sn+1
        print("valid solution: ",sn)
        for i=1,semt do
          print("semester ",i)
          for j=1,semc do
            print(cursem[i][j])
          end  
        end
        print("total cost:",curgold)
        print("total credit:",curcre)  
      end  
    end
    
    --deepcopy
    dc={}
    for i=1,cn-1 do
      dc[i]=frontier[i]
    end  

    --abandon this course
    for i=cn,ftn-1 do
      dc[i]=frontier[i+1]
    end
    ftn=ftn-1

    
    --try pick other courses in frontier
    --print("ftn",ftn)
    for i=1,ftn,1 do
      --print("i",i,ftn)
      local tempa=""
      for i=1,ftn do
        tempa=tempa..tostring(frontier[i]).." "
      end  
      print("coud be taken",tempa)
      print("taking:")
      for i=1,semt do
        tempa=""
        for j=1,semc do
          tempa=tempa..tostring(cursem[i][j]).." "
        end
        print("semester ",i, ":",tempa)
      end    

      if dc[i] then
        axb(dc, i, curcre, curgold , curseason, ftn, prec, gcn, gc,cursem,semt,semc)
      end

    end
    
    
    return  
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
sn=0
cursem={}
for i=1,20 do
  cursem[i]={}
end
for i=1,temp do
  if tbc[i] then
    axb(tbc,i,0,0, 1,temp,pre,m,mm,cursem,1,0)
  end  
end

