$(function() {

    // REPORTS/ADD_BIRDS.HTML.ERB
    $("input[value='Add More']").on("click", function(e) {
        data = {
            'authenticity_token': $("input[name = 'authenticity_token']").val(),
            'birds_of_species': {
                'report_id': $("#birds_of_species_report_id").val(),
                'bander_id': $("#birds_of_species_bander_id").val(),
                'number_banded': $("#birds_of_species_number_banded").val(),
                'species_attributes': {
                    'code': $("#birds_of_species_species_code").val(), 
                    'name': $("#birds_of_species_species_name").val()
                }, 
            }
        }
        $.ajax({
            type: "POST",
            url: this.form.action,
            data: data, 
            success: function(response) {
                $("#birds_of_species_species_code").val("")
                $("#birds_of_species_species_name").val("")
                $("#birds_of_species_number_banded").val("")
                $("tr:last-child").before(response);
                $("#birds_of_species_species_code").focus()
            }
        })
        e.preventDefault();
    });

});