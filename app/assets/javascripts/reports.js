$(function() {

    // REPORTS/ADD_BIRDS.HTML.ERB
    $("input[value='Add More']").on("click", function(e) {
        $.ajax({
            type: "POST",
            url: this.form.action,
            data: $(this.form).serialize()
        }).success(function(response){
            $("#birds_of_species_species_code").val("");
            $("#birds_of_species_species_name").val("");
            $("#birds_of_species_number_banded").val("");
            $("tr:last-child").before(`<tr><td>${response["species"]["code"]}</td><td>${response["species"]["name"]}</td><td>${response["number_banded"]}</td></tr>`)
        })
        $("#birds_of_species_species_code").focus();

        e.preventDefault();
    });

});