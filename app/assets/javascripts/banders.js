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
        }) 

        e.preventDefault();
    })

    // LOAD SINGLE REPORT
    $("div.posted_reports").on("click", "a.js-load_report", function(e){
        report_urls.shift();
        $.ajax({
            url: this.href, // reports/:id
            dataType: 'script' // views/reports/show.js.erb -> _posted_report
        })
        e.preventDefault();
    })

    // ADD CLICK EVENT FOR NEXT LINK
    $("div.posted_reports").on("click", ".js-next", function(e){

        // ADD IF STATEMENT TO CONTROL FOR LAST REPORT
        let new_url = report_urls.shift();
        $.ajax({
            url: new_url, // reports/:id
            dataType: 'script' // views/reports/show.js.erb -> _posted_report
        })
        e.preventDefault();

    })

    // class Report {
    //     constructor(date, content, birds_of_species) {
    //         this.date = date;
    //         this.content = content;
    //         this.birds_of_species = birds_of_species;
    //         this.formatted_date = "";
    //     }

    //     formatDate() {
    //         return $.format.date(this.date, "MMMdd");
    //     }
    // }
});

