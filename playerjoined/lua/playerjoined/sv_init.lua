--
-- Copyright (c) 2016 by Aegis Computing. All Rights Reserved.
--

AddCSLuaFile("cl_init.lua")
playerjoined = playerjoined or {}

playerjoined.AdminGroups = {"owner", "staffmanager", "superadmin", "admin", "moderator", "trialmod"} // edit this.

util.AddNetworkString("playerjoinedAddChat")
function playerjoinedAddChat(ply, ...)
  if CLIENT then
    chat.AddText(...)
  else
    if string.lower(ply) == "all" then
      net.Start("playerjoinedAddChat")
        net.WriteTable({...})
      net.Broadcast()
    elseif string.lower(ply) == "staff" then
      for k, v in pairs(playerjoined.AdminGroups) do
        for j, p in pairs(player.GetAll()) do
          if p:GetNWString("usergroup")== v then
              net.Start("playerjoinedAddChat")
                net.WriteTable({...})
              net.Send(p)
        end
      end
    end
    else
      Msg("No arguement for AddChat")
    end
  end
end

function playerJoined_connect(ply, ip)
  playerjoinedAddChat("all", Color(0, 100, 255), "[Server] ", Color(255, 255, 255, 255), ply.." has connected to the server.")
  playerjoinedAddChat("staff", Color(255, 0, 0, 255), "[Admin] ", Color(255, 255, 255, 255), ply.." connected with IP: "..ip)
end
hook.Add("PlayerConnect", "playerjoined_plyconnect", playerJoined_connect)

function playerJoined_plyspawned(ply)
  local name = ply:Nick()
  local id = ply:SteamID()
  local ip = ply:IPAddress()
  playerjoinedAddChat("all", Color(0, 100, 255, 255), "[Server] ", Color(255, 255, 255, 255), name.." has spawned in the server! ("..id..")")
  playerjoinedAddChat("staff", Color(255, 0, 0, 255), "[Admin] ", Color(255, 255, 255, 255), name.." spawned with IP: "..ip.." SteamID: "..id)
end
hook.Add("PlayerInitialSpawn", "playerjoined_plyspawned", playerJoined_plyspawned)

function playerJoined_plydisconnect(ply)
  local name = ply:Nick()
  local id = ply:SteamID()
  local ip = ply:IPAddress()
  playerjoinedAddChat("all", Color(0, 100, 255, 255), "[Server] ", Color(255, 255, 255, 255), name.." has disconnected from the server! ("..id..")")
  playerjoinedAddChat("staff", Color(255, 0, 0, 255), "[Admin] ", Color(255, 255, 255, 255), name.." disconnected with IP: "..ip.." SteamID: "..id)
end
hook.Add("PlayerDisonnected", "playerjoined_plydisconnected", playerJoined_plydisconnect)
