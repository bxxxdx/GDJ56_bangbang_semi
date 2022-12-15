<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.property.model.vo.Property" %>
<%
	Property property = (Property)request.getAttribute("property");
	/* System.out.println("updateProperty: "+property); */
%>

<!-- header -->
<%@ include file="/views/common/header.jsp" %>

<!-- CSS -->
<link href="<%=request.getContextPath() %>/css/account/broker/updateProperty.css" type="text/css" rel="stylesheet">

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<body>
<form action="<%=request.getContextPath()%>/account/broker/updatePropertyEnd.bb" method="post" onsubmit="return fn_invalidate();">

	<section id="all" style="display:flex;">
        <div id="wrap">
            <h1 style="font-size:40px"><매물 수정></h1>

             <h2>🔳 기본정보</h2>
            <div id="address">
                <span class="redtext">주소*</span>&nbsp;&nbsp;&nbsp;
                <span id="showAddr"><%=property.getAddress() %></span>
                <br>
            </div>
            <br>
           	
            <div id="floor" style="display: flex; align-text: center;">
                <span class="redtext" style="margin-right: 16px;">층수*</span>&nbsp;
                <span><%=property.getFloor() %></span>
            </div>
            <hr style="width: 95%;">
<!--------------------------------------------------------------------------------------------------------------------------------------------------->
            <h2>🔳 거래정보</h2>
            <div id="price" style="display: flex; align-items: center;">
                <span class="redtext" style="margin-right: 5px;">거래종류*</span>
                &nbsp; &nbsp;
                <input type="button" class="greenbutton" id="insertPrice" onclick="fn_priceY()" value="+ 전세">
                &nbsp;&nbsp;
                <input type="button" class="greenbutton" onclick="fn_priceM()" value="+ 월세">
                &nbsp;
            </div>
            <div id="priceDiv" style="margin-top: 10px;">
                <div id="yearPrice">
                    <div class="p">전세</div>
            	    <input type="number" class="inputa" name="yPrice" placeholder="전세금">
                    &nbsp; <p>만원</p>
                </div>
                <div id="monthlyPrice">
                    <div class="p">월세</div>
            	    <input type="number" placeholder="보증금" name="mPrice">&nbsp;<p>/</p> &nbsp; 
            	    <input type="number" placeholder="월세" name="mPrice2">
                    &nbsp; <p>만원</p>
                </div>
            </div>
            <script>
            	$(document).ready(function(){
            		<%if(property.getRenttype().equals("전세")){%>
            			$("#yearPrice").css("display","flex");
                    	$("#monthlyPrice").css("display","none");
                    	$("input[name=yPrice]").val("<%=property.getDeposit()%>");
            		<%}else{%>
            			$("#yearPrice").css("display","none");
                    	$("#monthlyPrice").css("display","flex");
                    	$("input[name=mPrice]").val("<%=property.getDeposit()%>");
                        $("input[name=mPrice2]").val("<%=property.getMonthlyCharge()%>");
            		<%}%>
            	});
                const fn_priceY=()=>{
                    //console.log($("#yearPrice"));
                    $("#yearPrice").css("display","flex");
                    $("#monthlyPrice").css("display","none");
                    $("input[name=mPrice]").val("");
                    $("input[name=mPrice2]").val("");
                }
                const fn_priceM=()=>{
                    //console.log($("#monthlyPrice"));
                    $("#yearPrice").css("display","none");
                    $("#monthlyPrice").css("display","flex");
                    $("input[name=yPrice]").val("");
                }
            </script>
            <br>
            <div id="cost" style="display: flex; text-align: center;">
                <span class="redtext" style="margin-right: 16px;">관리비*</span>
                &nbsp;
                <label><input type="radio" class="radio" name="costSelect" value="없음">없음</label> &nbsp;&nbsp;&nbsp;
                <label><input type="radio" class="radio" name="costSelect" id="costYes" value="있음">있음</label>
                <input type="number" name="costIn" min="1" placeholder="금액을 입력해주세요" style="margin-left: 7px;" hidden>
                <span class="greytext" style="margin-right: 16px;" hidden>만원</span>
            </div>
            <br>
            <script>
                $("input[name=costSelect]")[0].onclick=()=>{
                	$("input[name=costIn]").hide();
                	$("input[name=costIn]").next().hide();
                    //console.log($("input[name=costIn]"));
                }
                $("input[name=costSelect]")[1].onclick=()=>{
                	$("input[name=costIn]").show();
                	$("input[name=costIn]").next().show()
                    //console.log($("input[name=costIn]"));
                }
            </script>
            <div id="costInclude">
                <span>관리비 포함항목</span>
                &nbsp;
                <label><input type="checkbox" class="checkbox" id="eletric" name="costInclude" value="전기">전기</label>  &nbsp;
                <label><input type="checkbox" class="checkbox" id="gas" name="costInclude" value="가스">가스</label>  &nbsp;
                <label><input type="checkbox" class="checkbox" id="water" name="costInclude" value="수도">수도</label>  &nbsp;
            </div>
            <br>
            <hr style="width: 95%;">
            <script>
           		$(document).ready(function(){
            		console.log("dd");
            		<%if(property.getElectric()=='Y'){%>
            			$("#eletric").prop("checked",true);
            		<%}%>
            		<%if(property.getGas()=='Y'){%>
            			$("#gas").prop("checked",true);
            		<%}%>
            		<%if(property.getWater()=='Y'){%>
            			$("#water").prop("checked",true);
            		<%}%>
            	});
            </script>
<!--------------------------------------------------------------------------------------------------------------------------------------------------->
            <h2>🔳 방 정보</h2>
            <div id="room">
                <span class="redtext">방 구조*</span>&nbsp;&nbsp;
                <span><%=property.getPropertyStructure() %></span>
            </div>
            <br>
            <div id="area" style="display: flex; align-text: center;">
                <span class="redtext" style="margin-right: 38px;">면적*</span>
                &nbsp;
                <input type="number" name="areaIn" step="0.01" onkeyup="changeNum(event)" value="<%=property.getArea()%>" required>
                <span class="greytext">㎡</span>
                <span style="margin-left: 12px; margin-right: 2px; color:rgb(7, 90, 42)">✔</span>                
                <span id="sqft" style="color:rgb(7, 90, 42)">0</span>
                <span style="color:rgb(7, 90, 42)">평</span>
            </div>
            <br>
           	<script>
           		$(document).ready(function(){
           			let sqft = Math.round($("input[name=areaIn]").val()* 0.3025*10)/10.0;
           			$("#sqft").text(sqft);
           		})
           		const changeNum=(e)=>{
           			let sqft = Math.round($(e.target).val()* 0.3025*10)/10.0;
           			//console.log(sqft);
           			$("#sqft").text(sqft);
           		}
           	</script>
            
            
            <div id="expiryDate">
                <span class="redtext">공실예정일*</span>
                &nbsp;
                <label><input type="radio" name="edSelect" class="radio" value="choice">날짜선택 </label>
                <input type="date" name="exdayIn" disabled value="<%=property.getVacancyDate()%>">
                &nbsp;
                <label><input type="radio" value="공실" name="edSelect" class="radio">공실 </label>
                &nbsp;
                <label><input type="radio" value="협의입주" name="edSelect" class="radio">협의입주 </label>
            </div>
            <br>
            <script>
                $("input[name=edSelect]")[0].onclick=()=>{
                	$("input[name=exdayIn]").attr("disabled",false);
                    //console.log($("input[name=exdayIn]"));
                }
                $("input[name=edSelect]")[1].onclick=()=>{
                	$("input[type=date]").attr("disabled",true);
                	//console.log($("input[name=exdayIn]"));
                }
                $("input[name=edSelect]")[2].onclick=()=>{
                	$("input[name=costIn]").attr("disabled",true);
                	//console.log($("input[name=exdayIn]"));
                }
            </script>
            <div id="option" style="display: flex;">
                <span style="margin-right: 30px;">옵션</span>
                &nbsp;
                <label><input type="radio" onclick="fn_no()" class="radio" name="optionR" value="6">없음 </label>&nbsp;&nbsp;
                <label><input type="radio" onclick="fn_yes()" id="optionY" class="radio" name="optionR" >있음 </label>&nbsp;&nbsp;
                
                <div id="optionAll" hidden>
                    <label><input type="checkbox" class="checkbox selectOpt" id="opt1" name="option" value="1" >에어컨 </label>&nbsp;
                    <label><input type="checkbox" class="checkbox selectOpt" id="opt2" name="option" value="2" >세탁기 </label>&nbsp;
                    <label><input type="checkbox" class="checkbox selectOpt" id="opt3" name="option" value="3" >냉장고 </label>&nbsp;
                    <label><input type="checkbox" class="checkbox selectOpt" id="opt4" name="option" value="4" >인덕션 </label>&nbsp;
                    <label><input type="checkbox" class="checkbox selectOpt" id="opt5" name="option" value="5" >전자렌지 </label>&nbsp;
                    <label><input type="checkbox" class="checkbox" name="option" value="6" id="optionNo" hidden></label>
                </div>
            </div>
            <br>
            <hr style="width: 95%;">
            <script>
                const fn_no=()=>{
                    $("#optionNo").prop("checked",true);
                    $("#optionAll").hide();
                    // console.dir($(".selectOpt")[0]);
                    // const select = $(".selectOpt");
                    $("#opt1").prop("checked",false);
                    $("#opt2").prop("checked",false);
                    $("#opt3").prop("checked",false);
                    $("#opt4").prop("checked",false);
                    $("#opt5").prop("checked",false);
                }
                const fn_yes=()=>{
                    $("#optionNo").prop("checked",false);
                    $("#optionAll").show();
                }
            </script>
<!--------------------------------------------------------------------------------------------------------------------------------------------------->	
            <h2>🔳 추가 정보</h2>
            <div id="animal">
                <span>반려동물가능여부</span>
                &nbsp;
                <label><input type="radio" value="Y" id="petY" name="petSelect" class="radio">가능</label> &nbsp;
                <label><input type="radio" value="N" id="petN" name="petSelect" class="radio">불가능</label> &nbsp;
            </div>
            <br>
            <div id="parking">
                <span style="margin-right: 30px;">주차가능여부</span>
                &nbsp;&nbsp;
                <label><input type="radio" value="Y" id="parkingY" name="parkSelect" class="radio">가능</label> &nbsp;
                <label><input type="radio" value="N" id="parkingN" name="parkSelect" class="radio">불가능</label> &nbsp;
            </div>
            <br>
            <script>
            	window.onload = function () {
            		//반려동물
            		<%if(property.getPet()=='Y'){%>
            			$("#petY").prop("checked",true);
            		<%}else{%>
            			$("#petN").prop("checked",true);
            		<%}%>
            		
            		//주차
            		<%if(property.getParking()=='Y'){%>
	        			$("#parkingY").prop("checked",true);
	        		<%}else{%>
	        			$("#parkingN").prop("checked",true);
	        		<%}%>
            	}
            </script>
            <div id="comment" style="display: flex; align-items: center;"> 
                <span>상세 설명</span>
                &nbsp; &nbsp; &nbsp; &nbsp;
                <textarea cols="100" rows="20" name="detail" style="resize: none;" placeholder="3000자 이내로 작성해주세요">
                	<%=property.getDetail()%>
                </textarea>
            </div>
			<br>
            <hr style="width: 95%;">
<!--------------------------------------------------------------------------------------------------------------------------------------------------->			
            <h2>🔳 사진</h2>
            <div id="mainPhoto">
                <fieldset style="width: 200px;">
                    <legend style="font-size: 20px; color: red;"><b>메인 사진</b></legend>
                    <img src="<%=request.getContextPath()%>/images/YJ/사진추가하기.png" id="mainPhoto"
                        name="mainPhoto" onclick="fn_upfile();" width="200px" height="200px">
                    <input type="file" name="mainFile" style="display: none;">
                </fieldset>
                &nbsp; &nbsp;
            </div>
            <div id="photo">
                <fieldset style="width: 80%; display: flex; justify-content:space-between ;">
                    <legend style="font-size: 20px;"><b>사진</b></legend>
                    <img src="<%=request.getContextPath()%>/images/YJ/사진추가하기.png" name="photo1" width="150px" height="150px">
                    
                    <img src="<%=request.getContextPath()%>/images/YJ/사진추가하기.png" name="photo2" width="150px" height="150px">
                    
                    <img src="<%=request.getContextPath()%>/images/YJ/사진추가하기.png" name="photo3" width="150px" height="150px">
                    
                    <img src="<%=request.getContextPath()%>/images/YJ/사진추가하기.png" name="photo4" width="150px" height="150px">
                </fieldset>
            </div>
            <br><br>

            <div id="addroom" style="text-align:center">
                <input type="submit" class="greenbutton" id="insertbtn" value="수정하기">
            </div>
            <br>
        </div>

<!--------------------------------------------------------------------------------------------------------------------------------------------------->
        <!-- 네비게이션 바 -->
        <div id="navi">
            <h3>기본정보</h3>
            <a href="#address" class="aTag">주소</a> <br>
            <a href="#floor" class="aTag">층수</a> <br>
            <hr>

            <h3>거래정보</h3>
            <a href="#price" class="aTag">거래종류(금액)</a> <br>
            <a href="#cost" class="aTag">관리비</a> <br>
            <a href="#costInclude" class="aTag">관리비 포함항목</a> <br>
            <hr>

            <h3>방 정보</h3>
            <a href="#room" class="aTag">방 구조</a> <br>
            <a href="#area" class="aTag">면적</a> <br>
            <a href="#option" class="aTag">옵션</a> <br>
            <a href="#expiryDate" class="aTag">공실예정일</a> <br>
            <hr>

            <h3>추가 정보</h3>
            <a href="#animal" class="aTag">반려동물가능여부</a> <br>
            <a href="#parking" class="aTag">주차가능여부</a> <br>
            <a href="#comment" class="aTag">상세 설명</a> <br>
            <hr> 

            <h3>사진</h3>
            <a href="#photo" class="aTag">방사진</a> <br>
        </div>
	</section>
</form>
<!--------------------------------------------------------------------------------------------------------------------------------------------------->
    <script>
        const fn_invalidate=()=>{
    
            //전월세입력
            const yPrice=$("input[name=yPrice]").val().trim();
            const mPrice=$("input[name=mPrice]").val().trim();
            const mPrice2=$("input[name=mPrice2]").val().trim();
            if(yPrice.length==0 && mPrice.length==0 && mPrice2.length==0) {
                alert("금액을 입력하세요!");
                $("#insertPrice").focus();
    			return false;
            }
            
            //관리비 입력
            const costIn = $("input[name=costIn]").val().trim();
            if($("#costYes").prop("checked")==true){
	            if(costIn.length==0) {
	                alert("관리비를 입력하세요!");
	    			return false;
	            }
            }
            
            //옵션 선택
            if($("#optionY").prop("checked")==true && (
                $("#opt1").prop("checked")==false && $("#opt2").prop("checked")==false && $("#opt3").prop("checked")==false
                && $("#opt4").prop("checked")==false && $("#opt5").prop("checked")==false)){
                    alert("옵션을 체크해주세요!");
                    $("#optionY").focus();
                    return false;
            }
        }
    </script>
    
<%@ include file="/views/common/footer.jsp" %>