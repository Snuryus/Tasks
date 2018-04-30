<form class='form-horizontal' id='task_add_form'>
<input type='hidden' name='index' value='$index'>
<input type='hidden' name='ID' value='%ID%'>
  <div class='row'>
    <div class='box box-theme box-form'>
      <div class='box-header with-border'><h3 class='box-title'><b>%NAME%</b></h3>
        <div class='box-tools pull-right'>
          <button type='button' class='btn btn-default btn-xs' data-widget='collapse'>
            <i class='fa fa-minus'></i>
          </button>
        </div>
      </div>
      <div class="container">
          <div class='box-tools pull-left'>
            <h4>Опис задачі: %DESCR%</h4>
          </div>
      </div>
      <div class="container">
           <div class='box-tools pull-left'>
               <h4>Дата видачі: %PLAN_DATE%</h4>
           </div>
      </div>
      <div class="container">
          <div class='box-tools pull-left'>
            <h4>Дата завершення: %CONTROL_DATE%</h4>
          </div>
      </div>
      <div class='box-footer'>
        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#comment">Завершить задачу</button>
      </div>

      <!-- Comment -->
      <div class="container">
        <input type='hidden' id='Comment_modal' value='%OLD_VALUE%'>

        <div class="modal fade" id="comment" role="dialog">
          <div class="modal-dialog">

            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Коментар</h4>
              </div>
              <div class="modal-body">
                   <textarea class="form-control" rows="5" name='COMMENTS' id='COMMENTS'>%COMMENTS%</textarea>
              </div>
              <div class='modal-footer'>
                <input type="submit" name="done" value="Выполнена" class="btn btn-success">
                <input type="submit" name="undone" value="Не выполнена" class="btn btn-danger">
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</form>
