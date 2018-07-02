$(function() {
    const report_urls = [];
    // LOAD LIST OF REPORTS
    $("div.posted_reports").on("click", "a.js-load_posted_list", function(e){
        $.ajax({
            url: this.href, // banders/Liz/reports
            dataType: 'script' // views/reports/index.js.erb -> _report_list.html.erb
        }).then(function(){
            elements = $(".js-load_report"); 
            elements.each(function(){
                report_urls.push($(this).attr("href")) 
            })
        }).then(function(){
            url = report_urls.shift();
            $.ajax({
                url: url, // reports/:id
                dataType: 'script' // views/reports/show.js.erb -> _posted_report
            })
    
        })
        e.preventDefault();
    })

    // CLICK EVENT FOR 'NEXT' LINK
    $("div.posted_reports").on("click", ".js-next", function(e){

        // ADD IF STATEMENT TO CONTROL FOR LAST REPORT
        let new_url = report_urls.shift();
        $.ajax({
            url: new_url, // reports/:id
            dataType: 'script' // views/reports/show.js.erb -> _posted_report
        })
        e.preventDefault();

    })

});

