--
-- Copyright (c) 2016 by Aegis Computing. All Rights Reserved.
--
// Yes, the copyright is shitty but it protects my work. So there's that.


// Don't even try it, you sneaky asshole.
net.Receive("playerjoinedAddChat", function()
  chat.AddText(unpack(net.ReadTable()))
end)

// Don't even try it, you sneaky asshole.
net.Receive("playerjoinedAddConsole", function()
  MsgC(unpack(net.ReadTable()))
  MsgN()
end)
