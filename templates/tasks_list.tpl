<ul class='nav nav-tabs'>
  <li class='active'><a data-toggle='tab' href='#t1'>_{UNFULFILLED_TASKS}_ <span class="label label-danger">%U_COUNT%</span></a></li>
  <li><a data-toggle='tab' href='#t2'>_{COMPLETED_TASKS}_ <span class="label label-success">%C_COUNT%</span></a></li>
  <li><a data-toggle='tab' href='#t3'>_{TASK_IN_WORK}_ <span class="label label-default">%W_COUNT%</span></a></li>
  <li><a data-toggle='tab' href='#t4'>_{TASK_IN_QUEUE}_ <span class="label label-default">%Q_COUNT%</span></a></li>
</ul>

<div class='tab-content'>
  <div id='t1' class='tab-pane fade in active'>%U_TASKS%</div>
  <div id='t2' class='tab-pane fade'>%C_TASKS%</div>
  <div id='t3' class='tab-pane fade'>%W_TASKS%</div>
  <div id='t4' class='tab-pane fade'>%Q_TASKS%</div>
</div>