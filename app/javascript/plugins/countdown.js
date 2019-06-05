if(!(document.getElementsByClassName("screen")[0] == undefined)) {
  setInterval(function() {
    var remain = document.getElementsByClassName("remain")[0].innerHTML
    var clock = document.getElementsByClassName("clock")[0].lastElementChild.className
    xhr_object = new XMLHttpRequest();
    xhr_object.open("GET", location, true);
    xhr_object.onreadystatechange = function() {
    if(xhr_object.readyState == 4 && (!xhr_object.responseText.includes(remain) || !xhr_object.responseText.includes(document.getElementsByClassName("clock")[0].lastElementChild.className))) document.location.reload(true);
    }
    xhr_object.send(null);
  }, 1000)
}

// Set the date we're counting down to
var count = document.getElementsByClassName("time-data")[0].dataset.url
var countDownDate = new Date(count).getTime();

// Clock Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // Output the result in an element with id="demo"
  const countdown = document.getElementById("countdown")
  if (countdown) {
    if (minutes > 9 && seconds > 9) {
      countdown.innerHTML = minutes + ":" + seconds;
    } else if (minutes > 9 && seconds <= 9) {
      countdown.innerHTML = minutes + ":" + "0" + seconds;
    } else if (minutes <= 9 && seconds > 9) {
      countdown.innerHTML = "0" + minutes + ":" + seconds;
    } else {
      countdown.innerHTML = "0" + minutes + ":" + "0" + seconds;
    }
  }

  if (countdown && (countdown.innerHTML == "0-1:0-2" || countdown.innerHTML == "0-1:0-1" || countdown.innerHTML == "0-1:0-3")) {
    countdown.classList.add("black");
  }

  if (distance < 1000) {
    clearInterval(x);
    document.location.reload(true);
  }
  }, 1000);

// Next Break
if(!(document.getElementsByClassName("screen")[0] == undefined)) {
  var nextBreak = document.getElementsByClassName("next-break")[0].dataset.url;
  var breakDownDate = new Date(nextBreak).getTime();
}

var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = breakDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // Output the result in an element with id="demo"
  const breakdown = document.getElementById("breakdown")
  if (breakdown) {
    if (minutes > 9 && seconds > 9) {
      breakdown.innerHTML = "0" + hours + ":" + minutes + ":" + seconds;
    } else if (minutes > 9 && seconds <= 9) {
      breakdown.innerHTML = "0" + hours + ":" + minutes + ":" + "0" + seconds;
    } else if (minutes <= 9 && seconds > 9) {
      breakdown.innerHTML = "0" + hours + ":" + "0" + minutes + ":" + seconds;
    } else {
      breakdown.innerHTML = "0" + hours + ":" + "0" + minutes + ":" + "0" + seconds;
    }
  }

  // if (distance < 1000) {
  //   clearInterval(x);
  //   document.location.reload(true);
  // }
  }, 1000);
