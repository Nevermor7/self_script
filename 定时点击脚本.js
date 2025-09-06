var href = "javascript:OUT.user.getTeamPointGift(5);";
var lq = $("a[href$='" + href + "']")[0];

var targetTime = new Date(2025, 7, 8, 3, 0, 0, 0).getTime();

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function run() {
    lq.click();
}

while (true) {
  var nowTime = new Date().getTime();
  console.log("循环中...");
  if (nowTime >= targetTime) {
      lq.click();
      console.log("点击时间戳：" + nowTime);
      console.log("目标时间戳：" + targetTime);
      break;
    }
}