--
-- Copyright (c) 2016 by Aegis Computing. All Rights Reserved.
--


// Do even try it you sneeky asshole.
net.Receive("playerjoinedAddChat", function()
  chat.AddText(unpack(net.ReadTable()))
end)
