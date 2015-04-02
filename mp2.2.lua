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


--[[

function alphabeta(node, depth, alpha, beta, maximizingplayer)
       if depth = 0 or node is a terminal node
          return the heuristic value of node
       if maximizingPlayer
          v := -∞
          for each child of node
              v := max(v, alphabeta(child, depth - 1, α, β, FALSE))
              α := max(α, v)
              if β ≤ α
                  break (* β cut-off *)
          return v
      else
          v := ∞
          for each child of node
              v := min(v, alphabeta(child, depth - 1, α, β, TRUE))
              β := min(β, v)
              if β ≤ α
                  break (* α cut-off *)
          return v   
    
end
]]


function minmax(curstate,player)
  if finished(curstate) then
    return eval(curstate)
  end  	
  if player==1 then
  	value=-10000
  	for i=1,6 do
		for j=1,6 do
			if curstate[i][j]==0 then
				temp=minmax(move(curstate,i,j,1,2),2)
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
				temp=minmax(move(curstate,i,j,2,1),1)
				if temp<value then
					value=temp
			    end		
			end
	    end
	end
    return value
  end  
end

function move(curstate,i,j,player,nextplayer)
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
      for y=downy,upy do
        if (curstate[x][y]==player) and (not(x==i) or not(y==j)) then
          isdrop=false
        end
      end
    end
    --get ur enemy's land
    if not(isdrop) then
      for x=downx,upx do
        for y=downy,upy do
          if curstate[x][y]==nextplayer then
            curstate[x][y]=player
          end
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
for i=1,6 do
	zou[i]={}
	for j=1,6 do
      zou[i][j]=0
    end
end

bvalue=minmax(zou,1,1)
print(bvalue)