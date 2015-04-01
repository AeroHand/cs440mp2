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

getFile("Narvik.txt")
