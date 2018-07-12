$(function() {
    const report_urls = [];
    let index = 0;

    // RETRIEVE LIST OF POSTED REPORTS AND POPULATE THE ARRAY OF URL'S
    $("div.posted_reports").on("click", "a.js-load_posted_list", function(e){
        $.ajax({
            url: this.href, // reports#posted_reports
            dataType: 'json'
        }).success(function(json){
            $('.posted_reports').html(`<li><h2>Your Posted Reports</h2></li>`);
            $('.posted_reports').append(`<ul>`);
            json.forEach(function(record){
                const report = new Report (record["bander"], record["date"], record["content"], record["birds_of_species"]);
                $('.posted_reports ul').append(`<li><h3><a class="js-load_report" href="${report.createURL()}">${(report.formatDate())}</a></h3></li>`);
            })
            $('.posted_reports').append(`</ul>`);
        }).then(function(){
            // save the list of reports to use for next/previous functions
            const elements = $(".js-load_report"); 
            elements.each(function(){
                report_urls.push($(this).attr("href")) 
            })
        })
        e.preventDefault();
    })

    // DISPLAY CLICKED REPORT
    $("div.posted_reports").on("click", "a.js-load_report", function(e){
        let path = this.href.replace('http://localhost:3000','');
        index = report_urls.indexOf(path);
        loadReport(path);
        e.preventDefault();
    })

    // CLICK EVENT FOR 'NEXT' LINK
    $("div.js-body").on("click", ".js-next", function(e){

        if(index < report_urls.length - 1) {
            index ++;
            const url = report_urls[index];
            loadReport(url);
        }
        e.preventDefault();

    })

    // CLICK EVENT FOR 'PREVIOUS' LINK
    $("div.js-body").on("click", ".js-previous", function(e){

        if(index > 0) {
            index --;
            const url = report_urls[index];
            loadReport(url);
        }
        e.preventDefault();

    })

    // CLICK EVENT FOR 'RETURN HOME' LINK
    $("div.js-body").on("click", ".js-return", function(e){
        location.reload();
    })

    // FUNCTION TO LOAD REPORT
    function loadReport(path) {
        $.ajax({
            url: path,
            dataType: 'json'
        }).success(function(json){ 
            report = new Report (json["bander"], json["date"], json["content"], json["birds_of_species"]);
            report.renderReport();

        })
    }


    // DEFINE REPORT CLASS AND METHODS
    class Report {
        constructor(bander, date, content, birds_of_species) {
            this.bander = bander;
            this.date = date;
            this.content = content;
            this.birds_of_species = birds_of_species;
        }

        formatDate() {
            return $.format.date(this.date, "MMM dd");
        }

        createURL() {
            let datePortion = this.formatDate().replace(/\s/g, '');
            return '/reports/' + datePortion;
        }

        renderReport() {
            $('.js-body').html(`<a href="#" class="js-return">Return to home page</a><br><br>`)
            $('.js-body').append(`<h1>Report for: ${(report.formatDate())}</h1>`);
            $('.js-body').append(`<h3>Posted by: ${report.bander.name}</h3>`);
            if(report.content != null) {
                $('.js-body').append(`<p>${(report.content)}</p>`);
            }
            $('.js-body').append(`<h2>Birds Banded:</h2>`);
            $('.js-body').append(`<table class="display"><tr id="header_row"><th>Alpha Code</th><th>Species Name</th><th>Number Banded</th></tr>`);

            report.birds_of_species.forEach(function(bos){
                $('table.display').append(`<tr><td>${(bos["species"]["code"])}</td><td>${(bos["species"]["name"])}</td><td>${(bos["number_banded"])}</td></tr>`);
            })
            $('.js-body').append(`</table><br>`);
            if (index > 0) {
                $('.js-body').append(`<p><a href="#" class="js-previous"><- Previous Report</a></p>`);
            }
            if (index < report_urls.length - 1) {
                $('.js-body').append(`<p><a href="#" class="js-next">Next Report -></a></p>`);

            }

        }
    }
});
