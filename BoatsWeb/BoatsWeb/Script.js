var is24Hour = new Date().toLocaleString().toUpperCase().indexOf("M") == -1

function convertTo24Hour(time) {
    var b = time.getElementsByTagName("b")
    if (b.length != 6) {
        return
    }
    var hour = parseInt(b[0].innerHTML.toString() + b[1].innerHTML.toString())
    if (hour == 12) {
        hour = 0
    }
    if (b[5].innerHTML == ".") {
        hour += 12
        b[5].innerHTML = " "
    }
    hour = hour.toString()
    if (hour.length == 1) {
        hour = "0" + hour
    }
    b[0].innerHTML = hour.charAt(0)
    b[1].innerHTML = hour.charAt(1)
}

if (is24Hour) {
    var times = document.getElementsByTagName("time")
    for (var i = 0; i < times.length; i++ ) {
        convertTo24Hour(times[i])
    }
}
