<div class="container">
  <h2>Modal Example</h2>
  <input type='hidden' id='TEST_main' value='%OLD_VALUE%'>
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" onClick='return openModal()'>Open Modal</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
         <input type='text' id='TEST_modal'>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" onClick='return closeModal()'>Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>
<script>
  function openModal() {
    console.log('open');
    document.getElementById("TEST_modal").value = document.getElementById("TEST_main").value;
  }
  function closeModal() {
    console.log('close');
    document.getElementById("TEST_main").value = document.getElementById("TEST_modal").value;
  }

</script>