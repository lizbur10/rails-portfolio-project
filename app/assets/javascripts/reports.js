$(function() {

    // REPORTS/ADD_BIRDS.HTML.ERB
    $("input[value='Add More']").on("click", function(e) {
        $.ajax({
            type: "POST",
            url: this.form.action,
            data: $(this.form).serialize(),
            dataType: 'script'
        })
        e.preventDefault();
    });

});