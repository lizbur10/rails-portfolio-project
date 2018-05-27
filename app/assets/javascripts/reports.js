$(document).ready(function() {

    $("input[value='Continue']").on("click", function(e) {
        alert("You clicked this button");
        e.preventDefault();
    });

});