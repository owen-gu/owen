--[[
ShadowsocksR Luci configuration page.Made by Owen
]]--

module("luci.controller.ssrlocal", package.seeall)

function index()
	
	if not nixio.fs.access("/etc/config/ssrlocal") then
		return
	end

	local page
	page = entry({"admin", "services", "ssrlocal"}, cbi("ssrlocal"), _("ShadowsocksR"), 45)
	page.dependent = true
end
