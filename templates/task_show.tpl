<form class='form-horizontal' id='task_add_form'>
<input type='hidden' name='index' value='$index'>
<input type='hidden' name='ID' value='%ID%'>
  <div class='row'>
    <div class='box box-theme box-form'>
      <div class='box-header with-border'><h3 class='box-title'>%NAME%</h3>
        <div class='box-tools pull-right'>
          %INFO%
          <button type='button' class='btn btn-default btn-xs' data-widget='collapse'>
            <i class='fa fa-minus'></i>
          </button>
        </div>
      </div>
      <div class='box-body' id='task_form_body'>
        <h4>%DESCR%</h4>
      </div>
      <div class="form-group">
        <div class='col-md-12'>
          <textarea class="form-control" rows="5" name='COMMENTS' id='COMMENTS'></textarea>
        </div>
      </div>
      <div class='box-footer'>
        <input type="submit" name="done" value="Выполнена" class="btn btn-success">
        <input type="submit" name="undone" value="Не выполнена" class="btn btn-danger">
      </div>  
    </div>
  </div>
</form>