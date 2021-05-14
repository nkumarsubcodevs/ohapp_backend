$(document).ready(function() 
{
    $('.griddatabtn').click(function (e) 
	{
        e.preventDefault(); 

        var pattern_grid_id = $(this).val();

        $.ajax({
            type: "POST",
            beforeSend: function () { },
            url: '/patterns/update_gridbox',
            dataType: "JSON",
            data: $("#gridform").serialize(),
            success: function (data) 
            {
                if (data.status == 200) 
                {
                    $('#gridform')[0].reset();
                    window.location.reload();
                }
                else
                {
                    $('#popboxmsg').html('<div class="alert alert-danger">'+data.message+'</div>');
                }
            },
            error: function (e) {
            }
        });

    });

    $('.rowgriddatabtn').click(function (e) 
	{
        e.preventDefault(); 

        $.ajax({
            type: "POST",
            beforeSend: function () { },
            url: '/patterns/update_rowinstruction',
            dataType: "JSON",
            data: $("#rowinst").serialize(),
            success: function (data) 
            {
                if (data.status == 200) 
                {
                    window.location.reload();
                }
                else
                {
                    $('#rowpopboxmsg').html('<div class="alert alert-danger">'+data.message+'</div>');
                }
            },
            error: function (e) {
            }
        });
    });

});		


function openinstruction(pattern_id, row_id)
{
   $("#pattern_id").val(pattern_id);
   $("#row_id").val(row_id);
   $("#row-instructions").modal("toggle");
}

