$(function() {

    // $("input[value='Continue']").on("click", function(e) {
    //     data = {
    //         'authenticity_token': $("input[name = 'authenticity_token']").val(),
    //         'report': {
    //             'date': $("#report_date").val(), 
    //             'bander_id': $("#report_birds_of_species_attributes_0_bander_id").val(),
    //         }
    //     }
    //     $.ajax({
    //         method: "POST",
    //         url: this.form.action,
    //         data: data, 
    //         success: function(response) {
    //             $("#form_body").text(response);
    //         }
    //     })
    //     e.preventDefault();
    // });


    $("input[value='Add More']").on("click", function(e) {
        data = {
            'authenticity_token': $("input[name = 'authenticity_token']").val(),
            'report': {
                'date': $("#report_date").val(), 
                'bander_id': $("#report_birds_of_species_attributes_0_bander_id").val(),
                'birds_of_species_attributes': {
                    '0': {
                        'bander_id': $("#report_birds_of_species_attributes_0_bander_id").val(),
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
            method: "PATCH",
            url: this.form.action, // /banders/:slug/reports/:dateslug => bander_report_path
            data: data, 
            success: function(response) {
                $("tr:last-child").before(response);
            }
        })
        e.preventDefault();
    });

});