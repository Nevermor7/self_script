var href = "javascript:OUT.user.getTeamPointGift(5);";
var lq = $("a[href$='" + href + "']")[0];
function run() {
    lq.click();
}
setInterval(run, 100);