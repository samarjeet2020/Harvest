<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Billing Detail</title>
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
     <link href="<c:url value="/resources/css/parkingcss.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/css/style-4g.css" />" rel="stylesheet">
          <link href="<c:url value="/resources/css/jquery-ui.min.css" />" rel="stylesheet">
          <link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
     <script src="<c:url value="/resources/js/jquery.min.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
     <script src="<c:url value="/resources/js/parkingjs.js" />"></script>
 <script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>

		

<script type="text/javascript">

	
	$(document).ready(function() {
		
		
		$('#sitestatusGrid').DataTable({
		
		 });
		
		$('#custsearchGrid').DataTable(
	{
	"paging":   false,
        "ordering": true,
        "info":     false
    });

		
		
	});	
		
function showSearchDiv(){
$("#customerdropdown").show();
}

function setCustInfo(e)
{
var PAR = $(e).parent();
	
	
	var custId = $(PAR).find("#custID").text().trim();
	var custName = $(PAR).find("#custName").text().trim();
	$("#id_").val(custId);
	$("#search_").val(custName);
	$("#customerdropdown").hide();

}
            
            function addBillingDetail(){
            	
            	
        
            	
            	
            	var dataObj ="customerID="+$("#id_").val()+"&customerName="+$("#search_").val()+"&workType="+$("#wrkType").val()+"&totalUnit="+$("#quantity_").val()
            	+"&chargePerUnit="+$("#qntityChrg").val()+"&amount="+$("#amount_").val()+"&remarks="+$("#remarks_").val();
            			
            			
            	
          
            	
            	submitJSON(dataObj, 'addBillingDetail');
            	
            }
            
</script>


</head>
<body>
		<div class="alC">
		<c:choose>
		  <c:when test="${not empty successCode}">
		
			<div class="isa_success" id="isa_success">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_success"><s:property
						value="successCode" /></span>

			</div>
		
		 </c:when>
		   <c:otherwise>
		   
		
			<div class="isa_success" id="isa_success" style="display: none">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_success"><s:property
						value="successCode" /></span>

			</div>

		</c:otherwise>
</c:choose>
		<c:choose>
		  <c:when test="${not empty errorCode}">
			<div class="isa_error" id="isa_error">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_error"><s:property
						value="errorCode" /></span>

			</div>
		 </c:when>
		   <c:otherwise>
			<div class="isa_error" id="isa_error" style="display: none">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_error"><s:property
						value="errorCode" /></span>

			</div>
		</c:otherwise>
</c:choose>
<c:choose>
		  <c:when test="${not empty warningCode}">
		
			<div class="isa_warning" id="isa_warning">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_warning"><s:property
						value="warningCode" /></span>

			</div>
		 </c:when>
		   <c:otherwise>
			<div class="isa_warning" id="isa_warning" style="display: none">
				<a href="javascript:void(0)" class="close-msg"><img
					src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg" onclick="hideMessage()" /></a>
				<i class="fa fa-check"></i> <span id="message_placeholder_warning"><s:property
						value="warningCode" /></span>

			</div>
		</c:otherwise>
</c:choose>

	</div>
	
	<div id="nmsdataGrid" class="userListClass">
		<div class="title1"><h4>Billing Detail</h4></div>
		<table  id="sitestatusGrid" cellspacing="0" width="100%" >
			<thead align="center">
				<tr>
				<th width="3%">ID</th>
				<th width="3%">Customer Id</th>
                <th width="4%">Name</th>
                <th width="10%">Work Type</th>
                <th width="4%">Quantity</th>
                <th width="10%">Quantity Charge</th>
                <th width="4%">Amount</th>
                <th width="4%">Remarks</th>
           
               
				</tr>
			</thead>


	
			<tbody>
			
			
					
				<c:forEach items="${dataTableList}" var="dataTableList" varStatus="varStatus">
					<tr>
			
			
				<td width="3%" id="field0ID"> ${varStatus.count+1}  </td>
				<td width="4%" id="field1ID"> ${dataTableList.customerID}</td>
		 	<td width="4%" id="field2ID"><a href="#" onclick="getCustomerBillingDetail('${dataTableList.customerID}','${dataTableList.customerName}')"> ${dataTableList.customerName}</a></td> 
			<td width="10%" id="field7ID"> ${dataTableList.workType}</td>
			<td width="4%" id="field3ID"> ${dataTableList.totalUnit}</td>
			<td width="10%" id="field4ID"> ${dataTableList.chargePerUnit}</td>
			<td width="4%" id="field5ID"> ${dataTableList.cashDeposit}</td>
			<td width="4%" id="field6ID"> ${dataTableList.remarks}</td>
			
			    
                        
                     
						
					</tr>
				 </c:forEach>
				 
				 
				 
				
				 
				 
				 
				 
			</tbody>
			<tfoot>
			 <tr>
				<td width="3%" id="field0ID">   </td>
			
		 	<td width="2%" id="field1ID"> <input type="text" id="id_" name="id_" readonly="readonly" ></td>
		 	<!-- <td width="4%" id="field2ID"> <input type="text" id="search_" name="search_" maxlength="10"></td>  -->
	
<td width="4%" id="field2ID"> <input type="text" id="search_" name="search_" readonly="readonly" onclick="showSearchDiv()">

<div id="customerdropdown" style="display : none"> 
<table  id="custsearchGrid"  >
<thead align="center">
				<tr>
				<th width="3%">ID</th>
				<th width="3%">Customer Id</th>
				</tr>
				</thead>	
<tbody>
<c:forEach items="${customerList}" var="customerList" >
<tr>
<td  id="custID"> ${customerList.id}</td>
<td  id="custName" onclick="setCustInfo(this)"> <a href="#">${customerList.firstName} </a></td> 
</tr>
</c:forEach>
</tbody>

</table>
</div>
</td>
			<td width="10%" id="field7ID"> <select id="wrkType" style="width: 98%">
			<c:forEach items="${rateList}" var="rateList" >
			<option value="${rateList.rateId}"   rateValue="${rateList.rateValue}">${rateList.workType}</option>
			</c:forEach>
			</select></td>
			<td width="4%" id="field3ID"> <input type="text" id="quantity_" name="quantity_" maxlength="5"></td>
			<td width="4%" id="field4ID"> <input type="text" id="qntityChrg" name="qntityChrg" maxlength="5"></td>
		
			<td width="4%" id="field5ID"> <input type="text" id="amount_" name="amount_" maxlength="8"></td>
			<td width="4%" id="field6ID"> <input type="text" id="remarks_" name="remarks_" maxlength="50"></td>
			
			    
                        
                     
						
					</tr>
       	<tr>
       		<td colspan="8" align="right">
  
       			<button  class="btn btn-primary" onclick="addBillingDetail()">Add</button>
        		
       		
       		</td>
       	</tr>
       </tfoot>

		</table>
	
	</div>
	
	<!-- Modal -->
<div id="myModal1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">USER FORM</h4>
      </div>
      <div class="modal-body" id="divAdd">
      <div class="alC">
						<div class="isa_warning" id="isa_warning_dialog"
							style="display: none">
							<a href="javascript:void(0)" class="close-msg"><img
								src="<c:url value="/resources/images/cross-icon.png" />" alt="close-msg"
								onclick="hideMessage()"></a> <i
								class="fa fa-check"></i> <span
								id="message_placeholder_warning_dialog">All fields
								are mandatory..!!</span>
						</div>
					</div>
        <section id="userForm">
              <div class="common-container">
                <form action="" method="post" id="frmNewUser">
                <div class="form">
                  <div class="row">
                    <div class="col-xs-12 col-sm-6 sidebar-offcanvas">
                     
                      
                 
                        <div class="form-group">
                          <label for="emailID">Email Id<r>*</r></label>
                          <input type="email" class="form-control" id="txtEmailId" name="txtEmailId" placeholder="Email" maxlength="100"/>
                        </div> 
                        
                    </div>
                    
                  </div>
                </div>
                <div class="controls alR">
                      <button type="reset" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                      <input type="button" onclick="createNewUser();" class="btn btn-primary" value="Add" />
                     </div>
                </form>
              </div>
            </section>
      </div>
      
    </div>

  </div>
</div>

</body>
</html>
