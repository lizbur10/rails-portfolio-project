$(function() {

    $("div.posted_reports").on("click", "a.js-load_posted_list", function(e){
        $.ajax({
            url: this.href,
            dataType: 'script' // views/reports/index.js.erb -> _report_list.html.erb
        })
        e.preventDefault();
    })

    // SEPARATE THIS BACK OUT INTO LOAD_REPORT_LIST AND LOAD_REPORT - ADD 'JS-' PREFIX TO JS LINK CLASSES
    $("div.posted_reports").on("click", "a.js-load_report", function(e){

        $.get(this.href).success(function(json){ // json is what is returned 
            report = new Report (json["date"], json["content"]);
            debugger;
            // json.first(function(report){
            //     $div.append("to be filled in")
            // })
        })
        e.preventDefault();
    })

    // ADD CLICK EVENT FOR NEXT LINK
    // TO FIGURE OUT WHAT THE NEXT ONE IS - CREATE AN ARRAY WITH JUST THE EXISTING ID#S. START WITH [0] AND INCREMENT EACH TIME NEXT IS CLICKED
    // THIS CODE LIFTED FROM USING ACTIVE MODEL SERIALIZER LAB
    $("div.posted_reports").on("click", "a.js-next", function(e){
        var nextId = parseInt($(".js-next").attr("data-id")) + 1;
        $.get("/products/" + nextId + ".json", function(data) {
            $(".productName").text(data["name"]);
            $(".productPrice").text(data["price"]);
            $(".productDescription").text(data["description"]);
            $(".productInventory").text(data["inventory"]);
            // re-set the id to current on the link
            $(".js-next").attr("data-id", data["id"]);
        });
    })

    class Report {
        constructor(date, content) {
            this.date = date;
            this.content = content;
        }

        formatDate() {
            $.format.date(this.date, "MMMdd");
        }
    }
});

