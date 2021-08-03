-- params : ...
-- function num : 0 , upvalues : _ENV
local FairyUIUtils = {}
local FindComponent = function(gcomponent, childName, ...)
  -- function num : 0_0 , upvalues : FindComponent
  local child = nil
  if gcomponent then
    local numChildren = gcomponent.numChildren
    if numChildren then
      for i = 0, numChildren - 1 do
        if gcomponent.GetChildAt then
          child = gcomponent:GetChildAt(i)
          if child.name == childName then
            return child
          else
            child = FindComponent(child, childName)
          end
        end
      end
    end
  end
  do
    return child
  end
end

local FindLoader = function(gcomponent, childName, ...)
  -- function num : 0_1 , upvalues : FindComponent
  local child = FindComponent(gcomponent, childName)
  if child then
    return child.asLoader
  end
end

local FindText = function(gcomponent, childName, ...)
  -- function num : 0_2 , upvalues : FindComponent
  local child = FindComponent(gcomponent, childName)
  if child then
    return child.asTextField
  end
end

local FindImage = function(gcomponent, childName, ...)
  -- function num : 0_3 , upvalues : FindComponent
  local child = FindComponent(gcomponent, childName)
  if child then
    return child.asImage
  end
end

FairyUIUtils.FindText = FindText
FairyUIUtils.FindImage = FindImage
FairyUIUtils.FindLoader = FindLoader
FairyUIUtils.FindComponent = FindComponent
return FairyUIUtils

