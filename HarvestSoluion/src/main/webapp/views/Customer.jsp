<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Customers</title>
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
     <link href="<c:url value="/resources/css/parkingcss.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/css/style-4g.css" />" rel="stylesheet">
    <script src="<c:url value="/resources/js/jquery-1.12.3.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
     <script src="<c:url value="/resources/js/parkingjs.js" />"></script>
 <script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#userListTable').DataTable(
		
		{
		 "initComplete": function(settings, json) {
        									 hideNMSLoader();
                                          }
		});

	});
	
	
	function UserBean(){
		var userId;
		var userName;
		var loginId;
		var status;
		var circle;
		var circleId;	
		var emailId;
		var mobileNo;
		var userType;
		var ssfManaged;
	    var userRoles;
		var lob;		
		var role;
		var gender;
	}
	
	function userDetailEditClick(e){
		if($(e).text() == "Edit"){
			$(e).text("Save");
			var PAR = $(e).parent().parent();
			$(PAR).find("td").each(function(){
				if($(this).attr("id") != null){
					if($(this).attr("id").trim() == "tdUserName" || $(this).attr("id").trim() == "tdEmailId" || $(this).attr("id").trim() == "tdMobileNo"){
						$(this).html("<input type='text' value='"+$(this).text()+"' />");
					}
					if($(this).attr("id").trim() == "tdRole"){
						var opt = $(this).text();
						var value = 0;
						$(this).html("<select>"+$("select#selectRole").html()+"<select>");				
						$(this).find("select option").each(function(){
							if($(this).text().trim() == opt){
								value = $(this).val();
							}
						})
						$(this).find("select").val(value);
					}
					if($(this).attr("id").trim() == "tdGender"){
						var opt = $(this).text();
						$(this).html("<select>"+$("select#selectGender").html()+"<select>");		
						if(opt == "Male")
							$(this).find("select").val("M");
						else
							$(this).find("select").val("F");
					}
				
				}
			});
		}else{
			$(e).text("Edit");
			var PAR = $(e).parent().parent();
			var obj = new UserBean();
			obj.userId = $(PAR).find("#tdUserId").text().trim();
			obj.loginId = $(PAR).find("#tdLoginId").text().trim();
			
			obj.loginId = $(PAR).find("#tdLoginId").text().trim();
			obj.loginId = $(PAR).find("#tdLoginId").text().trim();
			obj.loginId = $(PAR).find("#tdLoginId").text().trim();
			
			obj.userName = $(PAR).find("#tdUserName input").val().trim();
			obj.role = $(PAR).find("#tdRole select").val().trim();
			obj.emailId =  $(PAR).find("#tdEmailId input").val().trim();
			obj.mobileNo= $(PAR).find("#tdMobileNo input").val().trim();
			obj.gender = $(PAR).find("#tdGender select").val().trim();
			obj.userType = $(PAR).find("#tdUserType").text().trim();
			
			
	       	submitJSON(obj, 'updateCustomerDetail.c');
	       	$(PAR).find("td").each(function(){
				if($(this).attr("id") != null){
					if($(this).attr("id").trim() == "tdUserName" || $(this).attr("id").trim() == "tdEmailId" || $(this).attr("id").trim() == "tdMobileNo"){
						$(this).html($(this).find("input").val().trim());
					}
					if($(this).attr("id").trim() == "tdRole" || $(this).attr("id").trim() == "tdGender"){
						$(this).html($(this).find("select option:selected").text().trim());
					}
				}
			});
			
			
		}
	}
	
	function doGetStatus(loginId,val) {
	
	var vars = {};
	var tdLoginId;
	var tdStatus;

	var dataObj = {
				"loginId" : loginId,
				"status" : val
			};
			
			
			/* alert(JSON.stringify(dataObj)); */
			submitJSON(dataObj, 'userwfstatus');


}
	
	function doCleanWork(){
		$("#userDetailsForm").find("input").each(function(){
			$(this).val("");
		});
		$("#userDetailsForm").find("select").each(function(){
			$(this).val(0);
		});
		//$("#").modal("hide");
	}
	
	 function doCleanaddForm(){
		$("#frmNewuser").find("input").each(function(){
			$(this).val("");
		});
		$("#frmNewuser").find("select").each(function(){
			$(this).val(0);
		});
	}
	
	
	//Added by Gopal for Adduser
	
	
	function createNewUser(){
	//changeMessage("Mobile number cannot be blank..!!");
	
	var loginId=$("#txtloginId").val().trim();
	var Gender=$("#selectGender").val().trim();
	var MobileNo=$("#txtMobile").val().trim();
	var UserName=$("#txtUserName").val().trim();
	var EmailId=$("#txtEmailId").val().trim();
	
	    if (loginId == "") {
			warningMessageOnDialog("LoginId cannot be blank...");
			return false;
		}
		if (UserName == "") {
			warningMessageOnDialog("User Name cannot be blank...");
			return false;
		}
		if (Gender == "0") {
			warningMessageOnDialog("Gender cannot be blank...");
			return false;
		}
			
		if (MobileNo == "") {
			warningMessageOnDialog("Mobile number cannot be blank...");
			return false;
		}
		if(MobileNo.charAt(0)=="0") {
			warningMessageOnDialog("Mobile number Can not Start with Zero...");
		    return false;
		}
		if (MobileNo.length != parseInt(10)) {
			warningMessageOnDialog("Mobile number can be of 10 digits only...");
			return false;
		}
		if(isNaN(MobileNo)){
			warningMessageOnDialog("Enter mobile number in digits only...");
			return false;
		}
		 if (EmailId == "") {
			warningMessageOnDialog("Email Id cannot be blank ...");
			return false;
		}
		if(!EmailId == ""){
			var atpos = EmailId.indexOf("@");
		    var dotpos = EmailId.lastIndexOf(".");
		    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=EmailId.length) {
		    	warningMessageOnDialog("Please Enter valid e-mail Id...");  
			    return false;
			}
		 }	
	
			
		
		var dataObj = {
		
			"loginId" : loginId,
			"gender"  : Gender,
			"mobileNo": MobileNo,
			"userName": UserName,
			"userRoles": Role,
			"emailId" : EmailId

		};		
		var JSONdata = JSON.stringify(dataObj);
	//	alert(JSONdata);
	submitJSON(dataObj,'addwfusr');
		  $(".modal-backdrop.fade.in").remove();
	
	
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
		<div class="title1"><h4>User Details</h4></div>
		<table id="userListTable" class="display" cellspacing="0" width="100%" >
			<thead align="center">
				<tr>
				<th width="3%">Sr No</th>
                <th width="9%">Login Id</th>
                <th width="3%">Gender</th>
                <th width="14%">Email ID</th>
                <th width="8%">Mobile No</th>
                <th width="10%">User Name</th>
                <th width="4%">Status</th> 
               <th width="5%">Edit </th> 
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${customersList}" var="customersList" varStatus="varStatus">
					<tr>
						<td width="3%" id="tdsrNoId"><s:property value="%{#incr.index+1}"/>]</td>
						
						<td  width="9%" id="tdLoginId"><s:property value="loginId" /><c:out value="${customersList.userId}"/></td>
						<td  width="3%" id="tdGender"><s:property value="gender" /><c:out value="${customersList.gender}"/></td>
						<td  width="9%" id="tdEmailId"><s:property value="emailId" /><c:out value="${customersList.emailId}"/></td>
						<td width="9%" id="tdMobileNo"><s:property value="mobileNo" /><c:out value="${customersList.mobileNo}"/></td>
						<td  width="9%" id="tdUserName"><s:property value="userName" /><c:out value="${customersList.userName}"/>dd</td>
                        <td  width="4%" id="tdStatus">
						<c:choose>
							<c:when test="${customersList.status eq 'A'}">
						Active
							</c:when>
							<c:otherwise>
							Inactive
							</c:otherwise>
						</c:choose> </td>
						<td width="5%">
						<a href="#" onclick="userDetailEditClick()">Edit</a>
						</td>
                      
                    
						
							
							
                        
                        
                     
						
					</tr>
				 </c:forEach> 
			</tbody>
     <tfoot>
       	<tr>
       		<td colspan="8" align="right">
       		<!-- <a class="addTableRow btn btn-primary" href="javascript:void(0)" data-toggle="modal" data-target="#myModal" > Add</a>-->
       		
       			<a id="modalAddButton" class="btn btn-primary"
		           href="javascript:void(0)" style="display: none" data-toggle="modal" data-target="#myModal"></a>
        		
        		<a class="addTableRow btn btn-primary" href="javascript:void(0)" onclick="addRole()">Add</a></td>
 
       		
       		</td>
       	</tr>
       </tfoot>
		</table>
	
	</div>
	
	<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
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
                       <!--  <div class="form-group">
                          <label for="userType">User Type(LOB)*</label>
                          <input type="text" class="form-control" id="userType" placeholder="Mobility" disabled value="LOB">
                        </div> -->
                        <div class="form-group">
                          <label for="userId">Login ID<r>*</r></label>
                          <input type="text" class="form-control" id=txtloginId name="txtloginId" placeholder="Login Id" maxlength="100">
                        </div>
                        <div class="form-group">
                          <label>Gender<r>*</r></label>
                          <select  class="form-control" id="selectGender" name="selectGender">
						<option value="0">--Select Gender--</option>
						<option value="M">Male</option>
						<option value="F">Female</option>
				</select>
                        </div>
                        <div class="form-group">
                          <label for="mobileNumber">Mobile No.<r>*</r></label>
                          <input type="text" class="form-control" id="txtMobile" placeholder="Mobile Number" name="txtMobile" maxlength="10"/>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 sidebar-offcanvas">
                    <div class="form-group">
                          <label for="userName">User Name<r>*</r></label>
                          <input type="text" class="form-control"  id="txtUserName" name="txtUserName" placeholder="Username" maxlength="100"/>
                        </div>
                         <div class="form-group">
                          <label for="userType">Role<r>*</r></label>
                          <select class="form-control" id="selectRole" name="selectRole">
						<option value="0">--Select Role--</option>
						<s:iterator value="lstRoleTypeBean">
							<option value='<s:property value="roleTypeDesc"/>'><s:property
									value="roleTypeDesc" /></option>
						</s:iterator>
				</select>
                        </div>
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

<s:hidden id="interceptorParam" value="%{#session.interceptorParam}"></s:hidden>
</body>
</html>
