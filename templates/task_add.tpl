<form class='form-horizontal' id='task_add_form'>
<input type='hidden' name='index' value='$index'>
  <div class='row'>
    <div class='box box-theme box-form'>
      <div class='box-header with-border'><h3 class='box-title'>%BOX_TITLE%</h3>
        <div class='box-tools pull-right'>
        <button type='button' class='btn btn-default btn-xs' data-widget='collapse'>
        <i class='fa fa-minus'></i>
          </button>
        </div>
      </div>
      <div class='box-body' id='task_form_body'>

        <div class="form-group">
          <label class='control-label col-md-4' for='task_type'>_{TASK_TYPE}_:</label>
          <div class='col-md-8'>
            %SEL_TASK_TYPE%
          </div>
        </div>

        <div class="form-group">
          <label class='control-label col-md-4' for='NAME'>_{TASK_NAME}_:</label>
          <div class='col-md-8'>
            <input class="form-control" name='NAME' id='NAME' value='%NAME%'>
          </div>
        </div>

        <div class="form-group">
          <label class='control-label col-md-4' for='DESCR'>_{TASK_DESCRIBE}_:</label>
          <div class='col-md-8'>
            <textarea class="form-control" rows="5" name='DESCR' id='DESCR'>%DESCR%</textarea>
          </div>
        </div>

        <div class="form-group">
          <label class='control-label col-md-4' for='responsible'>_{RESPOSIBLE}_:</label>
          <div class='col-md-8'>  
            %SEL_RESPOSIBLE%
          </div>
        </div>

        <div class='form-group'>
          <label class='control-label col-md-4' for='PLAN_DATE'>_{PLAN_DATE}_:</label>
          <div class='col-md-8'>
            <input class='form-control' data-provide='datepicker' data-date-format='yyyy-mm-dd' value='%PLAN_DATE%' name='PLAN_DATE' id='PLAN_DATE'>
          </div>
        </div>

        <div class='form-group'>
          <label class='control-label col-md-4' for='PLAN_DATE'>_{CONTROL_TIME}_:</label>
          <div class='col-md-8'>
            <input type='hidden' name='CONTROL_DATE' id='CONTROL_DATE' value='%CONTROL_DATE%'>
            <select class='form-control' id='sel_control_time'>
              <option value='1'>1 _{DAY}_</option>
              <option value='2'>3 _{DAYS_N}_</option>
              <option value='3'>1 _{WEEK}_</option>
              <option value='4'>2 _{WEEKS}_</option>
            </select>
          </div>
        </div>

      </div>
      <div class='box-footer'>
        <input type=submit name='%BTN_ACTION%' value='%BTN_NAME%' class='btn btn-primary'>
      </div>  
    </div>
  </div>
</form>

<script type="text/javascript">
  try {
    var arr = JSON.parse('%JSON_LIST%');
    console.log(arr);
  }
  catch (err) {
    alert('JSON parse error.');
  }

  function rebuild_form(type_num) {
    jQuery('.appended_field').remove();

    jQuery.each(arr[type_num], function(field) {
      var fieldLabel = arr[type_num][field]['LABEL'];
      var fieldName = arr[type_num][field]['NAME'];
      var fieldType = arr[type_num][field]['TYPE'];

      var element = jQuery("<div></div>").addClass("form-group appended_field");
      element.append(jQuery("<label for='" + fieldName + "'></label>").text(fieldLabel).addClass("control-label col-md-4"));
      element.append(jQuery("<div></div>").addClass("col-md-8").append(jQuery("<input name='" + fieldName + "' id='" + fieldName + "' type='" + fieldType + "'>").addClass("form-control")));
      jQuery('#task_form_body').append(element);
    });
  };

  // function change_control_select() {
  //   var controlDate = new Date(jQuery( '#CONTROL_DATE' ).val() + 'T00:00:00Z');
  //   var planDate = new Date(jQuery( '#PLAN_DATE' ).val() + 'T00:00:00Z');
  //   var diff = (controlDate - planDate) / 86400000;
  //   alert(diff);
  //   switch (diff) {
  //     case 1:
  //       jQuery("#sel_control_time [value='1']").attr("selected", "selected");
  //       break;
  //     case 3:
  //       jQuery("#sel_control_time [value='2']").attr("selected", "selected");
  //       break;
  //     case 7:
  //       jQuery("#sel_control_time [value='3']").attr("selected", "selected");
  //       break;
  //     case 14:
  //       jQuery("#sel_control_time [value='4']").attr("selected", "selected");
  //       break;
  //     default:
  //       jQuery("#sel_control_time [value='1']").attr("selected", "selected");
  //   }
  // }

  function change_control_time() {
    var c = jQuery( '#sel_control_time' ).val();
    var d = new Date(jQuery( '#PLAN_DATE' ).val() + 'T00:00:00Z');
    switch (c) {
      case '1':
        d.setDate(d.getDate() + 1);
        break;
      case '2':
        d.setDate(d.getDate() + 3);
        break;
      case '3':
        d.setDate(d.getDate() + 7);
        break;
      case '4':
        d.setDate(d.getDate() + 14);
        break;
      default:
        alert ('undefined select');
    }
    jQuery('#CONTROL_DATE').val(d.toISOString().substring(0, 10));
  }

  jQuery(function() {
    rebuild_form(jQuery( '#TASK_TYPE' ).val());
    change_control_time();

    jQuery( '#TASK_TYPE' ).change(function() {
      rebuild_form(jQuery( '#TASK_TYPE' ).val());
    });

    jQuery('#PLAN_DATE').change(function() {
      change_control_time();
    })

    jQuery( '#sel_control_time' ).change(function() {
      change_control_time();
    });

    jQuery( '#task_add_form' ).submit(function( event ) {
      


      if (jQuery( '#PLAN_DATE' ).val() === '') {
        alert( 'Укажите дату.' );
        event.preventDefault();
      }
      else if (jQuery( '#DESCR' ).val() === '') {
        alert( 'Введите описание задачи.' );
        event.preventDefault();
      }
      else if (jQuery( '#RESPOSIBLE' ).val() === '') {
        alert( 'Укажите ответственного.' );
        event.preventDefault();
      }
    });
  });
</script>