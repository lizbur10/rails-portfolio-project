$(function() {
    $("a.load_reports").on("click", function(e){
        $.get(this.href).success(function(response) {
            $("div.posted_reports").html(response);
        })
        e.preventDefault();
    })

});