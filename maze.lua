maze={}
maze[1]={0,0,0,0}
maze[2]={1,0,0,0}
maze[3]={0,0,1,0}
maze[4]={0,0,0,0}
--随便写的迷宫 左下角出发 最简单的深搜
function deepprint(curmaze)
  for i=1,4 do
    local temp=""
    for j=1,4 do
      temp=temp..tostring(curmaze[i][j]).." "
    end
    print(temp)
  end
  print()
end 
function deepcopy(a)
  return {{unpack(a[1])},{unpack(a[2])},{unpack(a[3])},{unpack(a[4])}}
end
function step(xmaze,i,j)
  local curmaze=deepcopy(xmaze)
  if curmaze[i][j]==0 then
    curmaze[i][j]=1 --标记为走过
    deepprint(curmaze)
    if i<4 then
      step(curmaze,i+1,j)
    end
    if j<4 then
      step(curmaze,i,j+1)
    end
  else
    return
  end
end 
step(maze,1,1)