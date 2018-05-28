$(function() {

    $("input[value='Continue']").on("click", function(e) {
        data = {
            'authenticity_token': $("input[name = 'authenticity_token']").val(),
            'report': {
                'date': "2018-05-27", 
                'birds_of_species_attributes': {
                    '0': {
                        'bander_id': "7", //HARD CODED FOR NOW
                        'species_attributes': {
                            'code': $("#report_birds_of_species_attributes_0_species_attributes_code").val(), 
                            'name': $("#report_birds_of_species_attributes_0_species_attributes_name").val()
                        }, 
                        'number_banded': $("#report_birds_of_species_attributes_0_number_banded").val()
                    }
                }
            }
        }
        $.ajax({
            method: "POST",
            url: this.form.action,
            data: data, 
            success: function(response) {
                debugger;
            }
        })
        e.preventDefault();
    });

});