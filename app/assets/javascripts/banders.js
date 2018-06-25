$(function() {

    $("div.posted_reports").on("click", "a.load_target", function(e){
        $.ajax({
            url: this.href,
            dataType: 'script'
        })
        e.preventDefault();
    })


});

