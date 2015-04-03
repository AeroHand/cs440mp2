--lua不支持堆栈 准备用多维表模拟堆栈
--或者每次回溯结束后写个擦屁股函数

function getFile(file_name)
  local f = assert(io.open(file_name, 'r'))
  count=0
  a={}
  for i=1,6,1 do
  	a[i]={}
  	local temp=""
  	for j=1,6,1 do
      a[i][j]=f:read("*number")
      temp=temp.." "..tostring(a[i][j])
    end  
    print(temp)
  end  
  f:close()
end

function alphabeta(curstate,player,alpha,beta,depth)
  if finished(curstate) or (depth>3) then

    return eval(curstate)
  end  	
  if player==1 then
  	value=-10000
  	betabreak=false
  	for i=1,6 do
  		if betabreak then
  			break
        end
		for j=1,6 do
			if curstate[i][j]==0 then
        local tempm=move(curstate,i,j,1,2)
        local tempt={}
        for i=1,6 do
          tempt[i]={}
           for j=1,6 do
                tempt[i][j]=curstate[i][j]
            end
        end
				temp=alphabeta(move(curstate,i,j,1,2),2,alpha,beta,depth+1)
        curstate=tempm
				if temp>value then
					value=temp
			    end
			    if value>alpha then
			    	alpha=value
			    end
			    if beta<=alpha then
                  betabreak=true
			      break
			    end   	
			end
	    end
	end
    return value
  else
    value=10000
    alphabreak=false
    for i=1,6 do
    	if alphabreak then
  			break
        end
		for j=1,6 do
			if curstate[i][j]==0 then    
				temp=alphabeta(move(curstate,i,j,2,1),1,alpha,beta,depth+1)
				if temp<value then
					value=temp
			    end
			    if value<beta then
			    	beta=value
			    end
			    if beta<=alpha then
			      alphabreak=true
			      break
			    end   	
			end
	    end
	end
    return value
  end  
end

function minmax(curstate,player,depth)
  print("this try:")
  deepprint(curstate)
  print("player:",player,"depth:",depth)
  if finished(curstate) or (depth>3) then
    return eval(curstate)
  end  	
  if player==1 then
  	value=-10000
  	for i=1,6 do
		for j=1,6 do
			if curstate[i][j]==0 then
        local tempm=move(curstate,i,j,1,2)
        local stepp=step
				temp=minmax(tempm,2,depth+1)
        --deepprint(tempm)
        curstate=moveback(curstate,stepp)
        --deepprint(curstate)
        print("step",stepp)
				if temp>value then
					value=temp
			  end		
			end
	    end
	end
    return value
  else
    value=10000
    for i=1,6 do
		for j=1,6 do
			if curstate[i][j]==0 then
        local tempm=move(curstate,i,j,2,1)
				local stepp=step
        temp=minmax(tempm,1,depth+1)
        --deepprint(tempm)
        curstate=moveback(curstate,stepp)
        
        print("step",stepp)
				if temp<value then
					value=temp
			    end		
			end
	    end
	end
    return value
  end  
end

function deepprint(yoyoyo)
   for i=1,6,1 do
    local temp=""
    for j=1,6,1 do
      temp=temp.." "..tostring(yoyoyo[i][j])
    end  
    print(temp)
  end   
  print("")
end

function moveback(curstate,step)
       
   for i=1,6 do
    for j=1,6 do
       curstate[i][j]=as[step][i][j]
    end
  end
  return curstate  
end  

function move(curstate,i,j,player,nextplayer)
  step=step+1
  as[step]={}
  for i=1,6 do
    as[step][i]={}
    for j=1,6 do
      as[step][i][j]=curstate[i][j]
    end
  end    
	curstate[i][j]=player
	downx=i
	upx=i
	downy=j
	upy=j
	if i>1 then
		downx=i-1
    end		
    if i<6 then
    	upx=i+1	
    end
    if j>1 then
        downy=j-1
    end
    if j<6 then
        upy=j+1
    end
    isdrop=true
      for x=downx,upx do

        if (curstate[x][j]==player) and (not(x==i))  then
          isdrop=false
        end

      end

      for y=downy,upy do
        if (curstate[i][y]==player) and (not(y==j))  then
          isdrop=false
        end
      end  
    --get ur enemy's land
    if not(isdrop) then
      for x=downx,upx do

        if curstate[x][j]==nextplayer then
          curstate[x][j]=player
        end

      end

      for y=downy,upy do
        if curstate[i][y]==nextplayer then
          curstate[i][y]=player
        end
      end    
    end

  return curstate          
end             	
function finished(jjj)
	local temp=true
	for i=1,6 do
		for j=1,6 do
			if jjj[i][j]==0 then
				temp=false 
			end
	    end
	end
	return temp
end	   			

function eval(zq)
	local sum=0
	for i=1,6 do
		for j=1,6 do
			if zq[i][j]==1 then
				sum=sum+a[i][j]
		    end
		end
    end
    return sum
end    		    		

getFile("Narvik.txt")
--state record for evaluation
zou={}
as={}
for i=1,6 do
	zou[i]={}
	for j=1,6 do
      zou[i][j]=0
    end
end
step=0
bvalue=minmax(zou,1,1,0)
--bvalue=alphabeta(zou,1,1,-10000,10000,0)
print(bvalue)

