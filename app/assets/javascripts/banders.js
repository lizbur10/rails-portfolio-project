$(function() {

    // RETRIEVE LIST OF POSTED REPORTS
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
        })
        e.preventDefault();
    })

    // DISPLAY CLICKED REPORT
    $("div.posted_reports").on("click", "a.js-load_report", function(e){
        const path = this.href.replace('http://localhost:3000','');
        loadReport(path);
        e.preventDefault();
    })

    // FUNCTION TO GET NEXT REPORT URL
    function getNextURL(data) {
        $.ajax({
            type: "POST",
            url: '/reports/next_report',
            data: data
        }).success(function(nextReport){
            const report = new Report (nextReport["bander"], nextReport["date"], nextReport["content"], nextReport["birds_of_species"]);
            console.log(report.createURL());
            return report.createURL();
        });
    }

    // FUNCTION TO GET PREVIOUS REPORT URL
    function getPreviousURL(data) {
        $.ajax({
            type: "POST",
            url: '/reports/previous_report',
            data: data
        }).success(function(previousDate){
            if (previousDate != null) {
                return `/reports/${previousDate["date"]}`;
            }
        }).error(function(){
            return null;
        });
    }

    // CLICK EVENT FOR 'NEXT' LINK
    $("div.js-body").on("click", ".js-next", function(e){

        e.preventDefault();

    })

    // CLICK EVENT FOR 'PREVIOUS' LINK
    $("div.js-body").on("click", ".js-previous", function(e){


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
        constructor(bander, date, content, birdsOfSpecies) {
            this.bander = bander;
            this.date = date;
            this.content = content;
            this.birdsOfSpecies = birdsOfSpecies;
        }

        formatDate() {
            return $.format.date(this.date, "MMM dd");
        }

        createURL() {
            let datePortion = this.formatDate().replace(/\s/g, '');
            return '/reports/' + datePortion;
        }

        renderReport() {
            const data = {current_date_slug: report.formatDate().replace(/\s/g, '')};
            const nextURL = getNextURL(data);
            console.log('Next URL:', nextURL);

            $('.js-body').html(`<a href="#" class="js-return">Return to home page</a><br><br>`)
            $('.js-body').append(`<h1>Report for: <span id="posted_date">${(report.formatDate())}</span></h1>`);
            $('.js-body').append(`<h3>Posted by: ${report.bander.name}</h3>`);
            if(report.content != null) {
                $('.js-body').append(`<p>${(report.content)}</p>`);
            }
            $('.js-body').append(`<h2>Birds Banded:</h2>`);
            $('.js-body').append(`<table class="display"><tr id="header_row"><th>Alpha Code</th><th>Species Name</th><th>Number Banded</th></tr>`);

            report.birdsOfSpecies.forEach(function(bos){
                $('table.display').append(`<tr><td>${(bos["species"]["code"])}</td><td>${(bos["species"]["name"])}</td><td>${(bos["number_banded"])}</td></tr>`);
            })
            
            $('.js-body').append(`</table><br>`);
            // const previousURL = getPreviousURL(data);
            if (nextURL != null) {
                $('.js-body').append(`<p><a href="#" class="js-next">Next Report -></a></p>`);
            }

            // if (previousURL != null) {
            //     $('.js-body').append(`<p><a href="#" class="js-previous"><- Previous Report</a></p>`);
            // }
        }
    }
});
