function gc = getGraphClass(obj)
if isHG2
  gc = lower(obj.Type);
else
  gc = lower(get(obj,'Type'));
end
end
