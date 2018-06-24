$(function() {
    $("a.load_reports").on("click", function(e){
        $.ajax({
            url: this.href,
            dataType: 'script'
        })
        e.preventDefault();
    })

});