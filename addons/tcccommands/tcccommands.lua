local tcc = {};

tcc.config = {
    toolTipForItem = false;
    chatDetailsForItem = true;
    debugFlag = true;
};


-- make sure args are strings so we can continue to use substring
function tcc.buildArgStr(args)
    if (type(args) == "string") then
        return args;
    else
        if (type(args) == "table") then
            local argString = " ";
            for i,v in ipairs(args) do
                argString = argString .. tostring(v) .. " ";
            end
            return argString:sub(2,-2);
        end
    end
    
end


--------------------------------------------------------------------------------- Item Info
function tcc.ItemInfoCallback(args)
    
    if tcc.config.debugFlag then
        ui.SysMsg("inside ItemInfoCallback");
    end
    
    local argStr = tcc.buildArgStr(args);
    
    if (string.sub(argStr, 1, 4) == "help") then
        msg = 'iteminfo{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. 'Usage: /iteminfo [item name / help]{nl}'
        msg = msg .. '-----------{nl}';
        msg = msg .. '/iteminfo item name{nl}';
        msg = msg .. 'Displays information about the item specified{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. '/iteminfo help{nl}';
        msg = msg .. 'Shows this window.{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. '/iteminfo can also be used as /ii';
        return ui.MsgBox(msg,"","Nope");
    else
        if tcc.config.debugFlag then
            ui.SysMsg("args: "..argStr);
        end
        
        -- command logic goes here
        
    end
    
end

--------------------------------------------------------------------------------- Monster Info
function tcc.MonsterInfoCallback(args)
    
    if tcc.config.debugFlag then
        ui.SysMsg("inside MonsterInfoCallback");
    end
    
    local argStr = tcc.buildArgStr(args);
    
    if (string.sub(argStr, 1, 4) == "help") then
        msg = 'monsterinfo{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. 'Usage: /monsterinfo [monster name / help]{nl}'
        msg = msg .. '-----------{nl}';
        msg = msg .. '/monsterinfo monster name{nl}';
        msg = msg .. 'Displays information about the monster specified{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. '/monsterinfo help{nl}';
        msg = msg .. 'Shows this window.{nl}';
        msg = msg .. '-----------{nl}';
        msg = msg .. '/monsterinfo can also be used as /mi';
        return ui.MsgBox(msg,"","Nope");
    else
        
        if tcc.config.debugFlag then
            ui.SysMsg("args: "..argStr);
        end
        
        -- command logic goes here
        
    end
    
end


--------------------------------------------------------------------------------- Command Registers

-- brutal hard coding. please use cwAPI or LK so I don't need this...
function tcc.CommandManager(args)
    
    -- hard code item info
    if (string.sub(args, 1, 3) == "/ii") then
        tcc.ItemInfoCallback(string.sub(args,4));
    elseif (string.sub(args, 1, 9) == "/iteminfo") then
        tcc.ItemInfoCallback(string.sub(args,10));
        
    -- hard code monster info
    else
        if (string.sub(args, 1, 3) == "/mi") then
            tcc.MonsterInfoCallback(args,4);
        elseif (string.sub(args, 1, 12) == "/monsterinfo") then
            tcc.MonsterInfoCallback(args,13);
            
        -- not our command, process as usual
        else
            ui.Chat(args);
        end
    end
    
end


-- register with cw first, if not using cw register with lk
if cwAPI then
    _G['ADDON_LOADER']['tcccommands'] = function()
        cwAPI.commands.register('/iteminfo', tcc.ItemInfoCallback);
        cwAPI.commands.register('/ii', tcc.ItemInfoCallback);
        cwAPI.util.log('[iteminfo:help] /iteminfo [item name]');
        
        cwAPI.commands.register('/monsterinfo', tcc.MonsterInfoCallback);
        cwAPI.commands.register('/mi', tcc.MonsterInfoCallback);
        cwAPI.util.log('[monsterinfo:help] /monsterinfo [monster name]');
        
        return true;
    end
    ui.SysMsg("registered with cwAPI");
else
    if LKChat then
        LKChat.RegisterSlash({"iteminfo", "ii"}, tcc.ItemInfoCallback,
            "Displays information about the specified item");
        LKChat.RegisterSlash({"monsterinfo", "mi"}, tcc.MonsterInfoCallback,
            "Displays information about the specified monster");
        
    -- not using any friendly chat override, use my Frankenstein
    else
        ui.SysMsg("Could not find cwAPI or LKChat; registering commands manually...");
        _G["UI_CHAT"] = tcc.CommandManager;
        ui.SysMsg("...please use cwAPI or LK so I don't need this...");
    end
    
    ui.SysMsg("tCc_Commands loaded!");
    
end
