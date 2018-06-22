$(function() {
    $("a.load_reports").on("click", function(e){
        $.ajax({
            method: "GET",
            url: this.href 
        }).done(function (response) {

            $("div.posted_reports").html(response);
        })
        e.preventDefault();
    })

});