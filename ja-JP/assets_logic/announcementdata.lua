-- params : ...
-- function num : 0 , upvalues : _ENV
AnnouncementData = {}
AnnouncementButtonPositionType = {NoButton = "NO", LeftBottom = "LEFT", RightBottom = "RIGHT"}
AnnouncementDataContentType = {Text = 0, Unset = 1, ImageAndBtn = 2, ImageUrl = 3, Questionnaire = 4, Image = 5, Button = 6, ImageBtn = 7, BigImage = 8}
AnnouncementTextFormat = {Normal = 0, Top = 1, Bottom = 2, Both = 3}
AnnouncementDataAlignType = {Left = "left", Right = "right", Center = "center"}
AnnouncementDataBtnType = {NoShow = 0, Normal = 1}
-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.AutoShowAnnouncement = false
-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CONTENT_TITLE_RESOURCE = "Title"
-- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CONTENT_WORD_RESOURCE = "Word"
-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CONTENT_BIG_IMG_RESOURCE = "BigImage"
-- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CONTENT_IMG_RESOURCE = "MiddleImage"
-- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CONTENT_BUTTON_RESOURCE = "Function"
-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.ListData = {}
-- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.ContentData = {}
-- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.RedDot = {}
-- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.RedDotIndex = {}
-- DECOMPILER ERROR at PC66: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.ContentSeparater = {"<p style=\"text%-align: (%a+);\">", "<img .*src.->%[goto=#%d+%].-%[/goto%]", "<img .*src.->%[url=.-%]", "<img .*src.->%[que%].-%[/que%]", "<img .*src.->", "%[goto=#%d+%]"}
-- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.GetAnalyzedContent = function(content, noBtn, ...)
  -- function num : 0_0 , upvalues : _ENV
  local result = {}
  local lastContent = nil
  content = (AnnouncementData.PreAnalyzedContent)(content)
  local contents = split(content, "</p>")
  local count = #contents
  local subContents, subCount, index, eachContent = nil, nil, nil, nil
  for i = 1, count do
    eachContent = contents[i]
    index = eachContent:find("<p>")
    if index ~= nil and index > 1 then
      subContents = split(eachContent, "<p>")
      subCount = #subContents
      for j = 1, subCount do
        lastContent = (AnnouncementData.AnalyzeSingeContent)(subContents[j], noBtn, result, lastContent)
      end
    else
      do
        do
          lastContent = (AnnouncementData.AnalyzeSingeContent)(eachContent, noBtn, result, lastContent)
          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  PrintTable(result)
  return result
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.AnalyzeSingeContent = function(content, noBtn, result, lastContent, ...)
  -- function num : 0_1 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(content) or content == "<br>" then
    return 
  end
  content = (AnnouncementData.RemoveUnusedTag)(content)
  local subStartIndex, subEndIndex, subArg, subContent = nil, nil, nil, nil
  while 1 do
    local startIndex, type, arg = (AnnouncementData.GetNextSeparater)(content)
    if startIndex ~= nil then
      local endIndex = nil
      do
        if startIndex > 1 then
          local prePart = content:sub(1, startIndex - 1)
          if lastContent ~= nil and lastContent.Type == AnnouncementDataContentType.Text and lastContent.Align == AnnouncementDataAlignType.Left then
            lastContent.Text = lastContent.Text .. "\n" .. prePart
          else
            ;
            (table.insert)(result, {Text = prePart, Type = AnnouncementDataContentType.Text, Align = AnnouncementDataAlignType.Left})
          end
          content = content:sub(startIndex)
          startIndex = 1
          lastContent = result[#result]
        end
        if type == AnnouncementDataContentType.Unset then
          subStartIndex = content:find((AnnouncementData.ContentSeparater)[1] .. (AnnouncementData.ContentSeparater)[2])
          -- DECOMPILER ERROR at PC88: Overwrote pending register: R6 in 'AssignReg'

          if subStartIndex ~= nil and subStartIndex == 1 then
            startIndex = content:find("<img .*src=\"(.-)\"")
            ;
            (table.insert)(result, {Img = (AnnouncementData.CheckUrlString)(subArg), Type = AnnouncementDataContentType.BigImage})
            -- DECOMPILER ERROR at PC107: Overwrote pending register: R6 in 'AssignReg'

            -- DECOMPILER ERROR at PC108: Overwrote pending register: R11 in 'AssignReg'

            startIndex = content:find("%[goto=#(%d+)%]")
            if not noBtn then
              (table.insert)(result, {Type = AnnouncementDataContentType.ImageBtn, Align = arg, Goto = tonumber(subArg)})
            end
          else
            subStartIndex = content:find((AnnouncementData.ContentSeparater)[1] .. (AnnouncementData.ContentSeparater)[5])
            -- DECOMPILER ERROR at PC143: Overwrote pending register: R6 in 'AssignReg'

            -- DECOMPILER ERROR at PC144: Overwrote pending register: R11 in 'AssignReg'

            if subStartIndex ~= nil and subStartIndex == 1 then
              startIndex = content:find("%[goto=#(%d+)%]")
              if not noBtn then
                (table.insert)(result, {Type = AnnouncementDataContentType.Button, Align = arg, Goto = tonumber(subArg)})
              end
            else
              startIndex = content:find(">")
              -- DECOMPILER ERROR at PC169: Overwrote pending register: R6 in 'AssignReg'

              -- DECOMPILER ERROR at PC174: Overwrote pending register: R11 in 'AssignReg'

              if lastContent ~= nil and lastContent.Type == AnnouncementDataContentType.Text and lastContent.Align == arg then
                lastContent.Text = lastContent.Text .. "\n" .. subArg
              else
                ;
                (table.insert)(result, {Text = subArg, Type = AnnouncementDataContentType.Text, Align = arg})
              end
            end
          end
          content = content:sub(endIndex + 1)
          lastContent = result[#result]
          break
        end
        -- DECOMPILER ERROR at PC215: Overwrote pending register: R6 in 'AssignReg'

        -- DECOMPILER ERROR at PC216: Overwrote pending register: R11 in 'AssignReg'

        if type == AnnouncementDataContentType.ImageAndBtn then
          startIndex = content:find("<img .*src=\"(.-)\"")
          ;
          (table.insert)(result, {Img = (AnnouncementData.CheckUrlString)(subArg), Type = AnnouncementDataContentType.BigImage})
          -- DECOMPILER ERROR at PC235: Overwrote pending register: R6 in 'AssignReg'

          -- DECOMPILER ERROR at PC236: Overwrote pending register: R11 in 'AssignReg'

          startIndex = content:find("%[goto=#(%d+)%](.-)%[/goto%]")
          loge("subContent:" .. subContent)
          local x, y = nil, nil
          do
            local index1, index2, type = subContent:find("%type=(%d+)")
            if type ~= nil then
              type = tonumber(type)
            end
            index1 = subContent:find("x=(%d+)")
            -- DECOMPILER ERROR at PC263: Overwrote pending register: R15 in 'AssignReg'

            index1 = subContent:find("y=(%d+)")
            if not noBtn then
              (table.insert)(result, {Type = AnnouncementDataContentType.ImageBtn, Align = arg, Goto = tonumber(subArg), 
Offset = {x = tonumber(x), y = tonumber(y)}
, BtnType = type})
            end
            content = content:sub(endIndex + 1)
            lastContent = result[#result]
            do break end
            -- DECOMPILER ERROR at PC298: Overwrote pending register: R12 in 'AssignReg'

            -- DECOMPILER ERROR at PC302: Overwrote pending register: R13 in 'AssignReg'

            -- DECOMPILER ERROR at PC305: Overwrote pending register: R6 in 'AssignReg'

            -- DECOMPILER ERROR at PC306: Overwrote pending register: R11 in 'AssignReg'

            if type == x.Questionnaire then
              startIndex = content:find("<img .*src=\"(.-)\"")
              local img = (AnnouncementData.CheckUrlString)(subArg)
              -- DECOMPILER ERROR at PC313: Overwrote pending register: R15 in 'AssignReg'

              -- DECOMPILER ERROR at PC315: Overwrote pending register: R7 in 'AssignReg'

              -- DECOMPILER ERROR at PC316: Overwrote pending register: R11 in 'AssignReg'

              startIndex = content:find(index2)
              local url, baseUrl, appId, appKey, questionnaireId, arg = nil, nil, nil, nil, nil, nil
              local subContent = split(subContent, ",")
              do
                do
                  local count = #subContent
                  for i = 1, count do
                    -- DECOMPILER ERROR at PC332: Overwrote pending register: R5 in 'AssignReg'

                    subStartIndex = (subContent[i]):find("baseurl=")
                    if subStartIndex ~= nil then
                      baseUrl = (subContent[i]):sub(subEndIndex + 1)
                    else
                      -- DECOMPILER ERROR at PC346: Overwrote pending register: R5 in 'AssignReg'

                      subStartIndex = (subContent[i]):find("url=")
                      if subStartIndex ~= nil then
                        url = (subContent[i]):sub(subEndIndex + 1)
                      else
                        -- DECOMPILER ERROR at PC360: Overwrote pending register: R5 in 'AssignReg'

                        subStartIndex = (subContent[i]):find("appid=")
                        if subStartIndex ~= nil then
                          appId = (subContent[i]):sub(subEndIndex + 1)
                        else
                          -- DECOMPILER ERROR at PC374: Overwrote pending register: R5 in 'AssignReg'

                          subStartIndex = (subContent[i]):find("appkey=")
                          if subStartIndex ~= nil then
                            appKey = (subContent[i]):sub(subEndIndex + 1)
                          else
                            -- DECOMPILER ERROR at PC388: Overwrote pending register: R5 in 'AssignReg'

                            subStartIndex = (subContent[i]):find("id=")
                            if subStartIndex ~= nil then
                              questionnaireId = (subContent[i]):sub(subEndIndex + 1)
                            end
                          end
                        end
                      end
                    end
                  end
                  ;
                  (table.insert)(result, {Type = AnnouncementDataContentType.Questionnaire, Img = img, AppId = appId, Url = url, BaseUrl = baseUrl, AppKey = appKey, QuestionnaireId = questionnaireId, Login = not noBtn})
                  content = content:sub(endIndex + 1)
                  lastContent = result[#result]
                  do break end
                  -- DECOMPILER ERROR at PC429: Overwrote pending register: R11 in 'AssignReg'

                  if type == AnnouncementDataContentType.Image then
                    startIndex = content:find("<img .*src=\"(.-)\"")
                    ;
                    (table.insert)(result, {Img = (AnnouncementData.CheckUrlString)(arg), Type = AnnouncementDataContentType.Image})
                    -- DECOMPILER ERROR at PC448: Overwrote pending register: R11 in 'AssignReg'

                    startIndex = content:find(">", startIndex)
                    content = content:sub(endIndex + 1)
                    lastContent = result[#result]
                    break
                  end
                  -- DECOMPILER ERROR at PC464: Overwrote pending register: R6 in 'AssignReg'

                  -- DECOMPILER ERROR at PC465: Overwrote pending register: R11 in 'AssignReg'

                  if type == AnnouncementDataContentType.Button then
                    startIndex = content:find("%[goto=#(%d+)%]")
                    if not noBtn then
                      (table.insert)(result, {Type = AnnouncementDataContentType.Button, Align = arg, Goto = tonumber(subArg)})
                    end
                    content = content:sub(endIndex + 1)
                    lastContent = result[#result]
                    break
                  end
                  -- DECOMPILER ERROR at PC496: Overwrote pending register: R6 in 'AssignReg'

                  -- DECOMPILER ERROR at PC497: Overwrote pending register: R11 in 'AssignReg'

                  if type == AnnouncementDataContentType.ImageUrl then
                    startIndex = content:find("<img .*src=\"(.-)\"")
                    local data = {Img = (AnnouncementData.CheckUrlString)(subArg), Type = AnnouncementDataContentType.ImageUrl}
                    -- DECOMPILER ERROR at PC511: Overwrote pending register: R6 in 'AssignReg'

                    -- DECOMPILER ERROR at PC512: Overwrote pending register: R11 in 'AssignReg'

                    startIndex = content:find("%[url=(.-)%]")
                    data.Url = (AnnouncementData.CheckUrlString)(subArg)
                    ;
                    (table.insert)(result, data)
                    content = content:sub(endIndex + 1)
                    lastContent = result[#result]
                  end
                  do break end
                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC531: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC554: Overwrote pending register: R10 in 'AssignReg'

  if (Util.StringIsNullOrEmpty)(content) == false and content ~= "<br>" then
    if lastContent ~= nil and lastContent.Type == AnnouncementDataContentType.Text and lastContent.Align == AnnouncementDataAlignType.Left then
      lastContent.Text = lastContent.Text .. "\n" .. arg
    else
      -- DECOMPILER ERROR at PC563: Overwrote pending register: R11 in 'AssignReg'

      ;
      (table.insert)(result, {Text = content, Type = endIndex.Text, Align = AnnouncementDataAlignType.Left})
    end
    lastContent = result[#result]
  end
  return lastContent
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.RemoveUnusedTag = function(content, ...)
  -- function num : 0_2 , upvalues : _ENV
  content = (AnnouncementData.DealPLabel)(content)
  local brIndex = content:find("<br>")
  if brIndex == (string.len)(content) - 3 then
    content = content:sub(1, -5)
  end
  content = content:gsub("<span .-><br></span>", "\n")
  local spanPart = nil
  while 1 do
    spanPart = content:match("<span .->")
    if spanPart ~= nil then
      spanPart = (AnnouncementData.UnifyHtmlString1)(spanPart)
      content = content:gsub(spanPart, "")
      -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  content = content:gsub("</span>", "")
  local hrefPart = content:match("<a href=.->")
  if hrefPart ~= nil then
    hrefPart = (AnnouncementData.UnifyHtmlString1)(hrefPart)
    content = content:gsub(hrefPart, "")
    content = content:gsub("</a>", "")
  end
  return content
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.PreAnalyzedContent = function(content, ...)
  -- function num : 0_3 , upvalues : _ENV
  loge("origin:" .. content)
  content = content:gsub("\\n", "\n")
  content = content:gsub("&nbsp;", "")
  content = content:gsub("<style>.-</style>", "")
  content = content:gsub("<p><br>", "\n")
  local index, subStr1, subStr2 = nil, nil, nil
  local t = 0
  while 1 do
    subStr1 = content:match("%b<><img .*src.-></.->")
    t = t + 1
    if t < 100 and subStr1 ~= nil then
      index = subStr1:find("/")
      if index ~= 2 then
        subStr1 = (AnnouncementData.UnifyHtmlString1)(subStr1, true)
        subStr2 = subStr1:match("<img .*src.->")
        subStr2 = (AnnouncementData.UnifyHtmlString2)(subStr2, true)
        content = content:gsub(subStr1, subStr2)
        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  content = content:gsub("<li>", "")
  content = content:gsub("</li>", "")
  loge("Dealed:" .. content)
  return content
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.DealPLabel = function(content, ...)
  -- function num : 0_4
  local subStartIndex, subEndIndex = content:find("<p>.+")
  if subStartIndex == 1 then
    content = content:sub(4)
  end
  subStartIndex = content:find(".+</p>")
  if subEndIndex == content:len() then
    content = content:sub(1, -5)
  end
  return content
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.UnifyHtmlString1 = function(content, ...)
  -- function num : 0_5 , upvalues : _ENV
  if not (Util.StringIsNullOrEmpty)(content) then
    content = content:gsub("%%", "%%%%")
    content = content:gsub("%(", "%%(")
    content = content:gsub("%)", "%%)")
    content = content:gsub("-", "%%-")
  end
  return content
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.UnifyHtmlString2 = function(content, ...)
  -- function num : 0_6 , upvalues : _ENV
  if not (Util.StringIsNullOrEmpty)(content) then
    content = content:gsub("%%", "%%%%")
    content = content:gsub("%(", "%%%%(")
    content = content:gsub("%)", "%%%%)")
    content = content:gsub("-", "%%%%-")
  end
  return content
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.CheckUrlString = function(content, ...)
  -- function num : 0_7
  content = content:gsub("%%%%%-", "-")
  return content
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.SetTextFormat = function(last, current, ...)
  -- function num : 0_8 , upvalues : _ENV
  if last ~= nil and last.Type == AnnouncementDataContentType.Text and current.Type == AnnouncementDataContentType.Text then
    if last.Format == AnnouncementTextFormat.Top then
      last.Format = AnnouncementTextFormat.Both
    else
      last.Format = AnnouncementTextFormat.Bottom
    end
    current.Format = AnnouncementTextFormat.Top
  end
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.GetNextSeparater = function(content, ...)
  -- function num : 0_9 , upvalues : _ENV
  local result = {}
  local count = #AnnouncementData.ContentSeparater
  local start, finish, arg, type = nil, nil, nil, nil
  for i = 1, count do
    start = content:find((AnnouncementData.ContentSeparater)[i])
    result[i] = {StartIndex = start, Type = i, Arg = arg}
  end
  local set = function(index, ...)
    -- function num : 0_9_0 , upvalues : start, result, type, arg
    start = (result[index]).StartIndex
    type = (result[index]).Type
    arg = (result[index]).Arg
  end

  count = #result
  start = nil
  for i = 1, count do
    if start == nil then
      set(i)
    else
      if (result[i]).StartIndex ~= nil and (result[i]).StartIndex < start then
        set(i)
      end
    end
  end
  return start, type, arg
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementData.GetQuestionnaireUrl = function(data, ...)
  -- function num : 0_10 , upvalues : _ENV
  local content = (string.format)("app_id=%d&qn_id=%d&role_id=%s&role_name=%s&server_id=%d&server_name=%s&timeline=%d", data.AppId, data.QuestionnaireId, (ActorData.GetPlayerIndex)(), (ActorData.GetNickName)(), LoginMgr.curServerId, LoginMgr.curServerId, (LuaTime.GetTimeStamp)())
  local md5 = content .. data.AppKey
  md5 = ((CS.MD5Util).Hash)(md5)
  content = content .. "&sign=" .. md5
  content = (Util.EncodeBase64)(content)
  content = (Util.EncodeURI)(content)
  content = data.BaseUrl .. content
  return content
end


