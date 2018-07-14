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

    // FUNCTION TO LOAD CURRENT REPORT ALONG WITH NEXT AND PREVIOUS REPORTS
    function loadReport(path) {
        let nextURL = null;
        let previousURL = null;
        $.ajax({
            url: path,
            dataType: 'json',
            success: function (current) {
                const report = new Report (current["bander"], current["date"], current["content"], current["birds_of_species"]);
                const currentDate = {current_date_slug: report.formatDate().replace(/\s/g, '')};
                $.ajax({
                    type: "POST",
                    url: '/reports/next_report',
                    data: currentDate,
                    success: function (next) {
                        if (next != null) {
                            const nextReport = new Report (next["bander"], next["date"], next["content"], next["birds_of_species"]);
                            nextURL = nextReport.createURL();
                        }
                        $.ajax({
                            type: "POST",
                            url: '/reports/previous_report',
                            data: currentDate,
                            success: function (previous) {
                                if (previous != null) {
                                    const previousReport = new Report (previous["bander"], previous["date"], previous["content"], previous["birds_of_species"]);
                                    previousURL = previousReport.createURL();
                                }
                                report.renderReport(nextURL, previousURL);
                            }
                        })
                    }
                });
            }
        });
    };


    // CLICK EVENT FOR 'NEXT' LINK
    $("div.js-body").on("click", ".js-next", function(e){
        loadReport(this.href);
        e.preventDefault();

    })

    // CLICK EVENT FOR 'PREVIOUS' LINK
    $("div.js-body").on("click", ".js-previous", function(e){
        loadReport(this.href);
        e.preventDefault();

    })

    // CLICK EVENT FOR 'RETURN HOME' LINK
    $("div.js-body").on("click", ".js-return", function(e){
        location.reload();
    })


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

        renderReport(nextURL, previousURL) {
            $('.js-body').html(`<a href="#" class="js-return">Return to home page</a><br><br>`)
            $('.js-body').append(`<h1>Report for: <span id="posted_date">${(this.formatDate())}</span></h1>`);
            $('.js-body').append(`<h3>Posted by: ${this.bander.name}</h3>`);
            if(this.content != null) {
                $('.js-body').append(`<p>${(this.content)}</p>`);
            }
            $('.js-body').append(`<h2>Birds Banded:</h2>`);
            $('.js-body').append(`<table class="display"><tr id="header_row"><th>Alpha Code</th><th>Species Name</th><th>Number Banded</th></tr>`);

            this.birdsOfSpecies.forEach(function(bos){
                $('table.display').append(`<tr><td>${(bos["species"]["code"])}</td><td>${(bos["species"]["name"])}</td><td>${(bos["number_banded"])}</td></tr>`);
            })
            
            $('.js-body').append(`</table><br>`);
            if (nextURL != null) {
                $('.js-body').append(`<p><a href="${nextURL}" class="js-next">Next Report -></a></p>`);
            }

            if (previousURL != null) {
                $('.js-body').append(`<p><a href="${previousURL}" class="js-previous"><- Previous Report</a></p>`);
            }
        }
    }
});
