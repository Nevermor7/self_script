var href = "javascript:OUT.user.getTeamPointGift(22);";
var lq = $("a[href$='" + href + "']")[0];
function run() {
    lq.click();
}
setInterval(run, 200);