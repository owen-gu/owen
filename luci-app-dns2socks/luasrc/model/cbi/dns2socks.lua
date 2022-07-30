--[[
--dns2socks configuration page. 
--
]]--

local fs = require "nixio.fs"

local state_msg = ""
local dns2socks_on = (luci.sys.call("pidof dns2socks > /dev/null") == 0)
if dns2socks_on then	
	state_msg = "<b><font color=\"green\">" .. translate("Running") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"end

m = Map("dns2socks", translate("DNS2Socks"),
        translatef("DNS2SOCKS is a command line utility running to forward DNS requests to a DNS server via a SOCKS tunnel.").. " - " .. state_msg)

s = m:section(TypedSection, "dns2socks", translate("Settings"))
s.anonymous = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

socksserver = s:option(Value, "socksserver", translate("Socks Server IP Address"))
socksserver.optional = false

socksport = s:option(Value, "socksport", translate("Socks Server Port"))
socksport.datatype = "range(0,65535)"
socksport.optional = false

dnsserver = s:option(Value, "dnsserver", translate("DNS Server IP Address"))
dnsserver.optional = false

localip = s:option(Value, "localip", translate("Local IP Address"))
localip.optional = false

localport = s:option(Value, "localport", translate("Local Port"))
localport.datatype = "range(0,65535)"
localport.optional = false


return m


