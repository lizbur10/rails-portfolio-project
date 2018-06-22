$(function() {
    $("a.load_reports").on("click", function(e){
        $.ajax({
            method: "GET",
            url: this.href 
        }).done(function (data) {

            console.log(data);
        })
        e.preventDefault();
    })

});