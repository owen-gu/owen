module("luci.controller.timewol", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/timewol") then return end

    entry({"admin", "control"}, firstchild(), "Control", 50).dependent = false
    entry({"admin", "control", "timewol"}, cbi("timewol"), _("定时唤醒"), 95).dependent = true
end


