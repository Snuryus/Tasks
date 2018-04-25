<form class='form-horizontal' method="POST" id='type_add_form'>
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

      <div class="form-group">
        <label class='control-label col-md-4' for='NAME'>Название типа задачи:</label>
        <div class='col-md-8'>
          <input class='form-control' type='text' value='%NAME%' name='NAME' id='NAME'>
        </div>
      </div>

      <div class="form-group">
        <h4>Дополнительные поля:</h4>
      </div>
      <div id='additional_fields_container'>
      </div>
      <div class="col-md-1">
        <a title='add field' class='btn bg-olive margin' id='add_field' href='#'><i class="fa fa-plus"></i></a>
      </div>

      <div class="form-group" style='display: none;'' id='blank_element'>
        <div class='col-md-1'>
          <a title='remove field' class='btn bg-gray margin del_btn' href='#'><i class="fa fa-minus" style='pointer-events: none;'></i></a>
        </div>
        <label class='control-label col-md-2'>Тип поля:</label>
        <div class='col-md-3'>
          <input class='form-control field_type' type='text'>
        </div>
        <label class='control-label col-md-2'>Название поля:</label>
        <div class='col-md-4'>
          <input class='form-control field_name' type='text'>
        </div>
      </div>

    </div>
    <div class='box-footer'>
      <input type=submit name='%BTN_ACTION%' value='%BTN_NAME%' class='btn btn-primary'>
    </div>  
  </div>
</form>

<script type="text/javascript">
  try {
    var arr = JSON.parse('%ADDITIONAL_FIELDS%');
    console.log(arr);
  }
  catch (err) {
    alert('JSON parse error.');
  }

  jQuery(function() {
    jQuery('#add_field').click(function(event) {
      event.preventDefault();
      var elem = jQuery( "#blank_element" );
      var clone = elem.clone( true );
      clone.attr('id','field');
      clone.show();
      clone.appendTo(jQuery('#additional_fields_container'));

      jQuery(".del_btn").click(function(event) {
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
</script>