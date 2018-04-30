<form class='form-horizontal' method='POST' id='type_add_form'>
<input type='hidden' name='index' value='$index'>
<input type='hidden' name='ADDITIONAL_FIELDS' id='additional_fields' value='%ADDITIONAL_FIELDS%'>
  <div class='box box-theme'>
    <div class='box-header with-border'><h3 class='box-title'>Новый тип задачи</h3>
      <div class='box-tools pull-right'>
      <button type='button' class='btn btn-default btn-xs' data-widget='collapse'>
      <i class='fa fa-minus'></i>
        </button>
      </div>
    </div>
    <div class='box-body'>
      <div class='row'>
        <div class='col-md-12 col-xs-12'>

          <div class='form-group'>
            <label class='control-label col-md-4' for='NAME'>Название типа задачи:</label>
            <div class='col-md-8'>
              <input class='form-control' type='text' value='%NAME%' name='NAME' id='NAME'>
            </div>
          </div>

          <div class='form-group'>
            <label class='control-label col-md-4' for='NAME'>Администраторы, которым могут быть поручены задачи этого типа:</label>
            <div class='col-md-8'>
              <input type='hidden' id='RESPOSIBLE_LIST' name='RESPOSIBLE_LIST' value='%RESPOSIBLE_LIST%'>
              <button type='button' class='btn btn-primary pull-left margin' data-toggle='modal' data-target='#myModal' 
                      onClick='return openModal()'>Выбрано: <span class='admin_count'></span></button>
            </div>
          </div>


        </div>
        <div class='col-md-12 col-xs-12'>

          <div class='form-group'>
            <h4>Дополнительные поля:</h4>
          </div>
          <div id='additional_fields_container'>
          </div>
          <div class='col-md-2 col-xs-2'>
            <a title='add field' class='btn bg-olive margin' id='add_field' href='#'><i class='fa fa-plus'></i></a>
          </div>
          
        </div>
      </div>

           <!-- Modal -->
      <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
        
          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">Ответственные</h4>
            </div>
            <div class="modal-body">
             %ADMINS_LIST%
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal" onClick='return closeModal()'>Close</button>
            </div>
          </div>
          
        </div>
      </div>

            <!-- Invisible element for clone-->
      <div class='form-group' style='display: none;' id='blank_element'>
        <div class='col-md-2 col-xs-2'>
          <a title='remove field' class='btn bg-gray margin del_btn' href='#'><i class='fa fa-minus' style='pointer-events: none;'></i></a>
        </div>
        <label class='control-label col-md-2 col-xs-2 margin'>Тип поля:</label>
        <div class='col-md-2 col-xs-2'>
          <input class='form-control field_type margin' type='text'>
        </div>
        <label class='control-label col-md-2 col-xs-2 margin'>Название поля:</label>
        <div class='col-md-2 col-xs-2'>
          <input class='form-control field_name margin' type='text'>
        </div>
      </div>


    </div>
    <div class='box-footer'>
      <input type=submit name='%BTN_ACTION%' value='%BTN_NAME%' class='btn btn-primary'>
    </div>  
  </div>
</form>

<script type='text/javascript'>
  try {
    var arr = JSON.parse('%ADDITIONAL_FIELDS%');
    console.log(arr);
  }
  catch (err) {
    alert('JSON parse error.');
  }

  jQuery(function() {
    var resposibleList = document.getElementById("RESPOSIBLE_LIST").value;
    var resposibleArr = resposibleList.split(',');
    var count = 0;
    jQuery( '.admin_checkbox' ).each(function() {
      if ( resposibleList == '' || resposibleArr.indexOf(jQuery(this).attr("aid")) >= 0 ) {
        jQuery(this).prop("checked", true);
        count++;
      }
    });
    jQuery( '.admin_count' ).text(count);


    jQuery('#add_field').click(function(event) {
      event.preventDefault();
      jQuery( '#blank_element' ).clone( true )
          .attr('id','field')
          .show()
          .appendTo('#additional_fields_container');

      jQuery('.del_btn').click(function(event) {
        event.preventDefault();
        this.closest('.form-group').remove();
      });
    });

    jQuery( '#type_add_form' ).submit(function(event) {
      var obj = [];
      jQuery( '.field_name' ).each(function(index) {
        if (jQuery( this ).val()) {
          obj[index] = {LABEL:jQuery( this ).val(), NAME:'a_field' + (index + 1)};
        }
      });
      jQuery( '.field_type' ).each(function(index) {
        if (jQuery( this ).val()) {
          obj[index]['TYPE'] = jQuery( this ).val();
        }
      });

      jQuery('#additional_fields').val(JSON.stringify(obj));
    });
  });

  function closeModal() {
    var resposibleArr = [];
    jQuery( '.admin_checkbox' ).each(function() {
      if (this.checked) {
        resposibleArr.push(jQuery(this).attr("aid"));
      }
    });
    console.log(resposibleArr.length);
    jQuery( '.admin_count' ).text(resposibleArr.length);
    document.getElementById("RESPOSIBLE_LIST").value = resposibleArr.join();
  }

</script>