$(function() {

    $("a.load_reports").on("click", function(e){
        $.ajax({
            url: this.href,
            dataType: 'script'
        })
        e.preventDefault();
    })

    $("div.posted_reports").on("click", "a.load_report", function(e){
        $.ajax({
            url: this.href,
            dataType: 'script'
        })
        e.preventDefault();
    })


});

