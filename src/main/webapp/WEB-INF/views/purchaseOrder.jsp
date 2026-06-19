<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 18-06-2026
  Time: 00:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Purchase Order List</title>
    <jsp:include page="../common/common_link.jsp"/>
</head>
<body>

<jsp:include page="../common/side-bar.jsp"/>

<div class="main" id="main">

    <div class="page-card">

        <!-- Header -->

        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2 class="fw-bold">Purchase Order List</h2>

            <button class="btn btn-primary"
                    onclick="addPurchaseOrder()">

                <i class="fa-solid fa-plus me-2"></i>
                Add Purchase Order

            </button>

        </div>

        <!-- Purchase Order List -->

        <div class="card shadow-sm">

            <div class="card-header bg-info text-white">
                Purchase Order List
            </div>

            <div class="card-body">

                <div class="table-responsive">

                    <table class="table table-bordered table-hover">

                        <thead class="table-dark">

                        <tr>
                            <th>Sr No</th>
                            <th>PO No</th>
                            <th>Purchase Date</th>
                            <th>Vendor</th>
                            <th>Invoice No</th>
                            <th>Grand Total</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>

                        </thead>

                        <tbody id="purchaseOrderTableBody">

                        <tr>

                            <td>1</td>
                            <td>PO00001</td>
                            <td>18-06-2026</td>
                            <td>ABC Traders</td>
                            <td>INV001</td>
                            <td>135700</td>

                            <td>
                                <span class="badge bg-success">
                                    ACTIVE
                                </span>
                            </td>

                            <td>

                                <button class="btn btn-primary btn-sm"
                                        onclick="editPurchaseOrder(1)">
                                    Edit
                                </button>

                                <button class="btn btn-danger btn-sm"
                                        onclick="deletePurchaseOrder(1)">
                                    Delete
                                </button>

                            </td>

                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>
    </div>

</div>

<script src="../../js/side-nav-bar-js.js"></script>


</body>
</html>

<script>

    // function getVendorAndItemTypeBasicDetails() {
    //     console.log("hello")
    //       // $.ajax({
    //       //     url :"rest/purchaseOrder/getVendorAndItemTypeBasicDetails",
    //       //     type :"GET",
    //       //     success : function (res) {
    //       //         console.log("Response :", res);
    //       //
    //       //         let itemTypeList = res.itemTypeList;
    //       //          let vendorList = res.vendorList;
    //       //          console.log("item list : "+itemTypeList);
    //       //          console.log("vendor list :" + vendorList);
    //       //     },
    //       //     error: function(xhr) {
    //       //         console.log(xhr.responseText);
    //       //     }
    //       // });
    // }


    //any other page open you can use this
    function addPurchaseOrder(){
        window.location="/addEditPurchaseOrder";
    }



</script>