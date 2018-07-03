$(function() {
    const report_urls = [];
    // RETRIEVE LIST OF POSTED REPORTS AND POPULATE THE ARRAY OF URL'S
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

    $("div.posted_reports").on("click", "a.js-load_report", function(e){
        // GET THE URL FOR THE FIRST POSTED REPORT AND DISPLAY IT
        url = report_urls.shift();
        $.ajax({
            url: url,
            dataType: 'json'
        }).success(function(json){ 
            report = new Report (json["date"], json["content"], json["birds_of_species"]);
            report.renderReport();
            debugger;

        })
        e.preventDefault();
    })

    // CLICK EVENT FOR 'NEXT' LINK
    $("div.posted_reports").on("click", ".js-next", function(e){

        if(report_urls.length > 0) {
            url = report_urls.shift();
            $.ajax({
                url: url,
                dataType: 'json'
            }).success(function(json){ // json is what is returned
                report = new Report (json["date"], json["content"], json["birds_of_species"]);
            report.renderReport();
            })
        }
        e.preventDefault();

    })


    class Report {
        constructor(date, content, birds_of_species) {
            this.date = date;
            this.content = content;
            this.birds_of_species = birds_of_species;
        }

        formatDate() {
            return $.format.date(this.date, "MMM dd");
        }

        renderReport() {
            $('.js-body').html(`<h1>Report for: ${(report.formatDate())}</h1>`);
            if(report.content != null) {
                $('.js-body').append(`<p>${(report.content)}</p>`);
            }
            $('.js-body').append(`<h2>Birds Banded:</h2>`);
            // $('.posted_report_view').append(`<table class="display">`);
            $('.js-body').append(`<table class="display"><tr id="header_row"><th>Alpha Code</th><th>Species Name</th><th>Number Banded</th></tr>`);

            report.birds_of_species.forEach(function(bos){
                $('table.display').append(`<tr><td>${(bos["species"]["code"])}</td><td>${(bos["species"]["name"])}</td><td>${(bos["number_banded"])}</td></tr>`);
            })
            $('.js-body').append(`</table><br>`);
            if (report_urls.length > 0) {
                $('.js-body').append(`<a href="#" class="js-next">Next</a>`);

            }

        }
    }
});
