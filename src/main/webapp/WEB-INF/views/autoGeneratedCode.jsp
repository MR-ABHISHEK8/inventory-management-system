<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 20-06-2026
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Auto Generate Code</title>

    <jsp:include page="../common/common_link.jsp"/>
</head>

<body>

<jsp:include page="../common/side-bar.jsp"/>

<div class="main" id="main">

    <div class="page-card">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">Auto Generate Code</h2>

            <button class="btn btn-primary" onclick="openModal()">+ Add </button>
        </div>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                <tr>
                    <th>Sr</th>
                    <th>Prefix</th>
                    <th>Zero Padding</th>
                    <th>Separator</th>
                    <th>PostFix</th>
                    <th>Start No</th>
                    <th>Last No</th>
                    <th>View</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody id="tableBody"></tbody>
            </table>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="autoCodeModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Auto Generate Code</h5>
                <button type="button" class="btn-close btn-close-white" onclick="closeModal()"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="autoGenerateCodeId"/>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label>Prefix</label>
                        <input type="text" id="prefix" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Zero Padding</label>
                        <input type="number" id="zeroPadding" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Separator</label>
                        <input type="text" id="separator" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Post Fix</label>
                        <input type="text" id="postFix" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Start No</label>
                        <input type="number" id="startNo" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Last No</label>
                        <input type="number" id="lastNo" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Views Type</label>
                        <select id="views" class="form-control">
                            <option value="">Select Type</option>
                            <option value="PO">PO Number</option>
                            <option value="PI">Purchase Invoice</option>
                            <option value="SO">Sales Order</option>
                            <option value="SI">Sales Invoice</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Close</button>
                <button class="btn btn-success" onclick="saveEditAutoGenerateCodeData()">Save</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/side-nav-bar-js.js"></script>

<script>

     $(document).ready(function () {
          getAllAutoGenerateCode();
     })

    function saveEditAutoGenerateCodeData() {
          let data = {
                "id" :$("#autoGenerateCodeId").val(),
                "prefix" : $("#prefix").val(),
                "zeroPadding":$("#zeroPadding").val(),
                "separator" : $("#separator").val(),
                "postFix" : $("#postFix").val(),
                "startNo" : $("#startNo").val(),
                "lastNo" : $("#lastNo").val(),
                "views" : $("#views").val()
          }
          console.log(JSON.stringify(data))
          $.ajax({
              url : "/rest/autoGenerateCode/saveUpdateAutoGenerateCode",
              type :"POST",
              data : JSON.stringify(data),
              contentType :"application/json",
              success: function (res) {
                  console.log("Saved:", res);
                  getAllAutoGenerateCode();
                  closeModal();
              },
              error: function (err) {
                  console.log(err);
              }

          });
    }

    const docTypeMap = {
        PO: "PO Number",
        PI: "Purchase Invoice",
        SO: "Sales Order",
        SI: "Sales Invoice"
    };

    function getAllAutoGenerateCode() {
        $.ajax({
            url: "/rest/autoGenerateCode/getAllAutoGenerateCode",
            type: "GET",
            success : function (res){
                let table_data = "";
                for (let i = 0; i < res.length; i++) {
                    let data = res[i];

                    console.log("docTypeMap[data.views] : " + docTypeMap[data.views]);
                    console.log("data.views :" + data.views);

                    table_data += "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>" + data.prefix + "</td>" +
                        "<td>" + data.zeroPadding + "</td>" +
                        "<td>" + data.separator + "</td>" +
                        "<td>" + data.postFix + "</td>" +
                        "<td>" + data.startNo + "</td>" +
                        "<td>" + data.lastNo + "</td>" +
                        "<td>" + (docTypeMap[data.views] || data.views) + "</td>" +

                        "<td>" +

                        "<div class='d-flex justify-content-center'>" +

                        "<button type='button' " +
                        "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                        "onclick='editAutoGenerateCodeById(" + data.id + ")'>" +
                        "<i class='bi bi-pencil-square'></i> Edit" +
                        "</button>" +

                        "<button type='button' " +
                        "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " +
                        "onclick='autoGenerateCodeDeleteById(" + data.id + ")'>" +
                        "<i class='bi bi-trash'></i> Delete" +
                        "</button>" +

                        "</div>" +

                        "</td>" +

                        "</tr>";
                }
                $("#tableBody").html(table_data);
            },
            error : function (res){
                console.log("error :" + JSON.stringify(res));
            }
        });
    }

    function editAutoGenerateCodeById(id){
        $.ajax({
            url: "/rest/autoGenerateCode/getAutoGenerateCodeById?id=" + id,
            type :"GET",
            success :function (res){
                 if (res){
                     $("#autoGenerateCodeId").val(res.id);
                     $("#prefix").val(res.prefix);
                     $("#zeroPadding").val(res.zeroPadding);
                     $("#separator").val(res.separator);
                     $("#postFix").val(res.postFix);
                     $("#startNo").val(res.startNo);
                     $("#lastNo").val(res.lastNo);
                     $("#views").val(res.views.trim());

                 }
                openModal();
            },error :function (res){
                console.log("error block :" +  JSON.stringify(res));
            }
        });
    }
    function autoGenerateCodeDeleteById(id) {
        let b = confirm("You want to delete Auto Generate Code ?");
        if (!b) return;
        let data = {
            "id": id
        };

        $.ajax({
            url : "/rest/autoGenerateCode/autoGenerateCodeDeleteById",
            type : "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            success :function (res){
                alert(res);
                getAllAutoGenerateCode();
            }

        });
    }
     function formReset() {
         $("#autoGenerateCodeId").val("");
         $("#prefix").val("");
         $("#zeroPadding").val("");
         $("#separator").val("");
         $("#postFix").val("");
         $("#startNo").val("");
         $("#lastNo").val("");
         $("#views").val("");
     }

    function openModal() {
        $("#autoCodeModal").modal("show");
    }
    function closeModal() {
        $("#autoCodeModal").modal("hide");
        formReset();
    }


</script>

</body>
</html>
