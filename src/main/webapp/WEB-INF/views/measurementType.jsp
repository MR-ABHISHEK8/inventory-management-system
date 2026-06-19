<%@ page import="java.util.List" %>
<%@ page import="com.app.entity.MeasurementEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 26-05-2026
  Time: 23:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Measurement Type</title>
  <jsp:include page="../common/common_link.jsp"></jsp:include>

  <style>
    .pagination .page-link {
      color: #0d6efd;
      border-radius: 8px;
      margin: 0 2px;
    }

    .pagination .page-item.active .page-link {
      background-color: #0d6efd;
      border-color: #0d6efd;
      color: #fff;
    }

    .pagination .page-link:hover {
      background: #f1f1f1;
    }
  </style>
</head>

<body>

<jsp:include page="../common/side-bar.jsp"></jsp:include>

<div class="main" id="main">
  <div class="page-card">

    <div class="d-flex justify-content-between align-items-center mb-2">
      <div>
        <h2 class="fw-bold mb-1">Measurement Type</h2>
      </div>

      <button class="btn btn-primary px-4" data-bs-toggle="modal" onclick="addMeasurementType()">
        <i class="fa-solid fa-plus me-2"></i>
        Add Measurement
      </button>
    </div>

    <div class="table-responsive">
      <table class="table table-hover table-bordered align-middle text-center">

        <thead class="table-dark">
        <tr>
          <th>Sr No.</th>
          <th>Measurement Name</th>
          <th>Short Name</th>
          <th>Description</th>
          <th width="180">Action</th>
        </tr>
        </thead>

        <tbody id="table-body">

        </tbody>

      </table>

      <!-- Pagination Frontend UI -->
      <div class="d-flex justify-content-between align-items-center mt-3 flex-wrap">
        <div class="text-muted"> Showing 1 to 10 of 100 entries</div>
        <nav>
          <ul class="pagination mb-0">
            <li class="page-item disabled"><a class="page-link" href="#">
                Previous
              </a>
            </li>

            <li class="page-item active">
              <a class="page-link" href="#">1</a>
            </li>

            <li class="page-item">
              <a class="page-link" href="#">2</a>
            </li>

            <li class="page-item">
              <a class="page-link" href="#">3</a>
            </li>

            <li class="page-item">
              <a class="page-link" href="#">4</a>
            </li>

            <li class="page-item">
              <a class="page-link" href="#">5</a>
            </li>

            <li class="page-item">
              <a class="page-link" href="#">
                Next
              </a>
            </li>

          </ul>
        </nav>

      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="measurementModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modal-title">
          Add Measurement Type
        </h5>

        <button type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="modal">
        </button>
      </div>

      <div class="modal-body">
        <form id="main-form">

          <input type="hidden" id="measurement_id" value="">

          <div class="row">

            <div class="col-md-6 mb-3">
              <label class="form-label">
                Measurement Name
              </label>

              <input type="text"
                     id="name"
                     class="form-control"
                     placeholder="Enter measurement name">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">
                Short Name
              </label>

              <input id="shortName"
                     type="text"
                     class="form-control"
                     placeholder="Enter short name">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">
                Description
              </label>

              <input id="description"
                     type="text"
                     class="form-control"
                     placeholder="Enter description">
            </div>

          </div>

        </form>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" onclick="hideModal()">Close</button>
        <button type="button" onclick="saveMeasurementType();" class="btn btn-success" id="btn-save">Save Measurement</button>
      </div>

    </div>
  </div>
</div>

<script src="../../js/side-nav-bar-js.js"></script>

</body>
</html>

<script>
  $(document).ready(function(){
    getMeasurementTypeData();
  });

  function saveMeasurementType(){

    let data1={
      "id":$("#measurement_id").val(),
      "name":$("#name").val(),
      "shortName":$("#shortName").val(),
      "description":$("#description").val(),
    };
    $.ajax({
      url:"/rest/measurement/saveUpdateMeasurementType",
      type:"POST",
      data:JSON.stringify(data1),
      contentType:"application/json",
      success:function (ab){
        console.log("Success Block "+JSON.stringify(ab))
        getMeasurementTypeData();
        clearForm();
        hideModal();
      },error(res){
        console.log("Error Block "+JSON.stringify(res))
      }
    })

  }


  function getMeasurementTypeData() {
    $.ajax({
      url: "/rest/measurement/getMeasurementTypeData",
      type: "GET",
      success: function (res) {
        let table_data = "";
        if (res) {
          for (let i = 0; i < res.length; i++) {
            let data = res[i];

            table_data +=
                    "<tr>" +
                    "<td>" + (i + 1) + "</td>" +
                    "<td>" + data.name + "</td>" +
                    "<td>" + data.shortName + "</td>" +
                    "<td>" + data.description + "</td>" +
                    "<td>" +
                    "<div class='d-flex justify-content-center'>" +
                    "<button type='button' " + "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                    "onclick='editMeasurementType(" + data.id + ")'>" +
                    "<i class='bi bi-pencil-square'></i> Edit" +
                    "</button>" +

                    "<button type='button' " +
                    "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " + "onclick='deleteMeasurementType(" + data.id + ")'>" +
                    "<i class='bi bi-trash'></i> Delete" +
                    "</button>" +

                    "</div>" +
                    "</td>" +
                    "</tr>";
          }
        }
        $("#table-body").html(table_data);
      },
      error: function (res) {
        console.log("Error Block " + JSON.stringify(res));
      }
    });
  }

  function editMeasurementType(id){
    $.ajax({
      url:"/rest/measurement/getMeasurementTypeDataById?id="+id,
      type:"GET",
      success:function (res){
        if (res){
          $("#measurement_id").val(res.id);
          $("#name").val(res.name);
          $("#shortName").val(res.shortName);
          $("#description").val(res.description);
        }
        showModal();
      },error(res){
        console.log("Error Block "+JSON.stringify(res))
      }
    })
  }


  function deleteMeasurementType(id){

    let b = confirm("You want to delete measurement type ?");
    if (!b)return;
    let data1={
      "id":id
    };
    $.ajax({
      url:"/rest/measurement/deleteMeasurementTypeById",
      type:"POST",
      data:JSON.stringify(data1),
      contentType:"application/json",
      success:function (res){
        alert(res);
        getMeasurementTypeData();
      },error(res){
        alert(res);
      }
    })

  }

  function clearForm() {
    $("#measurement_id").val('');
    $("#name").val('');
    $("#shortName").val('');
    $("#description").val('');
  }
  function addMeasurementType() {
    clearForm();
    showModal();
  }

  function showModal(){
    $("#measurementModal").modal('show')
  }
  function hideModal(){
    $("#measurementModal").modal('hide')
  }
</script>